class SectorsController < ApplicationController
  def dissociate
    @sector = Sector.find(params[:sector_id])
    @organization = Organization.find(params[:organization_id])
    @organization.sectors.delete(@sector)
    @organization.save!
    render :partial => 'manage'
  end

  def associate
    @sector = Sector.find(params[:sector_id])
    @organization = Organization.find(params[:organization_id])
    @organization.sectors.push(@sector)
    @organization.save!
    render :partial => 'manage'
  end

  # GET /sectors
  # GET /sectors.xml
  def index
    @sectors = Sector.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sectors }
    end
  end

  # GET /sectors/1
  # GET /sectors/1.xml
  def show
    @sector = Sector.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sector }
    end
  end

  # GET /sectors/new
  # GET /sectors/new.xml
  def new
    @sector = Sector.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sector }
    end
  end

  # GET /sectors/1/edit
  def edit
    @sector = Sector.find(params[:id])
  end

  # POST /sectors
  # POST /sectors.xml
  def create
    @sector = Sector.new(params[:sector])

    respond_to do |format|
      if @sector.save
        flash[:notice] = 'Sector was successfully created.'
        format.html { redirect_to(@sector) }
        format.xml  { render :xml => @sector, :status => :created, :location => @sector }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sectors/1
  # PUT /sectors/1.xml
  def update
    @sector = Sector.find(params[:id])

    respond_to do |format|
      if @sector.update_attributes(params[:sector])
        flash[:notice] = 'Sector was successfully updated.'
        format.html { redirect_to(@sector) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sectors/1
  # DELETE /sectors/1.xml
  def destroy
    @sector = Sector.find(params[:id])
    @sector.destroy

    respond_to do |format|
      format.html { redirect_to(sectors_url) }
      format.xml  { head :ok }
    end
  end
end
