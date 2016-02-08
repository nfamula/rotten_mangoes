class MoviesController < ApplicationController

  def index
    if params[:title] || params[:director] || params[:runtime_in_minutes]
      @movies = Movie.search(params[:title], params[:director]).runtime(params[:runtime_in_minutes])
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  #scope :search, -> (term) { where('title LIKE ? OR director LIKE ? description LIKE ?', "%#{term}%") } #lambda

  #def self.search_title(term)
   #where('title LIKE ?', "%#{term}%")
  #end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster, :description
    )
  end
end
