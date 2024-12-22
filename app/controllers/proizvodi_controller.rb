class ProizvodiController < ApplicationController

  def index
    @proizvodi = Proizvod.all
    @firma_id = session[:firma_id]
    
    if @firma_id.nil?
      flash[:error] = "Nijedna firma nije odabrana."
      redirect_to firms_path
    end
  end

  def select
    proizvod_ids = params[:proizvod_ids]
    kolicine = params[:kolicine] || {}
  
    if proizvod_ids.present?
      session[:proizvod_ids] = proizvod_ids
      firma_id = session[:firma_id]
  
      pdf = FakturaPdf.new(firma_id, proizvod_ids, kolicine)
      send_data pdf.render, filename: "faktura.pdf", type: 'application/pdf', disposition: 'inline'
    else
      flash[:error] = "Nijedan proizvod nije izabran."
      redirect_to proizvodi_index_path
    end
  end
end

