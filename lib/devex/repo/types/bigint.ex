defmodule Devex.Repo.Types.EctoBigint do
  @behaviour Ecto.Type

  def type, do: :integer

  def cast(string) when is_binary(string), do: _to_integer(string)
  def cast(integer) when is_integer(integer), do: {:ok, integer}
  def cast(_), do: :error

  def load(integer) when is_integer(integer), do: _to_string(integer)

  def dump(string) when is_binary(string), do: _to_integer(string)
  def dump(integer) when is_integer(integer), do: {:ok, integer}
  def dump(_), do: :error

  defp _to_integer(string) do
    case Integer.parse(string) do
      {int, _} -> {:ok, int}
      :error -> :error
    end
  end

  defp _to_string(integer) do
    {:ok, Integer.to_string(integer)}
  end
end
