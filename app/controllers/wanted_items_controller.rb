class WantedItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_wanted_item, only: %i[ show edit update destroy ]

  def index
    if user_signed_in?

      @items = WantedItem.for_user(current_user.id)
              .with_item_name(params[:name])
              .with_item_character(params[:character])
              .with_label_name(params[:label])
              .includes(:item)
              .order(created_at: :desc)
              .page(params[:page]).per(10)
    else
      redirect_to new_user_session_path
    end
  end


  private
    def set_wanted_item
      @wanted_item = current_user.items.find(params[:id])
    end

    def wanted_item_params
      params.require(:wanted_item).permit(:quantity, :remark).merge(user_id: current_user.id)
    end
end
