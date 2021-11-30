class SongsController < ApplicationController
  def index
    artist_id = params[:artist_id]
    if artist_id
      if artist_id.to_i <= Artist.all.last.id && artist_id.to_i != 0
        @songs = Artist.find(params[:artist_id]).songs
      else
        redirect_to(artists_path)
        flash[:alert] = "Artist not found."
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:id].to_i <= Song.all.last.id
      @song = Song.find(params[:id])
    else
      if params[:artist_id]
        redirect_to(artist_songs_path(params[:artist_id]))
        flash[:alert] = "Song not found."
      else
        redirect_to(songs_path)
        flash[:alert] = "Song not found."
      end
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

