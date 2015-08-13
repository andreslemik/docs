class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :file
      t.references :order, index: true

      t.timestamps
    end
  end
end
