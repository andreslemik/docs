class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :nomenclature, index: true
      t.string :partner_number, index: true
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
