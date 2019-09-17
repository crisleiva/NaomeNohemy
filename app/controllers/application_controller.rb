class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  before_action :current_cart
    def current_user
        if session[:user_id]
            @active_user ||= User.find(session[:user_id])
        end
    end


    helper_method :current_user, :current_cart
      def authorize
          redirect_to '/login' unless current_user
      end

      def logged_user
          !current_user.nil?
      end

      def cart_available?
        !current_cart
      end

    private 

      def current_cart 
        if session[:cart_id]
          cart = Cart.find_by(id: session[:cart_id])
          if cart.present?
            @current_cart = cart
          else
            session[:cart_id] = nil
          end

        end

        if session[:cart_id] == nil
          @current_cart = Cart.create
          session[:cart_id] = @current_cart.id
        end
      end
end
