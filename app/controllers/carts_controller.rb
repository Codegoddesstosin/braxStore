class CartsController < ApplicationController
    
    def index
      @products = Product.order(:title).to_a
     end
    
    def show
       @cart = Cart.find(params[:id]) 
    end
    
    
    #stripe payment calculations
    def pay
    
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here: https://dashboard.stripe.com/account/apikeys
      Stripe.api_key = "sk_test_HbmVzgwYzJlFClW3DAvZVYe8"

    # Token is created using Checkout or Elements!
     # Get the payment token ID submitted by the form:
    token = params[:stripeToken]

     charge = Stripe::Charge.create({
     amount: (@cart.total_price * 100).to_i, # amount in cent
     currency: 'usd',
     description: 'Payment for cart #{@cart.id}',
     source: token,
   })
     rescue Stripe::CardError => e
       redirect_to @cart, notice: "payment declined" and return
      
       @cart.update(status: "completed")
       session.delete(:cart_id)
       redirect_to root_path, notice: "Your candies are on its way"
    end
    
end 