%% @doc Utility module to load some dummy data quickly and easily.
-module(dummy_data).
-compile(export_all).

%%--------------------------------------------------------------------
%% @doc load dummy data into the db.
%% @spec load() -> ok | {error, Reason}
%% @end
%%--------------------------------------------------------------------
load() ->
	Bob = person:new(id, "bob", "92e7928958ca35284f2f382c8b7eb509"),
	case Bob:save() of
		{ok, SavedBob} ->
			lager:info("Saved Bob:~p", [SavedBob]),
			Post = post:new(id, "What a lovely day!", SavedBob:id()),
			Post:save(),
			ok;
		{error,[Reason]} -> 
			lager:warning("Failed to save person: ~p", [Bob]),
			{error, Reason};
		_ ->
			{error, unknown}
	end.
