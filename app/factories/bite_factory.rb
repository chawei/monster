class BiteFactory 
  def self.create(bite_params)
    bite = Bite.new
    bite.url = bite_params[:url]
    bite.image_url = bite_params[:image_url]
    bite.top  = bite_params[:top]
    bite.left = bite_params[:left]
    bite.width  = bite_params[:width]
    bite.height = bite_params[:height]
    bite.save
    bite
  end
end