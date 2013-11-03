class Product < ActiveRecord::Base
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
end
