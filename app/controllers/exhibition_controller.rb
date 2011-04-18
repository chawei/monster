class ExhibitionController < ApplicationController
  def date
    @date = params[:date].to_date
    @bites = Bite.on(@date)
    @top_sources = Bite.top_sources_on(@date).limit(10).map { |b| [b.domain_name, b.cnt] }
  end
end