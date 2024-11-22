# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :product_delete, mutation: Mutations::ProductDelete
    field :product_update, mutation: Mutations::ProductUpdate
    field :product_create, mutation: Mutations::ProductCreate
    field :calculator_result_save, mutation: Mutations::CalculatorResultSave
  end
end
