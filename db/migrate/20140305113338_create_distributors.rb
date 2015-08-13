class CreateDistributors < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
