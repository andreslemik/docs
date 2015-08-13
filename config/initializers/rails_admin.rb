require 'i18n'
I18n.default_locale = :ru
RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # authority
  config.authorize_with do
    unless current_user.has_role? :admin
      redirect_to main_app.root_path, alert: 'Доступ запрещён'
    end
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    history_show
  end

  config.included_models = %w(Revise Order Nomenclature User DocumentType)

  config.navigation_static_links = {
    'Редактирование сайта' => '/site_admin'
  }
  config.navigation_static_label = 'Дополнительно'

  config.main_app_name = %w(Docs Управление)
end
