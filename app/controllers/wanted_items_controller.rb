class WantedItemsController < ApplicationController
  before_action :set_wanted_item, only: %i[ show edit update destroy ]

  # GET /wanted_items or /wanted_items.json
  def index
    @wanted_items = WantedItem.all
  end

  # GET /wanted_items/1 or /wanted_items/1.json
  def show
  end

  # GET /wanted_items/new
  def new
    @wanted_item = WantedItem.new
  end

  # GET /wanted_items/1/edit
  def edit
  end

  # POST /wanted_items or /wanted_items.json
  def create
    @wanted_item = WantedItem.new(wanted_item_params)

    respond_to do |format|
      if @wanted_item.save
        format.html { redirect_to wanted_item_url(@wanted_item), notice: "Wanted item was successfully created." }
        format.json { render :show, status: :created, location: @wanted_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wanted_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wanted_items/1 or /wanted_items/1.json
  def update
    respond_to do |format|
      if @wanted_item.update(wanted_item_params)
        format.html { redirect_to wanted_item_url(@wanted_item), notice: "Wanted item was successfully updated." }
        format.json { render :show, status: :ok, location: @wanted_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wanted_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wanted_items/1 or /wanted_items/1.json
  def destroy
    @wanted_item.destroy

    respond_to do |format|
      format.html { redirect_to wanted_items_url, notice: "Wanted item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wanted_item
      @wanted_item = WantedItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wanted_item_params
      params.require(:wanted_item).permit(:quantity, :remark)
    end
end
