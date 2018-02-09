defmodule Devex.System.BaseSchema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      alias Devex.Repo.Types.EctoBigint, as: Bigint

      # `read_after_writes: true` is needed to return the id on insert etc.
      @primary_key {:id, Bigint, read_after_writes: true}
      @timestamps_opts [inserted_at: :created_at, type: :utc_datetime]
      @derive {Poison.Encoder, only: [:id]}
    end
  end
end
