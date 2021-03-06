class SectorsController < ApplicationController
  before_filter :login_required, :only => [:dissociate, :associate]
  before_filter :admin_required, :only => [:new, :create, :edit, :update, :destroy]
  # :show is ok
  def dissociate
    @sector = Sector.find(params[:sector_id])
    @organization = Organization.find(params[:organization_id])
    merge_check
    @organization.sectors.delete(@sector)
    @organization.save!
    @organization.notify_related_record_change(:deleted, @sector)
    render :partial => 'manage'
  end

  def associate
    @sector = Sector.find(params[:sector_id])
    @organization = Organization.find(params[:organization_id])
    merge_check
    @organization.sectors.push(@sector)
    @organization.save!
    @organization.notify_related_record_change(:added, @sector)
    render :partial => 'manage'
  end

  # GET /sectors
  # GET /sectors.xml
  def index
    show_tag_context(Sector)
  end

  # GET /sectors/1
  # GET /sectors/1.xml
  def show
    show_tag(Sector.find(params[:id]))
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
