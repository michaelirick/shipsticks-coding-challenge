require 'pry'
require 'test_helper'

class ProductUpdateTest < ActionDispatch::IntegrationTest
  setup do
    @mutation = <<~GRAPHQL
      mutation UpdateProduct($input: ProductUpdateInput!) {
        productUpdate(
          input: $input
        ) {
          product {
            id
            name
            type
            length
            width
            height
            weight
          }
        }
      }
    GRAPHQL

    # Create a product to test updates
    @product = Product.create!(
      name: "Original Product",
      type: "Golf",
      length: 50,
      width: 20,
      height: 15,
      weight: 30
    )
  end

  test "updates a product successfully" do
    variables = {
      input: {
        id: @product.id.to_s,
        name: "Updated Product",
        type: "Luggage",
        length: 60,
        width: 25,
        height: 20,
        weight: 40
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    product_data = response_data['data']['productUpdate']['product']

    assert_equal "Updated Product", product_data['name']
    assert_equal "Luggage", product_data['type']
    assert_equal 60, product_data['length']
    assert_equal 25, product_data['width']
    assert_equal 20, product_data['height']
    assert_equal 40, product_data['weight']
  end

  test "updates a partial product successfully" do
    variables = {
      input: {
        id: @product.id.to_s,
        name: "Updated Product"
      }
    }

    post '/graphql',
          params: { query: @mutation, variables: variables }.to_json,
          headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)
    
    product_data = response_data['data']['productUpdate']['product']

    assert_equal "Updated Product", product_data['name']
    assert_equal "Golf", product_data['type']
  end

  test "fails to update a non-existent product" do
    variables = {
      input: {
        id: "64bfdb70f15b5b2e9b5b4c34", # Non-existent ID
        name: "Non-Existent Product"
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    assert_nil response_data['data']['productUpdate']
    assert_match "Product not found", response_data['errors'][0]['message']
  end
end
