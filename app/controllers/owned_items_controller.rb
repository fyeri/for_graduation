class OwnedItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_owned_item, only: %i[ show edit update destroy ]

  def index
    if user_signed_in?
      # @items = Item.joins(:owned_item, :labels)
      # .where(owned_items: {user_id: current_user.id}).distinct

      @items = Item.includes(:owned_item, :labels)
      .where(owned_items: {user_id: current_user.id}).distinct
      # @items = @items.includes(:labels).where("labels.name LIKE ?", "%#{params[:label]}%") if params[:label].present?

      @items = @items.where("items.name LIKE ?", "%#{params[:name]}%") if params[:name].present?
      @items = @items.where("items.character LIKE ?", "%#{params[:character]}%") if params[:character].present?
      @items = @items.where("labels.name LIKE ?", "%#{params[:label]}%") if params[:label].present?

      @items = @items.page(params[:page]).per(10)
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
