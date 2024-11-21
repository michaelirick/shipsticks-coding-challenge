class ProductImportService
  def initialize(file_path)
    @file_path = file_path
  end

  def import
    json = File.read(@file_path)
    products = JSON.parse(json)
    products['products'].each do |row|
      Product.create!(
        name: row['name'],
        product_type: row['type'],
        length: row['length'],
        width: row['width'],
        height: row['height'],
        weight: row['weight']
      )
    end
  end
end