class CreateFirmas < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:firmas)
    create_table :firmas do |t|
      t.string :pib, null: false
      t.string :naziv, null: false
      t.string :adresa, null: false
      t.string :telefon
      t.string :mail
      t.timestamps
    end
  end
end
end
