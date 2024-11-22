# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    description "A type that represents a product in the catalog"

    field :id, ID, null: false, description: "The unique ID of the product"
    field :name, String, null: false, description: "The name of the product"
    field :type, String, null: false, description: "The type/category of the product (e.g., Golf, Luggage)"
    field :length, Integer, null: false, description: "The length of the product in inches"
    field :width, Integer, null: false, description: "The width of the product in inches"
    field :height, Integer, null: false, description: "The height of the product in inches"
    field :weight, Integer, null: false, description: "The weight of the product in pounds"

    field :calculator_results, [Types::CalculatorResultType], null: true
  end
end
