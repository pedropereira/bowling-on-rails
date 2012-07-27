class GamesController < ApplicationController
  def index
    @games = Game.order("created_at DESC").all
  end

  def create
    @game = Game.new(params[:id])
    if @game.save
      redirect_to @game
    else
      redirect_to root_url
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])

    begin
      @game.roll!(params[:number_of_pins].to_i)
    rescue Exception => exception
      flash[:notice] = exception.message
    end

    redirect_to game_path(@game)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to games_path
  end
end
