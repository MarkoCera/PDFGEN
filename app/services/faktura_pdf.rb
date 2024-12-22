require 'prawn'
require 'prawn/table'
include ActionView::Helpers::NumberHelper

class FakturaPdf

  def initialize(firma_id , proizvod_ids , kolicine )
    
    @firma = Firma.find_by( id: firma_id )
    raise "Firma not found" unless @firma

    @proizvodi = Proizvod.where(id: proizvod_ids)

    @kolicine = kolicine

    @pdf = Prawn::Document.new
    @pdf.font_families.update("NotoSans" => {
      normal: "app/assets/fonts/NotoSans-Regular.ttf",
      bold: "app/assets/fonts/NotoSans-Bold.ttf",
      italic: "app/assets/fonts/NotoSans-Italic.ttf",
      bold_italic: "app/assets/fonts/NotoSans-BoldItalic.ttf"
    })
    @pdf.font "NotoSans"

    header
    content
    footer
  end

  def render
    @pdf.render
  end

  private

  def header
    @pdf.bounding_box([0, @pdf.cursor], width: 500) do
      @pdf.image "/home/cera/PDFGEN/app/assets/images/logo.jpg", width: 100, height: 100
      @pdf.move_up 50
      @pdf.text "FAKTURA", size: 30, style: :bold, align: :right
      @pdf.text "Matični Broj: 07032501", align: :right
      @pdf.text "PIB: 100209517", align: :right
    end
    @pdf.move_down 20
    @pdf.stroke_horizontal_rule
    @pdf.pad(20) {
      @pdf.bounding_box([0, @pdf.cursor], width: 500) do
        @pdf.text "Univerzitet u Beogradu, Mašinski fakultet", size: 15
        @pdf.move_up 25
        @pdf.text "Datum: #{Date.today}", size: 10, align: :right
        #@pdf.text "Broj fakture:", size: 10, align: :right
        @pdf.text "ID klijenta: #{@firma.id}", size: 10, align: :right
      end
    }
    @pdf.stroke_horizontal_rule
    @pdf.move_down 20
  end

  def content
    @pdf.text "Ime preduzeća: #{@firma.naziv}", size: 10
    @pdf.text "PIB: #{@firma.pib}", size: 10
    @pdf.text "Ulica i broj: #{@firma.adresa}", size: 10
    @pdf.text "Telefon: #{@firma.telefon}", size: 10
    @pdf.text "Mail: #{@firma.mail}", size: 10
    @pdf.move_down 20

    table_data = [
      ["Stavka", "Šifra", "Količina","JM" ,"Cena", "Vrednost"]]

    @suma = 0

    @proizvodi.each do |proizvod|

      kolicina = @kolicine[proizvod.id.to_s].to_i  
      cena = proizvod.cena
      @suma += cena * kolicina  
      table_data << [
        proizvod.naziv,
        proizvod.sifra,
        kolicina,
        proizvod.JM,
        "#{number_with_delimiter('%.2f' % cena)} RSD", 
        "#{number_with_delimiter('%.2f' % ( cena * kolicina ))} RSD"
      ]    end

    @pdf.table(table_data, header: true, width: 500 , cell_style: { size: 10 }) do
      row(0).font_style = :bold
      row(0).background_color = 'cccccc'
    end
    @pdf.move_down 20
  end

  def footer
    @pdf.stroke_horizontal_rule
    @pdf.text "Ukupna vrednost: #{number_with_delimiter('%.2f' % @suma)} RSD", size: 15, style: :bold, align: :right
    @pdf.move_down 10

    @pdf.bounding_box([0, @pdf.cursor], width: 200, height: 30) do
      @pdf.draw_text "M.P.", at: [0, @pdf.cursor], size: 12
      @pdf.stroke_line([30, @pdf.cursor], [200, @pdf.cursor])
      @pdf.move_down 5
      @pdf.text "Potpis ovlašćenog lica", size: 10, align: :center
    end
    
    @pdf.text "Hvala što sarađujete sa nama!", size: 12, style: :bold, align: :center
    @pdf.text "Kraljice Marije 16, Beograd, 11120, tel (+381 11) 3302-200, faks 3370364, mf@mas.bg.ac.rs", align: :center
  end
end
