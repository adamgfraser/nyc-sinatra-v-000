class FiguresController < ApplicationController

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"figures/new"
  end

  post '/figures' do
    figure = Figure.new(name: params[:figure]["name"])

    if params[:figure].has_key?("title_ids")
      figure.titles = params[:figure]["title_ids"].map do |title_id|
        Title.find(title_id)
      end
    else
      figure.titles.clear
    end
    if params[:title]["name"] != ""
      title = Title.find_or_create_by(name: params[:title]["name"])
      figure.titles << title
    end

        if params[:figure].has_key?("landmark_ids")     
      figure.landmarks = params[:figure]["landmark_ids"].map do |landmark_id|
        Landmark.find(landmark_id)
      end
    else
      figure.landmarks.clear
    end
    if params[:landmark]["name"] != ""
      landmark = Landmark.find_or_create_by(name: params[:landmark]["name"])
      figure.landmarks << landmark
    end

    figure.save
    redirect to "/figures/#{figure.id}"
  end

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"figures/edit"
  end

  post '/figures/:id' do
    figure = Figure.find(params[:id])    
    figure.name = params[:figure]["name"] if params[:figure]["name"] != ""

    if params[:figure].has_key?("title_ids")
      figure.titles = params[:figure]["title_ids"].map do |title_id|
        Title.find(title_id)
      end
    else
      figure.titles.clear
    end
    if params[:new_title] != ""
      title = Title.find_or_create_by(name: params[:new_landmark])
      figure.titles << title
    end

    if params[:figure].has_key?("landmark_ids")     
      figure.landmarks = params[:figure]["landmark_ids"].map do |landmark_id|
        Landmark.find(landmark_id)
      end
    else
      figure.landmarks.clear
    end
    if params[:new_landmark] != ""
      landmark = Landmark.find_or_create_by(name: params[:new_landmark])
      figure.landmarks << landmark
    end

    figure.save
    redirect to "/figures/#{params[:id]}"
  end

end