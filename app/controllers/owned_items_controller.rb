class OwnedItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_owned_item, only: %i[ show edit update destroy ]

  # GET /owned_items or /owned_items.json
  def index
    if user_signed_in?
      @items = Item.joins(:owned_item).where(owned_items: {user_id: current_user.id}).page(params[:page]).per(10)
    else
     redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owned_item
      @owned_item = current_user.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def owned_item_params
      params.require(:owned_item).permit(:quantity, :remark).merge(user_id: current_user.id)
    end
end
