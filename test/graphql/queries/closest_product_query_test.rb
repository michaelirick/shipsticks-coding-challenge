require 'test_helper'

class ClosestProductQueryTest < ActionDispatch::IntegrationTest
  setup do
    Product.delete_all
    @query = <<~GRAPHQL
      query GetClosestProduct($length: Int!, $width: Int!, $height: Int!, $weight: Int!) {
        closestProduct(length: $length, width: $width, height: $height, weight: $weight) {
          id
          name
          type
          length
          width
          height
          weight
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

    @product3 = Product.create!(
      name: "Extra Large Package",
      type: "Luggage",
      length: 72,
      width: 24,
      height: 18,
      weight: 60
    )
  end

  test "retrieves the closest matching product" do
    variables = {
      length: 50,
      width: 15,
      height: 13,
      weight: 45
    }

    post '/graphql',
         params: { query: @query, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    product_data = response_data['data']['closestProduct']
    assert_equal @product2.id.to_s, product_data['id']
    assert_equal "Large Package", product_data['name']
  end

  test "returns nil when no products exist" do
    Product.delete_all

    variables = {
      length: 50,
      width: 15,
      height: 13,
      weight: 45
    }

    post '/graphql',
         params: { query: @query, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    assert_nil response_data['data']['closestProduct']
  end
end
