class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :distributor, index: true
      t.references :nomenclature, index: true
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
