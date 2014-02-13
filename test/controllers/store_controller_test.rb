require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    # the line below is to make sure when we invoke the index of Store
    # http://..../store/index will return a success response
    # i.e.., it will get the corresponding html page
    assert_response :success
    
    # with the following asserts we are checking that the html 
    # thats the output of this uri will have the following elements
    # data as defined. mind you the html is the combination of 
    # layout/application.html.erb adn the index.html.erb under
    # models/store/index.html.erb

    # the following line makes sure there are 
    # at least 4 intances of 'a' under the hierarchy of 
    # columns and side (note those are div ids)
    assert_select '#columns #side a', minimum:4
    # the following line makes sure there are 
    # at least 3 intances of 'entry' under the hierarchy of 
    # main (note those are div ids)    
	assert_select '#main .entry' , 3
	# the following line makes sure there are 
    # at lease an intances of 'Programming Ruby 1.9' under the hierarchy of 
    # element h3  
    assert_select 'h3' , 'Programming Ruby 1.9'
	# the following line makes sure there are 
    # at lease an intances of 'Programming Ruby 1.9' under the hierarchy of 
    # class price  
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
