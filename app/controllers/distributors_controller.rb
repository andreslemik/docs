class DistributorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_distributor, only: [:show, :edit, :update, :destroy]

  authorize_actions_for Distributor

  def index
    @distributors = Distributor.all.includes(:user).page(params[:page])
  end

  def show
  end

  def new
    @distributor = Distributor.new
  end

  def edit
  end

  def create
    @distributor = Distributor.new(distributor_params)
    respond_to do |format|
      if @distributor.save
        format.html { redirect_to distributors_url, notice: 'Запись создана.' }
        format.json { render action: 'show', status: :created, location: @distributor }
      else
        format.html { render action: 'new' }
        format.json { render json: @distributor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @distributor.update(distributor_params)
        format.html { redirect_to distributors_url, notice: 'Изменения успешно внесены.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @distributor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @distributor.destroy
    respond_to do |format|
      format.html { redirect_to distributors_url }
      format.json { head :no_content }
    end
  end

  private

  def set_distributor
    @distributor = Distributor.find(params[:id])
  end

  def distributor_params
    params[:distributor].permit(:name, :user_id)
  end
end
