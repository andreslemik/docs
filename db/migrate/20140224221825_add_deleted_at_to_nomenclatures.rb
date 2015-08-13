class AddDeletedAtToNomenclatures < ActiveRecord::Migration
  def change
    add_column :nomenclatures, :deleted_at, :datetime
    add_index :nomenclatures, :deleted_at
  end
end
