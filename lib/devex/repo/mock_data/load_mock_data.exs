# load sys_user
json_sys_user_str = File.read!(__DIR__ <> "/sys_user.json")
json_sys_user_arr = Poison.decode!(json_sys_user_str)

json_sys_user_atom_keys =
  for json_sys_user_obj <- json_sys_user_arr,
      do: Map.new(json_sys_user_obj, fn {key, val} -> {String.to_atom(key), val} end)

{num_inserted, _} =
  Devex.Repo.insert_all(
    {"sys_user", Devex.System.User},
    json_sys_user_atom_keys,
    on_conflict: :replace_all,
    conflict_target: :id
  )

IO.puts("Inserted #{num_inserted} records into sys_user.")
