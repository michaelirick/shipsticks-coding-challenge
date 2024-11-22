require 'test_helper'
require 'pry'
class SaveCalculatorResultTest < ActionDispatch::IntegrationTest
  setup do
    @mutation = <<~GRAPHQL
      mutation CalculatorResultSave($input: CalculatorResultSaveInput!) {
        calculatorResultSave(input: $input) {
          calculatorResult {
            id
            length
            width
            height
            weight
            product {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    @product = Product.create!(
      name: "Small Package",
      type: "Golf",
      length: 48,
      width: 14,
      height: 12,
      weight: 42
    )
  end

  test "saves a calculator result with an associated product" do
    variables = {
      input: {
        length: 48,
        width: 14,
        height: 12,
        weight: 42,
        productId: @product.id.to_s
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    calculator_result_data = response_data['data']['calculatorResultSave']['calculatorResult']

    assert_equal 48, calculator_result_data['length']
    assert_equal 14, calculator_result_data['width']
    assert_equal 12, calculator_result_data['height']
    assert_equal 42, calculator_result_data['weight']
    assert_equal @product.id.to_s, calculator_result_data['product']['id']
    assert_equal @product.name, calculator_result_data['product']['name']
  end

  test "does not save a calculator result without an associated product" do
    variables = {
      length: 60,
      width: 20,
      height: 15,
      weight: 50
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    errors = response_data['errors']
    assert_not_empty errors
    assert_equal "Variable $input of type CalculatorResultSaveInput! was provided invalid value", errors.first['message']
  end
end
