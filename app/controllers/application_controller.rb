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

  def new_game
    render 'application/new_game'
  end

  def create_game
    insert_query = <<-SQL
      INSERT INTO games (name, type, release_date, rating)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query, params['name'], params['type'], params['release_date'], params['rating']

    redirect_to '/list_games'
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
