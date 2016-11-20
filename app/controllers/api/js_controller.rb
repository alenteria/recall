class Api::JsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :load_account

  def index
  end

  private
  def load_account
    public_key = params[:public_key]
  end
end