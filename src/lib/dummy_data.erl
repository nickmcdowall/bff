%% @doc Utility module to load some dummy data quickly and easily.
-module(dummy_data).
-compile(export_all).

%%--------------------------------------------------------------------
%% @doc load dummy data into the db.
%% @spec load() -> ok | {error, Reason}
%% @end
%%--------------------------------------------------------------------
load(Name) ->
	Person = person:new(id, Name, user_lib:hash_for(Name, Name)),
	case Person:save() of
		{ok, SavedPerson} ->
			lager:info("Saved Person:~p", [SavedPerson]),
			Post = post:new(id, Name ++ " is my name!", SavedPerson:id()),
			Post:save(),
			ok;
		{error,[Reason]} -> 
			lager:warning("Failed to save person: ~p", [Person]),
			{error, Reason};
		_ ->
			{error, unknown}
	end.
