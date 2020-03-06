class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner= owner
      @pet.save
    end
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ####### bug fix
    if !params[:pet].keys.include?("owner_id")
    params[:pet]["owner_id"].clear
    end
    #######

    @pet = Pet.find(parms[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
    redirect to "pets/#{@pet.id}"
  end
end
