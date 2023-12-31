class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @top_5_merchants = Merchant.top_5_by_revenue
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def new
    @merchant = Merchant.new
  end
  
  def create
    merchant = Merchant.create(merchant_params)
    redirect_to "/admin/merchants"
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def update
    merchant = Merchant.find(params[:id])
    if params[:button] == nil
      if merchant.update(merchant_params)
        flash[:notice] = "Merchant name has been updated"
        redirect_to "/admin/merchants/#{params[:id]}"
      else
        redirect_to "/admin/merchants/#{params[:id]}/edit"
        flash[:alert] = "Error: #{error_message(merchant.errors)}"
      end
    elsif params[:button] == "Enable"
      merchant.update(enabled: true)
      redirect_to "/admin/merchants"
    elsif params[:button] == "Disable"
      merchant.update(enabled: false)
      redirect_to "/admin/merchants"
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end
end