defmodule MikuPhoenixWeb.PageController do
  use MikuPhoenixWeb, :controller

  def getRandomMiku do
    Enum.map(Path.wildcard("priv/static/images/*"), fn x -> String.slice(x,11..-1) end)
    |> Enum.random()
  end

  def index(conn, _params) do
    render(conn, "index.html", image: getRandomMiku())
  end

  def api(conn, _params) do
    json(conn, %{username: getRandomMiku()})
  end

  def fakedashboard(conn, _params) do
    redirect(conn, external: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")
  end

end
