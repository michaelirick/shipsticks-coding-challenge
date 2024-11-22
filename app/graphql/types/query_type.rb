# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :products, [Types::ProductType], null: false do
      argument :limit, Integer, required: false, default_value: 10
      argument :offset, Integer, required: false, default_value: 0  
      argument :type, String, required: false
    end
    
    def products(type: nil, limit:, offset:)
      (type ? Product.where(type: type) : Product.all).limit(limit).offset(offset)
    end

    # Field to find the closest matching product
    field :closest_product, Types::ProductType, null: true do
      description "Retrieve the closest matching product based on dimensions and weight"
      argument :length, Integer, required: true, description: "The length of the product in inches"
      argument :width, Integer, required: true, description: "The width of the product in inches"
      argument :height, Integer, required: true, description: "The height of the product in inches"
      argument :weight, Integer, required: true, description: "The weight of the product in pounds"
    end

    def closest_product(length:, width:, height:, weight:)
      Product.all.min_by do |product|
        (
          (product.length - length).abs +
          (product.width - width).abs +
          (product.height - height).abs +
          (product.weight - weight).abs
        )
      end
    end    
  end
end
