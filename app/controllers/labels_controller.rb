class LabelsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_label, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]

  def index
    @labels = current_user.labels
  end

  def show
  end

  def new
    @label = Label.new
  end

  def edit
  end

  def create
    @label = current_user.labels.build(label_params)

    respond_to do |format|
      if @label.save
        format.html { redirect_to labels_path, notice: I18n.t('labels.create.success') }
        format.json { render :show, status: :created, location: @label }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @label.update(label_params)
        format.html { redirect_to label_url(@label), notice: I18n.t('labels.edit.success') }
        format.json { render :show, status: :ok, location: @label }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @label.destroy

    respond_to do |format|
      format.html { redirect_to labels_url, notice: I18n.t('labels.destroy.success') }
      format.json { head :no_content }
    end
  end

  private
    def set_label
      @label = Label.find(params[:id])
    end

    def authorize_user
      unless current_user == @label.user
        flash[:alert] = I18n.t('authorize_user.error')
          redirect_to labels_path
      end
    end

    def label_params
      params.require(:label).permit(:name)
    end
end
