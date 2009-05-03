class GamesController < ApplicationController
  def new
  end

  def create
    @human_player = HumanPlayer.create(params[:game])
    @game = Game.create(:human_player => @human_player)
    if @game.human_player.save && @game.save
      session[:game] = @game.id
      redirect_to choose_players_game_path(@game)
    else
      flash[:error] = "Can not create game\n"
      flash[:error] << @human_player.errors.full_messages.join(', ')
      redirect_to new_game_path
    end
  end

  def choose_players
    @game = Game.find(params[:id])
    @players = AutoPlayer.players
  end

  def assign_players
    @game = Game.find(params[:id])
    strategy_names = params[:players] || []
    if strategy_names.empty?
      flash[:error] = "Please select at least one computer player"
      redirect_to choose_players_game_path(@game)
    else
      @game.computer_players.clear
      strategy_names.each do |strategy|
        p = ComputerPlayer.new(:strategy => strategy)
        @game.computer_players << p
      end
      
      @game.save
      redirect_to computer_turn_game_path(@game)
    end
  end

  def computer_turn
    setup_page_data
    @game.computer_players.each do |cp|
      turn = cp.take_turn
      cp.score += turn.score
      cp.save
    end
    redirect_to computer_turn_results_game_path(@game)
  end

  def computer_turn_results
    setup_page_data
    @turn_histories = @game.computer_players.map { |p| p.last_turn }
  end

  def human_turn
    setup_page_data
    @roll = []
    roller = Roller.new
    roller.roll(5)
    @roll_data = RollData.new(roller.faces, 0, roller.points, roller.unused, :unknown)
  end

  private

  def setup_page_data
    @game = Game.find(params[:id])
    @players = @game.players
  end

end
