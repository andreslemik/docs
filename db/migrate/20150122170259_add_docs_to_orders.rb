class AddDocsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :docs, :boolean, default: false
  end
end
