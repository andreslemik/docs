class AddSummaToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :summa, :decimal, precision: 8, scale: 2
  end
end
