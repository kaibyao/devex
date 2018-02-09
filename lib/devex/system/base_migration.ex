defmodule Devex.System.BaseMigration do
  @moduledoc """
  A module used for initializing base fields used on every created table.
  """

  use Ecto.Migration

  defp add_default_create_table_fields(table_name, quoted_create_table_expression) do
    quote do
      create table(unquote(table_name), primary_key: false) do
        add(:id, :bigint, primary_key: true)
        add(:created_by, references(:sys_user))
        add(:updated_by, references(:sys_user))


        unquote(quoted_create_table_expression)

        timestamps(inserted_at: :created_at, type: :timestamptz)
      end
    end

    create(index(table_name, [:created_at]))
    create(index(table_name, [:created_by]))
    create(index(table_name, [:updated_at]))
    create(index(table_name, [:updated_by]))

    flush()

    execute("""
    ALTER TABLE #{table_name} ALTER COLUMN id SET DEFAULT next_id()
    """)
  end

  # @spec add_default_create_table_fields_macro(atom | String.t(), [
  #         %{name: atom | String.t(), type: any, opts: any}
  #       ]) :: any
  @doc """
  Used in a migration file. Creates a table with a specified name + column attributes.
  """
  defmacro macro_add_default_create_table_fields(table_name, do: create_table_expression) do
    add_default_create_table_fields(table_name, create_table_expression)
  end

  # def migration_table_fields(table_name, fields \\ []) do
  #   create table(table_name, primary_key: false) do
  #     add(:id, :bigint, primary_key: true)
  #     add(:created_by, references(:sys_user))
  #     add(:updated_by, references(:sys_user))
  #     # add :other_schema_id, references(:other_schema, type: :bigint)

  #     for field <- fields do
  #       case field[:opts] do
  #         nil -> add(field.name, field.type)
  #         _   -> add(field.name, field.type, field[:opts])
  #       end
  #     end

  #     timestamps(inserted_at: :created_at, type: :timestamptz)
  #   end

  #   create(index(table_name, [:created_at]))
  #   create(index(table_name, [:created_by]))
  #   create(index(table_name, [:updated_at]))
  #   create(index(table_name, [:updated_by]))

  #   flush()

  #   execute("""
  #   ALTER TABLE #{table_name} ALTER COLUMN id SET DEFAULT next_id()
  #   """)
  # end
end
