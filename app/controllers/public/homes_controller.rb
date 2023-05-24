class Public::HomesController < ApplicationController
  def top
    @top_items = Item.recent_items
  end
  
  def about
  end
end
