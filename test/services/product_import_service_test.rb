require "test_helper"

class ProductImportServiceTest < ActiveSupport::TestCase
  test "import" do
    file_path = Rails.root.join('test', 'fixtures', 'files', 'products.json')
    assert_difference("Product.count") do
      ProductImportService.new(file_path).import
    end
  end
end
