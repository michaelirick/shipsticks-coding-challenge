module Mutations
  class CalculatorResultSave < BaseMutation
    description "Saves a calculator result with associated dimensions and product"

    # Return fields
    field :calculator_result, Types::CalculatorResultType, null: false

    # Arguments
    argument :length, Integer, required: true, description: "The length of the result in inches"
    argument :width, Integer, required: true, description: "The width of the result in inches"
    argument :height, Integer, required: true, description: "The height of the result in inches"
    argument :weight, Integer, required: true, description: "The weight of the result in pounds"
    argument :product_id, ID, required: true, description: "The ID of the associated product"

    def resolve(length:, width:, height:, weight:, product_id: nil)
      product = Product.where(id: product_id).first if product_id

      calculator_result = CalculatorResult.new(
        length: length,
        width: width,
        height: height,
        weight: weight,
        product: product
      )

      unless calculator_result.save
        raise GraphQL::ExecutionError.new("Error saving calculator result", extensions: calculator_result.errors.to_hash)
      end

      { calculator_result: calculator_result }
    end
  end
end
