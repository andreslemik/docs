class AddFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :content_type, :string
    add_column :messages, :file_size, :integer
  end
end
