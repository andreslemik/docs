class AddStateToRevise < ActiveRecord::Migration
  def change
    add_column :revises, :state, :string
  end
end
