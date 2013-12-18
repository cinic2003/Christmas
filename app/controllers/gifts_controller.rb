class GiftsController < ApplicationController
  # before_action :set_gift, only: [:show, :edit, :update, :destroy]
  # before_filter :markdown
  http_basic_authenticate_with name: "Kathy", password: "christmas"

  # GET /gifts
  # GET /gifts.json
  def index
    @gifts = Gift.all
  end

  # GET /gifts/1
  # GET /gifts/1.json
  def show
    @gift = Gift.find params[:id]
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
  end

  # GET /gifts/1/edit
  def edit
    @gift = Gift.find params[:id]
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @gift = Gift.new(gift_params.merge(:is_done => false))

    respond_to do |format|
      if @gift.save
        format.html { redirect_to @gift, notice: 'Gift was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gift }
      else
        format.html { render action: 'new' }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifts/1
  # PATCH/PUT /gifts/1.json
  def update
    @gift = Gift.find params[:id]
    respond_to do |format|
      if @gift.update(gift_params)
        format.html { redirect_to @gift, notice: 'Gift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.json
  def destroy
    @gift = Gift.find params[:id]
    @gift.destroy
    respond_to do |format|
      format.html { redirect_to gifts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_params
      params.require(:gift).permit(:name, :giving, :talk)
    end
end
