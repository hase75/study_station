class Public::FavoritesController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @favorites = Favorite.where(customer_id: current_customer.id).page(params[:page]).per(8)
  end
  
  def create
    @space = Space.find(params[:space_id])
    @favorite = current_customer.favorites.create(space_id: params[:space_id])
  end

  def destroy
    @space = Space.find(params[:space_id])
    @favorite = current_customer.favorites.find_by(space_id: @space.id)
    @favorite.destroy
  end
end
