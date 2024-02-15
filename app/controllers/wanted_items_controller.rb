class WantedItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_wanted_item, only: %i[ show edit update destroy ]

  # GET /wanted_items or /wanted_items.json
  def index
    if user_signed_in?
      @items = Item.joins(:wanted_item).where(wanted_items: {user_id: current_user.id}).page(params[:page]).per(10)
    else
      redirect_to new_user_session_path
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wanted_item
      @wanted_item = current_user.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wanted_item_params
      params.require(:wanted_item).permit(:quantity, :remark).merge(user_id: current_user.id)
    end
end
