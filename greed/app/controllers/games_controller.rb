class GamesController < ApplicationController

  def new
  end
  
  def create 
    redirect_to choose_players_game_path(0) unless params[:game][:players]
  end
  
  def choose_players
  end
  
end
