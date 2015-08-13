class OrdersController < ApplicationController
  include EmailNotify
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :accept, :pay, :ship, :unaccept, :unpay, :unship]
  before_action :set_nomenclature, only: [:new, :update, :create]

  authorize_actions_for Order, except: :edit
  authorize_actions_for OrderItem, except: [:new, :accept, :unaccept, :pay, :unpay, :ship, :unship]
  authorize_actions_for Document, except: [:accept, :unaccept, :pay, :unpay, :ship, :unship]

  def index
    session[:previous_path] = orders_path
    @search = Order.includes(:distributor, :order_items).order('created_at desc').search(params[:q])
    if current_user.has_role? :distributor
      @orders = @search.result.current_distr.page(params[:page])
    else
      @orders = @search.result.page(params[:page])
    end
    render partial: 'orders/orders_table' if request.wiselinks_partial?
  end

  def show
    unless session[:previous_path] == delivers_path || session[:previous_path] == invoices_path
      session[:previous_path] = orders_path
    end
    @documents = @order.documents.order('created_at desc').page(params[:doc_page])
    @order_items = @order.order_items
    authorize_action_for(@order)
  end

  def new
    @order = Order.new
    @distr = params[:distributor_id]
    respond_to do |format|
      format.html
      format.js { render action: 'edit' }
    end
  end

  def edit
    @order_items = @order.order_items
    @nomenclatures = Nomenclature.mains.includes(:prices).where('prices.distributor_id' => @order.distributor.id, 'nomenclatures.archived' => false).page(params[:page])
    authorize_action_for(@order)
    authorize_action_for(@order_items)
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        notice('new_order', order: @order)
        format.html { redirect_to @order, notice: 'Заказ добавлен' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order_items = @order.order_items
    authorize_action_for(@order)
    authorize_action_for(@order_items)

    begin
      respond_to do |format|
        if @order.update(order_params)
          session[:previous_path] = orders_path
          notice('update_order', order: @order)
          format.html { redirect_to @order, notice: 'Изменения успешно внесены.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
      rescue ActiveRecord::ReadOnlyRecord
        redirect_to @order, alert: 'Изменения позиций заказа заблокированы'

    end
  end

  def destroy
    authorize_action_for(@order)
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def download
    document = Document.find(params[:id])
    authorize_action_for(document)
    path = URI.decode(document.file.url)
    send_file path, x_sendfile: false
  end

  authority_actions download: 'read'

  def accept
    authorize_action_for(@order)
    @order.accept
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Заказ согласовнан' }
      format.json { head :no_content }
    end
  end

  def unaccept
    authorize_action_for(@order)
    @order.unaccept
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Согласование заказа отменено' }
      format.json { head :no_content }
    end
  end

  def pay
    authorize_action_for(@order)
    @order.pay
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Оплата заказа подтверждена' }
      format.json { head :no_content }
    end
  end

  def unpay
    authorize_action_for(@order)
    @order.unpay
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Оплата заказа отменена' }
      format.json { head :no_content }
    end
  end

  def ship
    authorize_action_for(@order)
    @order.ship
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Заказ отгружен' }
      format.json { head :no_content }
    end
  end

  def unship
    authorize_action_for(@order)
    @order.unship
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Отгрузка заказа отменена' }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_nomenclature
    if @distributor_id != 0
      @nomenclatures = Nomenclature.mains.includes(:prices).where('prices.distributor_id' => @distributor_id).page(params[:page])
    else
      if params[:distributor_id]
        @nomenclatures = Nomenclature.mains.includes(:prices).where('prices.distributor_id' => params[:distributor_id]).page(params[:page])
      end
    end
  end

  def order_params
    params.require(:order).permit(:user_id, :distributor_id, :memo, :docs,
                                  documents_attributes: [:id, :order_id, :file, :document_type_id, :user_id, :_destroy],
                                  order_items_attributes: [:id, :order_id, :nomenclature_id, :partner_number, :quantity, :price, :_destroy])
  end
end
