namespace :import do
  desc 'import product data from json'
  task products: :environment do
    ProductImportService.new('db/seeds/products.json').import
  end
end