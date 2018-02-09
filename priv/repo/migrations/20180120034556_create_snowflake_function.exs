# Taken from https://elixirforum.com/t/triplex-a-complete-solution-to-multi-tenancy-with-pg-schemas/7747/17

defmodule Devex.Repo.Migrations.CreateSnowflakeFunction do
  use Ecto.Migration
  import Devex.Repo, only: [constants: 0]

  def up do
    %{"EPOCH" => epoch} = constants()

    execute """
    CREATE SEQUENCE next_id_seq;
    """

    execute """
    CREATE OR REPLACE FUNCTION next_id(OUT result bigint) AS $$
    DECLARE
      our_epoch bigint := #{epoch};  -- <-Set this to your epoch
      seq_id bigint;
      now_millis bigint;
      shard_id int := #{shard_id()};  -- Set int value here per shard
      BEGIN
        SELECT nextval('next_id_seq') % 1024 INTO seq_id;

        SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
        result := (now_millis - our_epoch) << 23;
        result := result | (shard_id << 10);
        result := result | (seq_id);
      END;
    $$ LANGUAGE PLPGSQL;
    """
  end

  def down do
    execute """
    DROP SEQUENCE next_id_seq;
    """

    execute """
    DROP FUNCTION next_id();
    """
  end

  defp shard_id() do
    # Until we do actual sharding, ignore this
    #[_, id] = prefix() |> String.split("_")
    #id
    1
  end
end
