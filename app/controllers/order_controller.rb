class OrderController < ApplicationController

    #create
    get '/orders/new' do #render the order form
        erb :'orders/new'
    end
    
    post '/orders' do #this is going to process our form
        @order = Order.create(
            address: params[:address], 
            item: params[:item], 
            item_price: params[:item_price], 
            total: params[:total]
            )
           redirect "/orders/#{@order.id}"
    end

    #read
    get '/orders/:id' do
        @order = Order.find(params[:id])
        erb :'/orders/show'
    end

    get '/orders' do
        @orders = Order.all #returns an array
        erb :'/orders/index'
    end

    #update


    #delete


end