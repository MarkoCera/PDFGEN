class Proizvod < ApplicationRecord
  self.table_name = "PROIZVOD"
  validates :sifra, presence: true, length: { is: 5 }
  validates :naziv, presence: true
  validates :cena, numericality: { greater_than_or_equal_to: 0 }
  validates :jm, presence: true , length: { is: 3 }

  def self.ispisi_proizvode
    puts "Spisak proizvoda:"
    Proizvod.all.each do |proizvod|
      puts "ID:#{proizvod.id}, Naziv: #{proizvod.naziv}"
    end
  end
end
