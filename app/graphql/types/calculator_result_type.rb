module Types
  class CalculatorResultType < Types::BaseObject
    description "A type representing a saved calculator result"

    field :id, ID, null: false
    field :length, Integer, null: false
    field :width, Integer, null: false
    field :height, Integer, null: false
    field :weight, Integer, null: false
    field :product, Types::ProductType, null: true, description: "The associated product (optional)"
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
