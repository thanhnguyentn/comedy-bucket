class ArtistsController < ApplicationController
  def index

    if params[:search].present?
      @artists = Artist.search_by_name(params[:search])
      if @artists.empty?
        redirect_to add_path
      end
    else
      @artists = Artist.order(:name).includes(:videos)
    end
  end

  def show
    @artist = Artist.find(params[:id])
    @schedules = Schedule.where(:artist_id => @artist.id).order(:time)
    @videos = Video.where(:artist_id => @artist.id)
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(params_artist)
    if @artist.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update(params_artist)
    redirect_to root_path
  end

  def add
    @comedian = Comedian.new
    @comedians = Comedian.all
  end

  private

  def params_artist
    params.require(:artist).permit(:name, :photo, :info)
  end
end
