# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :detect_layout

  def default_url_options
    if Rails.env.production?
      { host: ENV['DOCS_HOST'] }
    else
      {}
    end
  end

  def setup_filename(value)
    # required gem browser
    if browser.name == 'Internet Explorer'
      URI.encode(value)
    else
      value
    end
  end

  before_action :setup_distributor, :setup_current_user, :force_ssl
  after_action :store_previous_path

  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    redirect_to request.referrer.presence || root_path,
                alert: 'Недостаточно прав для выполнения данной операции'
  end

  private

  def detect_layout
    current_user ? 'loggedin' : 'application' if user_signed_in?
  end

  def setup_distributor
    # if @distributor_id.nil?
    return unless @distributor_id.nil?
    if current_user && current_user.has_role?(:distributor)
      distributor = Distributor.where(user: current_user).first
      @distributor_id = distributor.id unless distributor.blank?
      Distributor.current = @distributor_id
    else
      @distributor_id = 0
      Distributor.current = 0
    end
    # end
  end

  def setup_current_user
    User.current = current_user if current_user != User.current
    @user_roles = current_user.roles.pluck(:name) unless current_user.nil?
  end

  def force_ssl
    if Rails.env.production?
      if current_user && request.protocol != 'https://'
        redirect_to protocol: 'https://'
      end
    else
      redirect_to protocol: 'http://' if request.protocol == 'https://'
    end
  end

  def store_previous_path
    session[:previous_path] ||= request.env['HTTP_REFERER']
  end
end
