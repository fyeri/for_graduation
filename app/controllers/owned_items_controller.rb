class OwnedItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?

      @items = OwnedItem.for_user(current_user.id)
      .with_item_name(params[:name])
      .with_item_character(params[:character])
      # binding.pry
      .with_label_name(params[:label])
      .includes(:item)
      .order(created_at: :desc)
      .page(params[:page]).per(10)
   else
      redirect_to new_user_session_path
   end
  end


  private
    def set_owned_item
      @owned_item = current_user.items.find(params[:id])
    end

    def owned_item_params
      params.require(:owned_item).permit(:quantity, :remark).merge(user_id: current_user.id)
    end
end
