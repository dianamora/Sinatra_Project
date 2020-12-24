class OrderController < ApplicationController

    #create
    get '/orders/new' do #render the order form
        if logged_in?
            erb :'/orders/new'
        else 
            @error = "Please log in or sign up!"
            erb :'users/login'
        end 
    end
    
    post '/orders' do #this is going to process our form
        if logged_in?
        @order = current_user.orders.create(
            address: params[:address], 
            item: params[:item], 
            item_price: params[:item_price], 
            total: params[:total]
            )
            
            #hey your id is the current user's id
            # @order.user_id = current_user.id
           
           redirect "/orders/#{@order.id}"
        else 
            redirect '/users/login'
        end
    end

    #read
    get '/orders/submit' do #what user sees after order is submitted
        erb :'/orders/submit'
    end

    get '/orders/:id' do
        @order = Order.find(params[:id])
        erb :'/orders/show'
    end

    get '/orders' do
        @orders = current_user.orders #returns an array
        erb :'/orders/index'
    end

    #update

    get '/orders/:id/edit' do
        @order = Order.find(params[:id])
        if current_user == @order.user
            erb :'/orders/edit'
        else 
            redirect '/users/welcome'
        end
    end


    post '/orders/:id' do
        @order = Order.find(params[:id])
        @order.update(
            address: params[:address], 
            item: params[:item], 
            item_price: params[:item_price], 
            total: params[:total]
            )
            redirect "/orders/#{@order.id}"
    end

    #delete
    delete '/orders/:id' do
        # binding.pry
    @order = Order.find(params[:id])
    if current_user == @order.user
    @order.destroy
    
    redirect '/orders'
    else
        redirect '/orders/welcome'
    end
  
    end
end
   
   

    # delete '/orders/:id' do
    #     @order = Order.find(params[:id])
    #     @order.destroy
    #     redirect '/orders'
    #     end

    # get '/orders/:id' do
           
    # end        
    
    # post '/orders/:id' do
    #     @order = Order.find(params[:id])
    #     @order.destroy
    #     redirect '/orders'
    #     end

