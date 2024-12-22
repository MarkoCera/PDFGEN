class CreateProizvods < ActiveRecord::Migration[7.2]
  def change
    create_table :proizvods do |t|
      t.string :sifra, null: false
      t.string :naziv, null: false
      t.decimal :cena, precision: 18, scale: 4, null: false
      t.string :JM, null:false
      t.timestamps
    end
  end
end
