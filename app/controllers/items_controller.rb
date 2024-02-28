class ItemsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_item, only: %i[ show edit update destroy]
    before_action :authorize_user, only: [:show, :edit, :update, :destroy]

    def index
      redirect_to new_item_path
    end

    def show
      
    end
  

    def new
      @item = Item.new
      @item.build_owned_item
      @item.build_wanted_item
    end
  
    def edit
      if @item.owned_item
        @item_object = @item.owned_item
      else
        @item_object = @item.wanted_item
      end

      @item.image.cache! unless @item.image.blank?
    end
  
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
          format.html { redirect_to item_url(@item), notice: I18n.t('items.create.success') }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      item_type = params[:item][:item_type]
      quantity = params[:item][:quantity]
      remark = params[:item][:remark]
      
      ActiveRecord::Base.transaction do
        if @item.update(item_params.except(:item_type, :quantity, :remark))        
          update_or_build_item(item_type, quantity, remark)
        else
          raise ActiveRecord::Rollback
        end
      end

      respond_to do |format|
        if @item.errors.empty?
          format.html { redirect_to @item, notice: I18n.t('items.edit.success') }
          format.json { render :show, status: :ok, location: @item }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @item.item_labels.destroy_all
      @item.destroy
  
      respond_to do |format|
        format.html { redirect_to owned_items_path, notice:  I18n.t('items.destroy.success')  }
        format.json { head :no_content }
      end
    end
    
    def by_category
      @category = params[:category]

      @items = current_user.items.by_category(@category)
                                 .with_name(params[:name])
                                 .with_character(params[:character])
                                 .with_label_name(params[:label])
                                 .includes(:owned_item, :wanted_item)
                                 .order(created_at: :desc)
                                 .page(params[:page]).per(10)
      @items = @items.map do |item|
        {
          item: item,
          status: item.owned_item.present? ? '持っている' : '欲しい'
        }
      end
    end

  private

    def set_item
      @item = Item.find(params[:id])
    end
    
    def authorize_user
      unless current_user == @item.user
        flash[:alert] = 'アクセス権限がありません'
          redirect_to owned_items_path
      end
    end
  
  
  
    def item_params
      params.require(:item).permit(:name, :character, :category, :purchased_on, :image, :image_cache, :item_type,{ label_ids: [] },
      owned_items_attributes: [:id, :quantity, :remark, :_destroy],
      wanted_items_attributes: [:id, :quantity, :remark, :_destroy])
    end

    def update_or_build_item(item_type, quantity, remark)
      if item_type == 'owned'
        owned_or_wanted = @item.owned_item || @item.build_owned_item(user: current_user)   
      elsif item_type == 'wanted'
        owned_or_wanted = @item.wanted_item || @item.build_wanted_item(user: current_user)
      end
      
      owned_or_wanted.assign_attributes(quantity: quantity, remark: remark)
        
    if owned_or_wanted.new_record? 
      owned_or_wanted.save
      owned_or_wanted.exchange
    else
      owned_or_wanted.save
    end
  end
end

