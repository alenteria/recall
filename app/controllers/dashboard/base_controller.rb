class Dashboard::BaseController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'
  def index
    render 'dashboard/index'
  end

  def update_availability
    current_user.update_column :availability, params[:availability]
    redirect_to :back
  end
end