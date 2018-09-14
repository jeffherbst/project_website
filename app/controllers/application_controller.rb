class ApplicationController < ActionController::Base
  def hello_world
    name = params['name'] || "World"
    render 'application/hello_world', locals: {name: name}
  end

  def list_games
    games = connection.execute("SELECT * FROM games")

    render 'application/list_games', locals: {games: games}
  end

  def show_game
    game = connection.execute("SELECT * FROM games WHERE games.id = ? LIMIT 1", params['id']).first

    render 'application/show_game', locals: {game: game}
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
