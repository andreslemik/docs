class AddDeletedToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :deleted, :boolean, default: false
  end
end
