class ProductCategory < ActiveRecord::Migration[5.2]
    def change
        create_table :productcategories do |t|
            t.references :product, foreign_key: true
            t.references :category, foreign_key: true
        end
    end
end
