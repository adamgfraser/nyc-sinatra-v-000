class LandmarksController < ApplicationController

  get '/landmarks/new' do
    erb :"landmarks/new"
  end

  post '/landmarks' do
    name = params[:landmark][:name]
    year_completed = params[:landmark][:year_completed]
    Landmark.create(name: name, year_completed: year_completed)
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"landmarks/index"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/edit"
  end

  post '/landmarks/:id' do
    landmark = Landmark.find(params[:id])    
    landmark.name = params[:landmark][:name] if params[:landmark][:name]
    landmark.year_completed = params[:landmark][:year_completed] if params[:landmark][:year_completed]
    landmark.save
    redirect to "/landmarks/#{params[:id]}"
  end
  
end
