class Cart < ActiveRecord::Base
	# this line here is defining a relation ship from
	# cart to lineitem mentioning that the cart can have
	# multiple line items and the dependency is destroy.
	# Dependency destroy means that if the cart is deleted
	# we need to remove the corresponding line_items.
	# basically this declaration tells Ruby to to the 
	# same. (destroy dependent rows in other tables.)
	# pg 109.
	has_many :line_items, dependent: :destroy

  def add_product(product_id)
     current_item = line_items.find_by(product_id: product_id)
     if current_item 
       current_item.quantity += 1
     else
       current_item = line_items.build(product_id:product_id)
     end
     current_item
  end

  def total_price
  	line_items.to_a.sum { |item| item.total_price }
  end

end
