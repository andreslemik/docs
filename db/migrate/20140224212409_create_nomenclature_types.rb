class CreateNomenclatureTypes < ActiveRecord::Migration
  def change
    create_table :nomenclature_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
