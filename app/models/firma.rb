class Firma < ApplicationRecord
    self.table_name = "FIRMA"

    validates :id, presence: true
    validates :pib, presence: true, length: { is: 9 }, uniqueness: true
    validates :naziv, presence: true
    validates :adresa, presence: true
    validates :telefon, length: { maximum: 20 }, allow_blank: true
    validates :mail, length: { maximum: 50 }, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  

    def self.ispisi_firme
      puts "Spisak firmi:"
      Firma.all.each do |firma|
        puts "ID: #{firma.id}, Naziv: #{firma.naziv}"
      end
    end
  
    
  
    # Možeš dodati metode ako je potrebno
  end
  

