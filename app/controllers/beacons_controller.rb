class BeaconsController < ApplicationController
  before_action :set_beacon, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /beacons
  # GET /beacons.json
  def index
  end
  
  def sort_column
    Beacon.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # GET /beacons/1
  # GET /beacons/1.json
  def show
  end

  # GET /beacons/new
  def new
    @beacon = Beacon.new
    
    $owner = Owner.find(params[:id])
  end

  # GET /beacons/1/edit
  def edit
  end

  # POST /beacons
  # POST /beacons.json
  def create
    #beacon.owner_id = params[:id]
    @beacon = Beacon.new(beacon_params)
    @beacon.owner_id = $owner.id
    
    respond_to do |format|
      #temporal
      if @beacon.save
        format.html { redirect_to @beacon, notice: 'Beacon was successfully created.' }
        format.json { render  :template => "owners/show", status: :created, location: @beacon }
      else
        format.html { render :new }
        format.json { render json: @beacon.errors, status: :unprocessable_entity }
      end
      # status_code = Beacon.gimbal_create_beacon(@beacon)
#       if status_code == "200"
#         if @beacon.save
#           format.html { redirect_to @beacon, notice: 'Beacon was successfully created.' }
#           format.json { render  :template => "owners/show", status: :created, location: @beacon }
#         else
#           format.html { render :new }
#           format.json { render json: @beacon.errors, status: :unprocessable_entity }
#         end
#       elsif status_code == "422"
#         @beacon.errors.add(:factory_id, "Beacon already activated")
#         format.html { render :new }
#         format.json { render json: @beacon.errors, status: :unprocessable_entity }
#       else
#         @beacon.errors.add(:factory_id, "Invalid Id")
#         format.html { render :new }
#         format.json { render json: @beacon.errors, status: :unprocessable_entity }
#         #render json: {status: "Invalid Beacon"}, status: 404
#       end
    end
  end
  
  

  # PATCH/PUT /beacons/1
  # PATCH/PUT /beacons/1.json
  def update
    respond_to do |format|
      if @beacon.update(beacon_params)
        Beacon.gimbal_update_beacon(@beacon)
        format.html { redirect_to @beacon, notice: 'Beacon was successfully updated.' }
        format.json { render :template => "owners/show", status: :ok, location: @beacon }
      else
        format.html { render :edit }
        format.json { render json: @beacon.errors, status: :unprocessable_entity }
      end
    end
  end
      
  # DELETE /beacons/1
  # DELETE /beacons/1.json
  def destroy
    @beacon.destroy
    respond_to do |format|
      Beacon.gimbal_delete_beacon(@beacon)
      format.html { redirect_to owner_path(@beacon.owner), notice: 'Beacon was successfully deactivated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beacon
      @beacon = Beacon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beacon_params
      params.require(:beacon).permit(:name, :factory_id, :description, :latitude, :longitude, :owner_id)
    end
end
