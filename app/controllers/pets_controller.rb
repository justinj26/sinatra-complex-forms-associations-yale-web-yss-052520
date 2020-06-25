require 'pry'
class PetsController < ApplicationController

  set :views, "app/views"

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    @owner = Owner.find_or_create_by(params[:owner_name])
    @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = find_pet
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = find_pet
    @owners = Owner.all 
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    binding.pry 
    if params[:owner_name].empty?
      @owner = Owner.new(name: params[:owner][:name])
    else
      @owner = Owner.find_by(name: params[:owner_name])
    end
    @owner.save
    @pet = find_pet
    @pet.owner = @owner 
    redirect to "pets/#{@pet.id}"
  end

  def find_pet
    Pet.find(params[:id])
  end
end