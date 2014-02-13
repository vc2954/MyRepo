class Product < ActiveRecord::Base
	has_many:line_items
	# the declaration above is defining that 
	# there could be many/multiple line_items 
	# that refer to this/the product.

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank:true, format: { 
		with: %r{\.(gif|jpg|png)\Z}i, 
		message: 'must be a url for GIF,JPG or PNG image'
	}
	# adding validations here will cause the rake test to fail
	# since the products_controller_test.rb does not have default data 
	# we need to add that to the test.rb and then rake test will be alright
	# while update and create should start using the test data we create
		 #setup do
		  #  @product = products(:one)
		  #  @update = {
		  #    title: 'Lorem Ipsum',
		  #    description:'Wibbles are Fun',
		  #    image_url: 'lorem.jpg',
		  #    price: 19.95
		  #  }
		  #end	
		  #post :create, product: @update
		  #patch :update, id: @product, product: @update

  private

    # now adding a method here to make sure that the product wont be 
    # deleted if there are any line_items referencing the product.
    # we will use a hook method (callback) that will be called when 
    # rails try to destroy an object.
    def ensure_not_referenced_by_line_item
    	if line_items.empty?
    		return true
    	else
    		errors.add(:base,'Line Items Present')
    		return false;
    	end
    end
end
