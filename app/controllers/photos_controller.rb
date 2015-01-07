class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    if !params[:category].nil?
      @photos = Photo.where(category: params[:category])
    else
      @photos = Photo.all
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = session[:user_id]

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /photos/upload
  def upload
    @photo = Photo.new({
      'name' =>params[:file].original_filename,
      'image'=>params[:file],
      'category'=>'none'
    })
    @photo.user_id = session[:user_id]

    if @photo.save
      head :created, location: @photo
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @trashbin = Photo.find(params[:photo_ids])
    destroyed_photos = []
    @trashbin.each do |trash|
      if trash.user_id.eql?(current_user)
        if trash.destroy
          #TODO: display destroyed_photos via ajax
          destroyed_photos.push trash.id
        end
      end
    end

    respond_to do |format|
      format.js { render nothing: true }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:name,:category,:image)
    end
end
