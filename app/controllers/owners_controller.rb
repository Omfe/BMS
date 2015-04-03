require 'rubygems'
require 'json'
class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  # GET /owners
  # GET /owners.json
  def index
   # @owners = Owner.all
    @owners = Owner.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page]) 
  end
  
  def sort_column
      Owner.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
    @beacons = @owner.beacons
    @beacons = @beacons.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
    @beacons.each {
      |beacon|
      response = Owner.gimbal_get_beacon(beacon)
      body = JSON.parse(response.body)
      hardware = body['hardware']
      
      case hardware # a_variable is the variable we want to compare
      when 'Series 10'    #compare to 1
        beacon.image = 'Series10.png'
      when 'Series 20'    #compare to 2
        beacon.image = '/assets/images/Series20.png' 
      when 'Series 21'
        beacon.image ='/assets/images/Series21.png' 
      else
        beacon.image = 'NoImage.png'
      end
    }
  end

  # GET /owners/new
  def new
    @owner = Owner.new
  end

  # GET /owners/1/edit
  def edit
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(owner_params)
     
    respond_to do |format|
      if @owner.save
        format.html { redirect_to @owner, notice: 'Owner was successfully created.' }
        format.json { render :show, status: :created, location: @owner }
      else
        format.html { render :new }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owners/1
  # PATCH/PUT /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'Owner was successfully updated.' }
        format.json { render :show, status: :ok, location: @owner }
      else
        format.html { render :edit }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    @beacons = @owner.beacons
    @beacons.each {
      |beacon|
      Beacon.gimbal_delete_beacon(beacon)
      beacon.destroy
    }
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url, notice: 'Owner was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params.require(:owner).permit(:name, :image, :description, :owner_type)
    end
end
