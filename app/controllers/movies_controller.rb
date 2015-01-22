class MoviesController < ApplicationController
  before_action :authenticate_user! , except: [:index , :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
  end

  def index
    @movies = Movie.all
    respond_with(@movies)
  end

  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def new
    @movie = current_user.movies.build
    respond_with(@movie)
  end

  def edit
  end

  def create
    @movie = current_user.movies.build(movie_params)
    @movie.upload_from_url(params[:remote_url]) if params[:remote_url].present?
    @movie.save
    respond_with(@movie)
  end

  def update
    @movie.upload_from_url(params[:remote_url]) if params[:remote_url].present?
    @movie.update(movie_params)

    respond_with(@movie)
  end

  def destroy
    @movie.destroy
    respond_with(@movie)
  end

  def remove_photo
    @movie = Movie.find(params[:id])
    if @movie.image.present?
      @movie.image = nil
      @movie.save
      redirect_to edit_movie_path(@movie)
    else
      redirect_to @movie
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating , :image , :remote_image)
    end
end
