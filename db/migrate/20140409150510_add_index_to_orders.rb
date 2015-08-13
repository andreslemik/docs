class AddIndexToOrders < ActiveRecord::Migration
  def change
    execute 'create index created_at_date_idx ON orders (DATE(created_at))'
  end
end
