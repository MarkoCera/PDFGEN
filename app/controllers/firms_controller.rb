class FirmsController < ApplicationController

  def index
    @firme = Firma.all
  end

  def select
    @firma = Firma.find_by(id: params[:id])
    if @firma
      session[:firma_id] = @firma.id 
      redirect_to proizvodi_index_path
    else
      flash[:error] = "Firma nije pronađena."
      redirect_to firms_path
    end
  end  
end
