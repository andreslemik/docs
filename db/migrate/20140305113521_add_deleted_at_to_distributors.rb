class AddDeletedAtToDistributors < ActiveRecord::Migration
  def change
    add_column :distributors, :deleted_at, :datetime
    add_index :distributors, :deleted_at
  end
end
