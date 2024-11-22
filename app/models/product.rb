class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  has_many :calculator_results, class_name: 'CalculatorResult', dependent: :destroy

  validates :name, :type, :length, :width, :height, :weight, presence: true

  # validate that the dimensions are positive
  validates :length, :width, :height, :weight, numericality: { greater_than: 0 }

  def self.closest_match(length, width, height, weight)
    # first we'll grab all the products that exceed the dimensions
    products = Product.where(:length.gte => length, :width.gte => width, :height.gte => height, :weight.gte => weight)

    # then we'll sort them by the sum of the differences between the dimensions
    products.sort_by do |product|
      (product.length - length).abs + (product.width - width).abs + (product.height - height).abs + (product.weight - weight).abs
    end

    # finally, we'll return the product with the smallest sum of differences
    products.first
  end
end
