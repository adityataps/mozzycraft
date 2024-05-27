resource "aws_api_gateway_rest_api" "mozzy_craft_api" {
  name = "mozzy_craft_api"
  tags = {
    project = "mozzy_craft"
  }
}

resource "aws_api_gateway_resource" "mozzy_craft_api" {
  parent_id   = aws_api_gateway_rest_api.mozzy_craft_api.root_resource_id
  path_part   = "mozzy_craft_api"
  rest_api_id = aws_api_gateway_rest_api.mozzy_craft_api.id
}

resource "aws_api_gateway_method" "mozzy_craft_api" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.mozzy_craft_api.id
  rest_api_id   = aws_api_gateway_rest_api.mozzy_craft_api.id
}

resource "aws_api_gateway_integration" "mozzy_craft_api" {
  http_method             = aws_api_gateway_method.mozzy_craft_api.http_method
  resource_id             = aws_api_gateway_resource.mozzy_craft_api.id
  rest_api_id             = aws_api_gateway_rest_api.mozzy_craft_api.id
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.mozzy_craft_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "mozzy_craft_api" {
  rest_api_id = aws_api_gateway_rest_api.mozzy_craft_api.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.mozzy_craft_api.id,
      aws_api_gateway_method.mozzy_craft_api.id,
      aws_api_gateway_integration.mozzy_craft_api.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "mozzy_craft_api" {
  deployment_id = aws_api_gateway_deployment.mozzy_craft_api.id
  rest_api_id   = aws_api_gateway_rest_api.mozzy_craft_api.id
  stage_name    = "mozzy_craft_api"
}
