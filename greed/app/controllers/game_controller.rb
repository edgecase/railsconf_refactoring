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
    player_names = params[:players] || []
    if player_names.empty?
      flash[:error] = "Please select at least one computer player"
      redirect_to choose_players_game_path(@game)
    else
      player_names.each do |player_name|
        p = ComputerPlayer.new(:name => player_name)
        @game.computer_players << p
      end
      
      @game.save
      redirect_to computer_turn_game_path(@game)
    end
  end

  def computer_turn
    @game = Game.find(params[:id])
    @players = @game.computer_players + [@game.human_player]
  end

end
