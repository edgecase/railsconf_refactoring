class GameController < ApplicationController
  def new
  end

  def create
    @game = Game.create
    @game.human_player = HumanPlayer.create(params[:player])
    if @game.save
      session[:game] = @game.id
      redirect_to choose_players_game_path(@game)
    else
      flash[:error] = "Can not create game"
      redirect_to new_game_path
    end
  end

  def choose_players
    @game = Game.find(params[:id])
    @players = AutoPlayer.players
  end

  def assign_players
    @game = Game.find(params[:id])
    redirect_to auto_turn_game_path(@game)
  end

end
