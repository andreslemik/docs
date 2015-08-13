class AddFileToRevise < ActiveRecord::Migration
  def change
    add_column :revises, :file, :string
  end
end
