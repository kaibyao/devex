defmodule Devex.Repo do
  use Ecto.Repo, otp_app: :devex

  def constants() do
    %{
      "EPOCH" => 1_516_420_367_123
    }
  end

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
