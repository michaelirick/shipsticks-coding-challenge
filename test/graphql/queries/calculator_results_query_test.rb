require 'test_helper'

class CalculatorResultsQueryTest < ActionDispatch::IntegrationTest
  setup do
    Product.delete_all
    CalculatorResult.delete_all
    @query = <<~GRAPHQL
      query GetAllCalculatorResults() {
        calculatorResults {
          id
          length
          width
          height
          weight
          product {
            id
            name
            type
          }
        }
      }
    GRAPHQL

    # Seed data
    @product1 = Product.create!(
      name: "Small Package",
      type: "Golf",
      length: 48,
      width: 14,
      height: 12,
      weight: 42
    )
    @product2 = Product.create!(
      name: "Large Package",
      type: "Luggage",
      length: 60,
      width: 20,
      height: 15,
      weight: 50
    )

    @result1 = CalculatorResult.create!(
      length: 48,
      width: 14,
      height: 12,
      weight: 42,
      product: @product1
    )

    @result2 = CalculatorResult.create!(
      length: 60,
      width: 20,
      height: 15,
      weight: 50,
      product: @product2
    )
  end

  test "retrieves all calculator results successfully" do
    post '/graphql',
         params: { query: @query, variables: {} }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    calculator_results = response_data['data']['calculatorResults']
    assert_equal 2, calculator_results.size

    # Verify calculator result 1 details
    assert_equal @result1.id.to_s, calculator_results[0]['id']
    assert_equal 48, calculator_results[0]['length']
    assert_equal 14, calculator_results[0]['width']
    assert_equal 12, calculator_results[0]['height']
    assert_equal 42, calculator_results[0]['weight']
    assert_equal @product1.id.to_s, calculator_results[0]['product']['id']
    assert_equal "Small Package", calculator_results[0]['product']['name']
    assert_equal "Golf", calculator_results[0]['product']['type']

    # Verify calculator result 2 details
    assert_equal @result2.id.to_s, calculator_results[1]['id']
    assert_equal 60, calculator_results[1]['length']
    assert_equal 20, calculator_results[1]['width']
    assert_equal 15, calculator_results[1]['height']
    assert_equal 50, calculator_results[1]['weight']
    assert_equal @product2.id.to_s, calculator_results[1]['product']['id']
    assert_equal "Large Package", calculator_results[1]['product']['name']
    assert_equal "Luggage", calculator_results[1]['product']['type']
  end
end