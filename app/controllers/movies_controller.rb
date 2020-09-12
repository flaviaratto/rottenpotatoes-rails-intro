class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @all_ratings=Movie.uniq.pluck(:rating)
    
    sort_column = params[:sort_column]
    sort_column ||='release_date'
    
    sort_direction = params[:sort_direction]
    sort_direction ||= "desc"
    
    @ratings_selected = params[:ratings]
    if(@ratings_selected)
      @ratings_selected_keys = @ratings_selected.keys
    else
      @ratings_selected_keys = @all_ratings
    end
    
    
    #Filtering and sorting
    @movies = Movie.where(rating: @ratings_selected_keys).order(sort_column +" "+ sort_direction)
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
