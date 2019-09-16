class Charge < ApplicationRecord 
  def items_description
    if @current_cart.any? 
      @current_cart.line_items.each do |item|
        return item.name
      end
    end
  end
end