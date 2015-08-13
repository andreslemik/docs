class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :message, index: true
      t.references :user, index: true
      t.boolean :readed, default: false

      t.timestamps
    end
  end
end
