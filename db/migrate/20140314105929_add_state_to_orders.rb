class AddStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string
    add_index :orders, :state
  end
end
