require 'test_helper'

class ProductDeleteTest < ActionDispatch::IntegrationTest
  setup do
    @mutation = <<~GRAPHQL
      mutation deleteProduct($input: ProductDeleteInput!){
        productDelete(input: $input){
          product {
            id
          }
        }
    }
    GRAPHQL

    # Create a product to test deletion
    @product = Product.create!(
      name: "Deletable Product",
      type: "Golf",
      length: 50,
      width: 20,
      height: 15,
      weight: 30
    )
  end

  test "deletes a product successfully" do
    variables = {
      input: {
        id: @product.id.to_s
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(@response.body)

    refute_nil response_data['data']['productDelete']['product']

    # Verify the product is deleted
    assert_nil Product.where(id: @product.id).first
  end

  test "fails to delete a non-existent product" do
    variables = {
      input: {
        id: "64bfdb70f15b5b2e9b5b4c34" # Non-existent ID
      }
    }

    post '/graphql',
         params: { query: @mutation, variables: variables }.to_json,
         headers: { 'Content-Type' => 'application/json' }

    assert_response :unprocessable_entity
    response_data = JSON.parse(@response.body)

    assert_nil response_data['data']['productDelete']
    assert_match "Product not found", response_data['errors'][0]['message']
  end
end
