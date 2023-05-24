class Public::HomesController < ApplicationController
  def top
    @customer = current_customer
    @top_items = Item.recent_items
  end

  def about
    @customer = current_customer
  end
end
