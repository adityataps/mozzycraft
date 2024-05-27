data "aws_caller_identity" "main" {}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.mozzy_craft_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.mozzy_craft_api.execution_arn}/*/*"
}

resource "aws_lambda_function" "mozzy_craft_lambda" {
  filename         = "./lambda.zip"
  function_name    = "mozzy_craft_lambda"
  role             = aws_iam_role.role.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("./lambda.zip")
  tags = {
    project = "mozzy_craft"
  }
}

# IAM
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "mozzy_craft_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
