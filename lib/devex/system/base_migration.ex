defmodule Devex.System.BaseMigration do
  @moduledoc """
  A module used for initializing base fields used on every created table.
  """

  use Ecto.Migration

  @doc """
  Used in a migration file. Creates a table with the given name. The provided expression is executed in the `create table` clause.
  """
  @spec create_table_with_default_fields(atom | String.t(), any) :: any
  defmacro create_table_with_default_fields(table_name, do: quoted_create_table_expression) do
    quote do
      unquoted_table_name = unquote(table_name)

      create table(unquoted_table_name, primary_key: false) do
        add(:id, :bigint, primary_key: true)
        add(:created_by, references(:sys_user))
        add(:updated_by, references(:sys_user))

        unquote(quoted_create_table_expression)

        timestamps(
          inserted_at: :created_at,
          type: :timestamptz,
          default: fragment("CURRENT_TIMESTAMP")
        )
      end

      create(index(unquoted_table_name, [:created_at]))
      create(index(unquoted_table_name, [:created_by]))
      create(index(unquoted_table_name, [:updated_at]))
      create(index(unquoted_table_name, [:updated_by]))

      flush()

      execute("""
      ALTER TABLE #{unquoted_table_name} ALTER COLUMN id SET DEFAULT next_id()
      """)
    end
  end
end
