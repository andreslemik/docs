class CreateNomenclatures < ActiveRecord::Migration
  def change
    create_table :nomenclatures do |t|
      t.string :name
      t.text :full_name
      t.string :partner_number
      t.references :nomenclature_type, index: true

      t.timestamps
    end
    
    add_index(:nomenclatures, :name)
    add_index(:nomenclatures, :partner_number)
  end
end
