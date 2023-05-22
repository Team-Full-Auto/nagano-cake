class Public::ShippingAddressesController < ApplicationController
  
def index
  @shipping_addresses = Shipping_addresses.all
  @customer = current_customer
   @shipping_address = shipping_address.new
end
def edit
  @shipping_address = shipping_address.find(params[:id])
  if @customer = current_customer
     redirect_to shipping_address_path
  else
       @shipping_addresses = Shipping_addresses.all
       render "edit"
  end
end
def create
  @shipping_address = shipping_address.new(shipping_address_params)
  @shipping_address.customer = current_customer
   @shipping_addresses = Shipping_addresses.all
  if@shipping_address.save
    redirect_to shipping_address_path(@shipping_address.id)
  else
    render :index
  end
end
def update
  @shipping_address = shipping_address.find(params[:id])
   redirect_to shipping_addresses_path(@shipping_addresses.id)
     flash[:notice]
end
def destroy
   shipping_address = shipping_address.find(params[:id])
   shipping_address.destroy
   redirect_to shipping_addresses_path
end

end
