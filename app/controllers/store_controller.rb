class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
  	# the order method here is making sure that the records are 
  	# ordered by title.
  	@products = Product.order(:title)
  end
end
