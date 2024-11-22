# frozen_string_literal: true

module Mutations
  class ProductDelete < BaseMutation
    description "Deletes a product by ID"

    field :product, Types::ProductType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      product = Product.where(id: id).first
      raise GraphQL::ExecutionError.new("Product not found") unless product

      raise GraphQL::ExecutionError.new("Error deleting product", extensions: product.errors.to_hash) unless product.destroy

      { product: product }
    end
  end
end
