class ExhibitionController < ApplicationController
  
  def index
    @today_date  = Date.today
    date = params[:date] || @today_date
    @date = date.to_date 
    #@bites = Bite.on(@date)
  end
  
  def date
    @date = params[:date].to_date
    @results = Bite.for_exhibition(@date)
    
    respond_to do |format|
      format.json { render :json =>  @results }
    end
  end
  
  def top_sources
    @date = params[:date].to_date
    @top_sources = Bite.top_sources_on(@date).limit(10).map { |b| [b.domain_name, b.cnt] }
    respond_to do |format|
      format.js
    end
  end
end