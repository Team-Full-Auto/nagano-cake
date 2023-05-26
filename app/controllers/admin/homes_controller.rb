class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
  end

  private


end
