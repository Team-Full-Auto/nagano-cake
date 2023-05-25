class Public::ShippingAddressesController < ApplicationController

def index
  @shipping_addresses = current_customer.shipping_addresses.all
  @customer = current_customer
  @shipping_address = ShippingAddress.new

end
def edit
  @shipping_address = ShippingAddress.find(params[:id])
  if @shipping_address.customer != current_customer
     redirect_to shipping_addresses_path
  else
       render "edit"
  end
end
def create
  @shipping_address = ShippingAddress.new(shipping_address_params)
  @shipping_address.customer_id = current_customer.id
   @shipping_addresses = ShippingAddress.all
  if@shipping_address.save
    redirect_to shipping_addresses_path
  else
    render :index
  end
end
def update
  @shipping_address = ShippingAddress.find(params[:id])
  @shipping_address.update(shipping_address_params)
   redirect_to shipping_addresses_path(@shipping_address.id)
     flash[:notice] = "更新しました"
end
def destroy
   @shipping_address = ShippingAddress.find(params[:id])
   @shipping_address.destroy
   redirect_to shipping_addresses_path
end
private
def shipping_address_params
  params.require(:shipping_address).permit(:address,:postcode,:name)
end
end
