class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.string :attachment
      t.references :user, index: true
      t.integer :parent_id, index: true

      t.timestamps
    end
  end
end
