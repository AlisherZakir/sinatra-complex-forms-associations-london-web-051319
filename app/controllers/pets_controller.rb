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
    pet = Pet.create(params[:pet])
    pet.update(owner: Owner.create(params[:owner])) if !pet.owner
    redirect "pets/#{pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.update(params[:pet])
    Owner.create(params[:owner]).pets << pet if params[:owner][:name].length > 0
    redirect to "pets/#{pet.id}"
  end
end
