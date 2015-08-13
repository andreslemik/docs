class AddFieldsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :doc_date, :date
    add_column :documents, :doc_no, :string
    add_column :documents, :memo, :text
  end
end
