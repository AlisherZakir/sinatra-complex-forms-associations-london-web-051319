class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    owner = Owner.create(params[:owner])
    owner.pets.create(params[:pet])
    redirect "/owners/#{owner.id}"
  end

  get '/owners/:id/edit' do
    # locals = {}
    # locals[:owner] = Owner.find(params[:id])
    # locals[:pets] = Pet.all
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'#, locals: locals
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    owner = Owner.find(params[:id])
    owner.update(params[:owner])
    if !params["pet"]["name"].empty?
      owner.pets << Pet.create(name: params["pet"]["name"])
    end
  end
end
