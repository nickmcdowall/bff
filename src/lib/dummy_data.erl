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
			Post = post:new(id, Name ++ " is my name!", SavedPerson:id()),
			Post:save(),
			ok;
		{error,[Reason]} -> 
			{error, Reason};
		Other ->
			{error, Other}
	end.
