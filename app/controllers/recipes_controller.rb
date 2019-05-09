class RecipesController < ApplicationController
  def index
  end

  def proxy
    render json: Services::Recipes::Proxy.new.fetch(params[:query])
  end
end
