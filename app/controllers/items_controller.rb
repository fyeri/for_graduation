class ItemsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_item, only: %i[ show edit update destroy ]
  
    def show
      
    end
  
    # GET /items/new
    def new
      @item = Item.new
      @item.build_owned_item
      @item.build_wanted_item
    end
  
    # GET /items/1/edit
    def edit
    end
  
    # POST /items or /items.json
    def create
      @item = current_user.items.build(item_params)
      @item.item_type = params[:item][:item_type]
      
      item_type = params[:item][:item_type]
      quantity = params[:item][:quantity]
      remark = params[:item][:remark]

      if item_type == 'owned'
        @item.build_owned_item(quantity: quantity, remark: remark, user: current_user)
      elsif item_type == 'wanted'
        @item.build_wanted_item(quantity: quantity, remark: remark, user: current_user)
      end
  
      respond_to do |format|
        if @item.save
          format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /items/1 or /items/1.json
    def update
      item_type = params[:item][:item_type]
      quantity = params[:item][:quantity]
      remark = params[:item][:remark]
      
      if @item.update(item_params.except(:item_type, :quantity, :remark))
        update_or_build_item(item_type, quantity, remark)
    
          respond_to do |format|
          if @item.save
            format.html { redirect_to @item, notice: 'Item was successfully updated.' }
            format.json { render :show, status: :ok, location: @item }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @item.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /items/1 or /items/1.json
    def destroy
      @item.item_labels.destroy_all
      @item.destroy
  
      respond_to do |format|
        format.html { redirect_to owned_items_path, notice: "Item was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    def by_category
      @category = params[:category]

      @items = Item.includes(:owned_item, :wanted_item).where(category: @category).map do |item|
        {
          item: item,
          status: item.owned_item.present? ? '持っているグッズ' : '欲しいグッズ'
        }
      end
    end

  private
      # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = current_user.items.find(params[:id])
    end
  
  
  
      # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :character, :category, :purchased_on, :image, :item_type,{ label_ids: [] },
      owned_items_attributes: [:quantity, :remark, :_destroy],
      wanted_items_attributes: [:quantity, :remark, :_destroy])
    end
  
    def update_or_build_item(item_type, quantity, remark)
      if item_type == 'owned'
        @item.owned_item ? @item.owned_item.update(quantity: quantity, remark: remark)
         : @item.build_owned_item(quantity: quantity, remark: remark)
      elsif item_type == 'wanted'
        @item.wanted_item ? @item.wanted_item.update(quantity: quantity, remark: remark)
         : @item.build_wanted_item(quantity: quantity, remark: remark)
    end
  end
end
