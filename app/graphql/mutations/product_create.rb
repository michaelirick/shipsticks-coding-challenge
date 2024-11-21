# frozen_string_literal: true

module Mutations
  class ProductCreate < BaseMutation
    description "Creates a new product"

    field :product, Types::ProductType, null: false

    argument :name, String, required: true, description: "The name of the product"
    argument :type, String, required: true, description: "The type/category of the product (e.g., Golf, Luggage)"
    argument :length, Integer, required: true, description: "The length of the product in inches"
    argument :width, Integer, required: true, description: "The width of the product in inches"
    argument :height, Integer, required: true, description: "The height of the product in inches"
    argument :weight, Integer, required: true, description: "The weight of the product in pounds"

    def resolve(name:, type:, length:, width:, height:, weight:)
      product = ::Product.new(
        name: name,
        type: type,
        length: length,
        width: width,
        height: height,
        weight: weight
      )
      raise GraphQL::ExecutionError.new "Error creating product", extensions: product.errors.to_hash unless product.save

      { product: product }
    end
  end
end
