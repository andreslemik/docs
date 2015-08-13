class CreateRevises < ActiveRecord::Migration
  def change
    create_table :revises do |t|
      t.date :date_begin
      t.date :date_end
      t.text :memo
      t.references :distributor, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
