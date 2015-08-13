class PricesController < ApplicationController
  before_action :authenticate_user!
  def show
    @price = Price.find(params[:id])
  end
end
