class DocumentsController < ApplicationController
  include EmailNotify
  before_action :authenticate_user!
  before_action :set_order, only: [:new, :create]
  before_action :set_document, only: [:edit, :show, :update, :destroy, :download]
  before_action :check_mime, only: [:show]
  def invoices
    session[:previous_path] = invoices_path
    @search = Document.invoices.includes(:order).order('created_at desc').search(params[:q])
    select_documents
  end

  def delivers
    session[:previous_path] = delivers_path
    @search = Document.delivers.includes(:order).order('created_at desc').search(params[:q])
    select_documents
  end

  def new
    @document = @order.documents.new
  end

  def create
    @document = @order.documents.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to @order, notice: 'Документ добавлен' }
        format.json { render action: 'show', status: :created, location: @document }
        notice('document_added', order: @order, document: @document)
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize_action_for(@document)
    @back_url = back_to(@document)
  end

  def update
    authorize_action_for(@document)
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to back_to(@document), notice: 'Изменения успешно внесены.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize_action_for(@document)
    @document.destroy
    respond_to do |format|
      format.html { redirect_to back_to(@document) }
      format.json { head :no_content }
    end
  end

  def download
    authorize_action_for(@document)
    path = URI.decode(@document.file.url)
    send_file path, x_sendfile: false, filename: setup_filename(@document.file.file.filename)
  end
  authority_actions download: 'read'

  def show
    authorize_action_for(@document)
    extension = @document.file.file.extension.downcase
    disposition = 'attachment'
    mime = MIME::Types.type_for(@file).first.content_type
    disposition = 'inline' if %w(jpg png gif bmp pdf txt).include?(extension)
    send_file @file, type: mime, disposition: disposition, x_sendfile: false, filename: setup_filename(@document.file.file.filename)
  end

  private

  def check_mime
    @file = URI.decode(@document.file.url)
    if MIME::Types.type_for(@file).first.nil?
      redirect_to download_document_path(@document)
    end
  end

  def select_documents
    if current_user.has_role? :distributor
      @documents = @search.result.current_distr.page(params[:doc_page])
    else
      @documents = @search.result.page(params[:doc_page])
    end
    render partial: 'documents/documents_table' if request.wiselinks_partial?
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:file, :order_id, :document_type_id, :user_id, :doc_date, :doc_no, :memo, :summa)
  end

  def back_to(doc)
    "#{doc.document_type.tab}".to_sym
  end
end
