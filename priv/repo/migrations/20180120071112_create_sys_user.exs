defmodule Devex.Repo.Migrations.CreateSysUser do
  use Ecto.Migration
  require Devex.System.BaseMigration

  def up do
    # BaseMigration.migration_table_fields(:sys_user, [
    #   %{:name => :first_name, :type => :string},
    #   %{:name => :last_name, :type => :string},
    #   %{:name => :email, :type => :string}
    # ])
    Devex.System.BaseMigration.macro_add_default_create_table_fields(
      :sys_user,
      do:
        (quote do
          add(:first_name, :string)
          add(:last_name, :string)
          add(:email, :string)
        end)
    )
  end

  def down do
    drop(table("sys_user"))
  end
end
