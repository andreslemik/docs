class AddArchivedToNomenclatures < ActiveRecord::Migration
  def change
    add_column :nomenclatures, :archived, :boolean, default: false
  end
end
