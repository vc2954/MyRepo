require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # fixtures :products


  def new_product(image_url)
    Product.new(title: "Title in Function",
                description: "desc in Function",
                price: 5,
                image_url: image_url)
  end

  test "test a series of valid and bad urls" do 
      ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
      bad = %w{ fred.doc fred.gif/more fred.gif.more }

      ok.each do |name|
        # message will be displayed if not valid
        assert new_product(name).valid?, "#{name} should be valid. Currently invalid"
      end
      bad.each do |name|
        assert new_product(name).invalid?, "#{name} should not be valid. Currently valid"
      end
  end

  test "product isnt empty" do 
  		product = Product.new
  		assert product.invalid?
  end

  test "product price must be positive" do 
    product = Product.new(title: "Title",
                            description: "description",
                            image_url: "xyz.jpg1",
                          )

    # all the assertions are against the validations defined in the model.

    assert product.invalid? 
    # the above line will be true, because of the invalid image
    # the line below is capturing the error text raised and compares it with
    # the expected error. if the error is anything other than the 
    # expected error then the test case will fail
    # since its an expected message the assert below is setting a true
    # and the test case will continue he test case

    assert_equal ["must be a url for GIF,JPG or PNG image"],product.errors[:image_url]

    # to make the final valid? to pass we are settign the image_url to a valid value.
    product.image_url = "xyz.jpg"

    product.price = -1
    # If the argument to assert is false then it fails.
    # By adding the following line we are saying if the product is indeed invalid
    # dont do anything.
    # just to prove the point we are setting the price to -1.
    # This will invalidate the model since we have the validate condition 
    # in the model with numericality to make the price more than 0.01.
    # basically by adding the asserts here we are testing the definitions we had in the model
    assert product.invalid? 
    assert_equal ["must be greater than or equal to 0.01"],product.errors[:price]


    product.price = 0
    assert product.invalid?  
    assert_equal ["must be greater than or equal to 0.01"],product.errors[:price]

    product.price = 1
    assert product.valid?
    
  end

  test "product attributes must not be empty" do 
  	product = Product.new
      # since we are using a new with the product and not a create,
      # we have to use the product.invalid?
      # if we have used the create or create! then we would not have to 
      # invoke invalid? on assert
      # the difference between create and create! is that 
  		assert product.invalid?
  		assert product.errors[:title].any?
  		assert product.errors[:description].any?
  		assert product.errors[:price].any?
  		assert product.errors[:image_url].any?
  end

# It is important to note that =begin and =end must be at the beginning of their respective lines.
=begin
   When creating an object with ActiveRecord, you can assign validations to ensure certain things about the attributes of the objects (as you have on your object). However, these validations only get run at certain times, and as you're observing, the 'new' method isn't one of these times. However, by asking about the validity of the object with the invalid? method, you have thus triggered the validations.

    I think what might be more natural is to use the "create" method instead of 'new' to trigger validations for your object. create checks validations automatically which will eliminate your call to "invalid?" in your test and should still populate the errors hash as desired:

    product = Product.create(:title => "My lady",
                          :description => "yyy",
                          :price       => 1
                         )
    assert_equal "must be atleast 10 characters long.", product.errors[:title].join('; ')
    Similarly to the 'create' method is the 'create!' method which will actually raise an exception if any validations fail. create will simply return false and populate the error hash.

    For more info on validations check out: http://guides.rubyonrails.org/active_record_validations_callbacks.html 
    
=end

  test "title has to be unique" do 
      product = Product.new(title: products(:ruby).title,
                             description: "new Description",
                             price: 55.0,
                             image_url: "fred.png")
      assert product.invalid?
      assert_equal ["has already been taken"],product.errors[:title]
  end
end
