require 'pry'
class TenantsController < ApplicationController
  # add controller methods
  set :views, "app/views/tenants"

  get '/tenants' do
    @tenants = Tenant.all
    erb :index
  end

  get '/tenants/new' do 
    @apartments = Apartment.all
    erb :new
  end

  get '/tenants/:id' do
    @tenant = Tenant.find(params[:id])
    erb :show
  end

  get '/tenants/:id/edit' do
    @apartments = Apartment.all
    @tenant = Tenant.find(params[:id])
    erb :edit
  end

  post '/tenants' do 
    tenant = Tenant.new(params[:tenant])
    unless params[:apartment][:address].empty?
      new_apt = Apartment.create(params[:apartment])
      tenant.apartment = new_apt
    end
    tenant.save
    redirect to "/tenants/#{tenant.id}"
  end

  patch '/tenants/:id' do 
    tenant = Tenant.find(params[:id])
    tenant.update(params[:tenant])
    unless params[:apartment][:address].empty?
      new_apt = Apartment.create(params[:apartment])
      tenant.update(apartment: new_apt)
    end
    redirect "/tenants/#{tenant.id}"
  end

  delete '/tenants/:id' do 
    tenant = Tenant.find(params[:id])
    tenant.destroy
    redirect "/tenants"
  end
end
