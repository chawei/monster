class BitesController < ApplicationController
  cache_sweeper :bite_sweeper
  
  def admin
    @bites = Bite.admin_photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bites }
    end
  end
  
  # GET /bites
  # GET /bites.xml
  def index
    @today_date  = Date.today
    @today_count = Bite.today.count
    @today_bites = Bite.today.limit(50)
    @top_sources = Bite.top_20_sources_in_hash
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bites }
    end
  end

  # GET /bites/1
  # GET /bites/1.xml
  def show
    @bite = Bite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bite }
    end
  end

  # GET /bites/new
  # GET /bites/new.xml
  def new
    @bite = Bite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bite }
    end
  end

  # GET /bites/1/edit
  def edit
    @bite = Bite.find(params[:id])
  end

  # POST /bites
  # POST /bites.xml
  def create
    @bite = Bite.new(params[:bite])

    respond_to do |format|
      if @bite.save
        format.html { redirect_to(@bite, :notice => 'Bite was successfully created.') }
        format.xml  { render :xml => @bite, :status => :created, :location => @bite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bites/1
  # PUT /bites/1.xml
  def update
    @bite = Bite.find(params[:id])

    respond_to do |format|
      if @bite.update_attributes(params[:bite])
        format.html do 
          if params[:admin] == '1'
            redirect_to admin_path
          else
            redirect_to(@bite, :notice => 'Bite was successfully updated.') 
          end
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bites/1
  # DELETE /bites/1.xml
  def destroy
    @bite = Bite.find(params[:id])
    @bite.destroy

    respond_to do |format|
      format.html { redirect_to(bites_url) }
      format.xml  { head :ok }
    end
  end
  
  def upload
    @bite = BiteFactory.create(params)

    respond_to do |format|
      unless @bite.new_record?
        format.html { redirect_to(@bite, :notice => 'Bite was successfully created.') }
        format.xml  { render :xml => @bite, :status => :created, :location => @bite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bite.errors, :status => :unprocessable_entity }
      end
    end
  end
end
