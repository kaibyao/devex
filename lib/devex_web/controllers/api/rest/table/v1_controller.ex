defmodule DevexWeb.Api.Rest.Table.V1Controller do
  use DevexWeb, :controller

  @doc """
  Displays a list of the latest 100 records of a table
  """
  def index(conn, _params) do
    conn
    |> json(%{"test" => "test"})
  end

  def create(conn, _params) do
    conn
    |> json(%{})
  end
end
