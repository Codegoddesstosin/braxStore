class ProductsController < ApplicationController
    
    def index
     @products = Product.order(:title).to_a
    end
        
    def add_to_cart
        #find the cart
        if session[:cart_id].blank?
            cart = Cart.create(status: "pending")
            session[:cart_id] = cart.id
            
        else
            cart = Cart.find(session[:cart_id])
        end
        
        
        #find the product, build a relationship and add to cart
        product = Product.find(params[:id])
        cart.cartships.create(product_id: product.id, quantity: 1)
        redirect_to cart
               
    end
end