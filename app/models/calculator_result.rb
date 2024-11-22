class CalculatorResult
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  # Relationships
  belongs_to :product, class_name: 'Product', optional: true

  # Validations
  validates :length, :width, :height, :weight, presence: true
  validates :length, :width, :height, :weight, numericality: { greater_than: 0 }
end
