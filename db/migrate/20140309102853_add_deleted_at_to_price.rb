class AddDeletedAtToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :deleted_at, :datetime
    add_index :prices, :deleted_at
  end
end
