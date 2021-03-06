module ApplicationHelper
  
  def get_factor(sources)
    diff = sources[0][1].to_i - sources[-1][1].to_i
    factor = diff/16.0
  end
  
  def get_font_size(factor, mid_value, min)
    min_font_size = 11
    
    if factor == 0
		  font_size = min_font_size
		else
		  font_size = ((mid_value.to_i - min.to_i)/factor) + min_font_size 
		end
		return font_size.to_i
  end
end
