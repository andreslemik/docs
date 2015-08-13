class RevisesController < ApplicationController
  include EmailNotify
  before_action :authenticate_user!
  before_action :set_revise, only: [:show, :edit, :update, :destroy, :fix, :unfix]
  authorize_actions_for Revise

  # GET /revises
  # GET /revises.json
  def index
    if current_user.has_role? :distributor
      @revises = Revise.current_distr.includes(:distributor).order('created_at desc').page(params[:page])
    else
      @revises = Revise.all.includes(:distributor).order('created_at desc').page(params[:page])
    end
  end

  # GET /revises/1
  # GET /revises/1.json
  def show
    authorize_action_for(@revise)
  end

  # GET /revises/new
  def new
    @revise = Revise.new
  end

  # GET /revises/1/edit
  def edit
  end

  # POST /revises
  # POST /revises.json
  def create
    @revise = Revise.new(revise_params)

    respond_to do |format|
      if @revise.save
        format.html { redirect_to revises_path, notice: 'Акт сверки успешно добален.' }
        format.json { render action: 'show', status: :created, location: @revise }

        notice('new_revise', revise: @revise)

      else
        format.html { render action: 'new' }
        format.json { render json: @revise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revises/1
  # PATCH/PUT /revises/1.json
  def update
    respond_to do |format|
      if @revise.update(revise_params)
        format.html { redirect_to @revise, notice: 'Акт сверки успешно изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @revise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revises/1
  # DELETE /revises/1.json
  def destroy
    @revise.destroy
    respond_to do |format|
      format.html { redirect_to revises_url }
      format.json { head :no_content }
    end
  end

  def fix
    @revise.fix
    respond_to do |format|
      format.html { redirect_to revises_url }
      format.json { head :no_content }
    end
  end

  def unfix
    @revise.unfix
    respond_to do |format|
      format.html { redirect_to revises_url }
      format.json { head :no_content }
    end
  end

  def download
    revise = Revise.find(params[:id])
    authorize_action_for(revise)
    path = URI.decode(revise.file.url) # for russian folder names
    send_file path, x_sendfile: false
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_revise
    @revise = Revise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def revise_params
    params.require(:revise).permit(:date_begin, :date_end, :memo, :distributor_id, :file)
  end
end
