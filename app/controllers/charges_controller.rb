class ChargesController < ApplicationController
  def new
    byebug
  end

  def create
      @amount = @cart.sub_total

      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken]
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: 'Hats',
        currency: 'usd'
      })
      
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
      
  end


end
