require 'test_helper'

class ProductsQueryTest < ActionDispatch::IntegrationTest
  setup do
    Product.delete_all
    @query = <<~GRAPHQL
      query GetAllProducts($type: String, $limit: Int, $offset: Int) {
        products(type: $type, limit: $limit, offset: $offset) {
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
  end

  test "retrieves all products successfully" do
    post '/graphql',
         params: { query: @query, variables: {} }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    products = response_data['data']['products']
    assert_equal 2, products.size

    # Verify product 1 details
    assert_equal @product1.id.to_s, products[0]['id']
    assert_equal "Small Package", products[0]['name']
    assert_equal "Golf", products[0]['type']
    assert_equal 48, products[0]['length']
    assert_equal 14, products[0]['width']
    assert_equal 12, products[0]['height']
    assert_equal 42, products[0]['weight']

    # Verify product 2 details
    assert_equal @product2.id.to_s, products[1]['id']
    assert_equal "Large Package", products[1]['name']
    assert_equal "Luggage", products[1]['type']
  end

  test "retrieves products filtered by type" do
    variables = { type: "Golf" }

    post '/graphql',
         params: { query: @query, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    products = response_data['data']['products']
    assert_equal 1, products.size

    # Verify filtered product
    assert_equal @product1.id.to_s, products[0]['id']
    assert_equal "Small Package", products[0]['name']
    assert_equal "Golf", products[0]['type']
  end

  test "retrieves an empty list when no products match the filter" do
    variables = { type: "NonExistentType" }

    post '/graphql',
         params: { query: @query, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    products = response_data['data']['products']
    assert_empty products
  end

  test "retrieves paginated products" do
    variables = { limit: 1, offset: 0 }

    post '/graphql',
         params: { query: @query, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    products = response_data['data']['products']
    assert_equal 1, products.size

    # Verify product 1 is returned
    assert_equal @product1.id.to_s, products[0]['id']
  end

  test "retrieves an empty list when no products exist" do
    Product.delete_all

    post '/graphql',
         params: { query: @query, variables: {} }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    products = response_data['data']['products']
    assert_empty products
  end
end
