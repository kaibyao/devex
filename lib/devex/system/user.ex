defmodule Devex.System.User do
  alias Devex.System.User
  import Ecto.Changeset
  use Devex.System.BaseSchema

  schema "sys_user" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)

    belongs_to(:sys_user, __MODULE__, type: Bigint)

    # Tell Ecto to use the Bigint type for any relations as well
    # belongs_to :other_schema, OtherSchema, type: Bigint
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
