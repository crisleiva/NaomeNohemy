class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    charge_error = nil
    @amount = (@current_cart.sub_total.to_i * 100)
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    if @order.valid?
      begin
        customer = Stripe::Customer.create({
          email: params[:stripeEmail],
          source: params[:stripeToken]
        })

        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'NandN',
          currency: 'usd'
        })
      rescue Stripe::CardError => exception
        charge_error = exception.message
      end

      if charge_error
        flash[:error] = charge_error
        render :new
      else
        @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        redirect_to root_path
      end
    else
      flash[:error] = 'one or more errors in your order'
      render :new
    end
    
  end

  private
    def order_params
      params.require(:order).permit(:name, :email, :address, :city, :state, :zip_code)
    end
end
