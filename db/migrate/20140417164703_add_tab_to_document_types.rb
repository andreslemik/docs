class AddTabToDocumentTypes < ActiveRecord::Migration
  def change
    add_column :document_types, :tab, :integer
  end
end
