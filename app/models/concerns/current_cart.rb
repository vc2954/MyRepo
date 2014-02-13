module CurrentCart
  extend ActiveSupport::Concern
# Concerns are shareable code modules
# that can be shared among different modules.
# its also visible to controllers.
# by making it private its still available to the 
# controller but not to its objects.
# pg 108.

  private

    def set_cart
    	@cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    	@cart = Cart.create
    	session[:cart_id] = @cart.id
    end

end