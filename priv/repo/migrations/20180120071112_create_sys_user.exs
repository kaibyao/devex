defmodule Devex.Repo.Migrations.CreateSysUser do
  use Ecto.Migration
  require Devex.System.BaseMigration

  def up do
    Devex.System.BaseMigration.create_table_with_default_fields(
      :sys_user,
      do: (
        add(:first_name, :string)
        add(:last_name, :string)
        add(:email, :string)
      )
    )
  end

  def down do
    drop(table("sys_user"))
  end
end
