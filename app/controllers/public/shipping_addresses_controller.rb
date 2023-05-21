class Public::ShippingAddressesController < ApplicationController
def index
  @shipping_addresses = shipping_addresses.all
  @customer = current_customer
   @shipping_address = shipping_address.new
end
def edit
  @shipping_address = shipping_address.find(params[:id])
  if @customer = current_customer
        render "edit"
  else
      redirect_to
  end
end
def create
  
end
def update
  @shipping_address = shipping_address.find(params[:id])
   redirect_to
end
def destroy
   shipping_address = shipping_address.find(params[:id])
   shipping_address.destroy
   
end

end
