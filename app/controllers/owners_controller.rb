 require 'pry'
class OwnersController < ApplicationController

  set :views, "app/views"

  get '/owners' do
    @owners = Owner.all.uniq
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all 
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.create(params[:owner])

    unless params[:pet][:name].empty?
    @owner.pets << Pet.create(name: params[:pet][:name])
    end 
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all 
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    if !params[:owner].keys.include?("pet_ids")
      params[:owner][:pet_ids] = []
    end

    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])
    if !params[:pet][:owner].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    redirect "owners/#{@owner.id}"  
  end
end