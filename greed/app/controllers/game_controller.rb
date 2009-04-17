class GameController < ApplicationController
  def new
  end

  def create
    @game = Game.create
    @game.web_player = Player.create(params[:player])
    if @game.save
      session[:game] = @game.id
      redirect_to :action => "add_players", :id => @game.id
    else
      flash[:error] = "Can not create game"
      redirect_to :action => "new"
    end
  end

end
