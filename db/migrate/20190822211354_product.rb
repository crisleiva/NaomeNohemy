class Product < ActiveRecord::Migration[5.2]
    def change
        create_table :products do |t|
            t.string :name
            t.decimal :price
            t.text :description
            t.boolean :in_stock, :null => false
            t.string :image
            
        end
    end
end
