class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :distributor, index: true
      t.references :user, index: true
      t.text :memo

      t.timestamps
    end
  end
end
