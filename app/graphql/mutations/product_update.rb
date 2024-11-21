# frozen_string_literal: true

module Mutations
  class ProductUpdate < BaseMutation
    description "Updates an existing product"

    field :product, Types::ProductType, null: false

    # Arguments
    argument :id, ID, required: true, description: "The ID of the product to update"
    argument :name, String, required: false, description: "The name of the product"
    argument :type, String, required: false, description: "The type/category of the product (e.g., Golf, Luggage)"
    argument :length, Integer, required: false, description: "The length of the product in inches"
    argument :width, Integer, required: false, description: "The width of the product in inches"
    argument :height, Integer, required: false, description: "The height of the product in inches"
    argument :weight, Integer, required: false, description: "The weight of the product in pounds"

    def resolve(id:, **attributes)
      # Find the product by its ID
      product = Product.where(id: id).first
      raise GraphQL::ExecutionError.new("Product not found") unless product

      # Update the product with provided attributes
      unless product.update(attributes.compact)
        raise GraphQL::ExecutionError.new("Error updating product", extensions: product.errors.to_hash)
      end

      { product: product }
    end
  end
end
