class PlaylistsController < ApplicationController

	before_action :authenticate_user!


	def index#primera parte vamos app/views y creamos index.html.rb
		@playlists  = Playlist.all
		#el Playlist.all viene del modelo Playlist
		#el @simboliza variables que corresponden a la instancia
		#con esto nos traemos todas las listas de reproduccion disponibles
	end

	def show
		@playlist = Playlist.find(params[:id])
	end

	def new
		@playlist = Playlist.new
	end

	def create
		#strong params
		@playlist = Playlist.new(playlist_params)
		if @playlist.save
			redirect_to @playlist
			#podemos usar redirect_to en vez de usar el 
			#redireccionamiento con http para ahorrar tiempo
		else
			render :new
		end
	end

	def update
		@playlist = Playlist.find(params[:id])
    respond_to do |format|
      if @playlist.update(playlist_params)
        #si podemos editar
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        #muestra el formulario
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
  	@playlist = Playlist.find(params[:id])
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	private

	def playlist_params
		params.require(:playlist).permit(:name, :number_of_votes)
		
	end
end
