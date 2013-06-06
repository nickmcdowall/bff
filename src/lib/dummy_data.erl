%% @doc Utility module to load some dummy data quickly and easily.
-module(dummy_data).
-compile(export_all).

%%--------------------------------------------------------------------
%% @doc load dummy data into the db.
%% @spec load() -> ok | {error, Reason}
%% @end
%%--------------------------------------------------------------------
load() ->
	Person = person:new(id, "bob", "92e7928958ca35284f2f382c8b7eb509"),
	case Person:save() of
		{error,[Reason]} -> 
			{error, Reason};
		{ok, _} ->
			Post = post:new(id, "What a lovely day!", Person:id()),
			Post:save(),
			ok
	end.
