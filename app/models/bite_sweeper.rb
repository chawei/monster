class BiteSweeper < ActionController::Caching::Sweeper
  observe Bite # This sweeper is going to keep an eye on the Product model
 
  # If our sweeper detects that a Product was created call this
  def after_create(bite)
    expire_cache_for(bite)
  end
 
  # If our sweeper detects that a Product was updated call this
  def after_update(bite)
    expire_cache_for(bite)
  end
 
  # If our sweeper detects that a Product was deleted call this
  def after_destroy(bite)
    expire_cache_for(bite)
  end
 
  private
  def expire_cache_for(bite)
    # Expire the index page now that we added a new product
    #expire_page(:controller => 'products', :action => 'index')
 
    # Expire a fragment
    today = Date.today.strftime("%Y%m%d")
    date = bite.created_at.strftime("%Y%m%d")
    expire_fragment("date-archive") if date < today
    expire_fragment("date-#{date}")
  end
end