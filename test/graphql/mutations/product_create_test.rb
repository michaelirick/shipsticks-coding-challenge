require 'test_helper'

class ProductCreateTest < ActionDispatch::IntegrationTest
  setup do
    @mutation = <<~GRAPHQL
    mutation createProduct($input: ProductCreateInput!){
      productCreate(input: $input){
        product{
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
  end

  test "creates a product successfully" do
    variables = {
      input: {
        name: "Small Package",
        type: "Golf",
        length: 48,
        width: 14,
        height: 12,
        weight: 42
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    product_data = response_data['data']['productCreate']['product']
    
    assert_equal "Small Package", product_data['name']
    assert_equal "Golf", product_data['type']
    assert_equal 48, product_data['length']
    assert_equal 14, product_data['width']
    assert_equal 12, product_data['height']
    assert_equal 42, product_data['weight']
  end

  test "fails to create a product with missing required fields" do
    variables = {
      input: {
        name: "Incomplete Package"
        # Missing fields: type, length, width, height, weight
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    assert_nil response_data['data']
    assert_match "Variable $input of type ProductCreateInput! was provided invalid value for type (Expected value to not be null), length (Expected value to not be null), width (Expected value to not be null), height (Expected value to not be null), weight (Expected value to not be null)", response_data['errors'][0]['message']
  end  
end
