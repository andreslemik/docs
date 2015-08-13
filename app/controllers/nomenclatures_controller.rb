class NomenclaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_nomenclature, only: [:show, :edit, :update, :destroy]
  before_action :set_prices, only: [:edit, :show]

  authorize_actions_for Nomenclature

  # GET /nomenclatures
  # GET /nomenclatures.json
  def index
    @arch = false
    @url = nomenclatures_path
    @search = Nomenclature.mains.ransack params[:q]
    @nomenclatures = @search.result.page params[:page]
    render partial: 'nomenclatures/table' if request.wiselinks_partial?
  end

  def archived
    @arch = true
    @url = archived_nomenclatures_path
    @search = Nomenclature.archived.ransack params[:q]
    @nomenclatures = @search.result.page params[:page]
    render :index
  end
  authority_actions archived: 'read'

  # GET /nomenclatures/1
  # GET /nomenclatures/1.json
  def show
  end

  # GET /nomenclatures/new
  def new
    @nomenclature = Nomenclature.new
    @nomenclature.prices.build
  end

  # GET /nomenclatures/1/edit
  def edit
  end

  # POST /nomenclatures
  # POST /nomenclatures.json
  def create
    @nomenclature = Nomenclature.new(nomenclature_params)

    respond_to do |format|
      if @nomenclature.save
        format.html { redirect_to @nomenclature, notice: 'Запись создана.' }
        format.json { render action: 'show', status: :created, location: @nomenclature }
      else
        format.html { render action: 'new' }
        format.json { render json: @nomenclature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nomenclatures/1
  # PATCH/PUT /nomenclatures/1.json
  def update
    respond_to do |format|
      if @nomenclature.update(nomenclature_params)
        format.html { redirect_to @nomenclature, notice: 'Изменения успешно внесены.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @nomenclature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nomenclatures/1
  # DELETE /nomenclatures/1.json
  def destroy
    @nomenclature.destroy
    respond_to do |format|
      format.html { redirect_to nomenclatures_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nomenclature
    @nomenclature = Nomenclature.find(params[:id])
  end

  def set_prices
    @prices = @nomenclature.prices.includes(:distributor)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def nomenclature_params
    params.require(:nomenclature).permit(:name, :full_name, :partner_number, :nomenclature_type_id, :archived,
                                         prices_attributes: [:id, :nomenclature_id, :distributor_id, :price, :_destroy])
  end
end
