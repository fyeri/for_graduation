class OwnedItemsController < ApplicationController
  before_action :set_owned_item, only: %i[ show edit update destroy ]

  # GET /owned_items or /owned_items.json
  def index
    @owned_items = OwnedItem.all


    @items = Item.joins(:owned_item).where.not(owned_items: { id: nil }).page(params[:page]).per(10)
  end

  # GET /owned_items/1 or /owned_items/1.json
  def show
  end

  # GET /owned_items/new
  def new
    @owned_item = OwnedItem.new
  end

  # GET /owned_items/1/edit
  def edit
  end

  # POST /owned_items or /owned_items.json
  def create
    @item = Item.find(params[:item_id])
    @owned_item = OwnedItem.new(owned_item_params)

    respond_to do |format|
      if @owned_item.save
        format.html { redirect_to owned_item_url(@owned_item), notice: "Owned item was successfully created." }
        format.json { render :show, status: :created, location: @owned_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @owned_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owned_items/1 or /owned_items/1.json
  def update
    respond_to do |format|
      if @owned_item.update(owned_item_params)
        format.html { redirect_to owned_item_url(@owned_item), notice: "Owned item was successfully updated." }
        format.json { render :show, status: :ok, location: @owned_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @owned_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owned_items/1 or /owned_items/1.json
  def destroy
    @owned_item.destroy

    respond_to do |format|
      format.html { redirect_to owned_items_url, notice: "Owned item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owned_item
      @owned_item = OwnedItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def owned_item_params
      params.require(:owned_item).permit(:quantity, :remark)
    end
end
