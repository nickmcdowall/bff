-module(bff_user_controller, [Req]).
-compile(export_all).

login('GET', []) ->
    {ok, []};
login('POST', []) ->
    Name = Req:post_param("name"),
    case boss_db:find(person, [{name, Name}]) of
        [Person] ->
            case Person:check_password(Req:post_param("password")) of
                true ->
                    {redirect, "/", Person:login_cookies()};
                false ->
                    {ok, [{error, "Bad name/password combination"}]}
            end;
        [] ->
            {ok, [{error, "No Person named " ++ Name}]}
    end.

logout('GET', []) ->
    {redirect, "/",
        [ mochiweb_cookies:cookie("user_id", "", [{path, "/"}]),
            mochiweb_cookies:cookie("session_id", "", [{path, "/"}]) ]}.

signup('GET', []) ->
    {ok, []};
signup('POST', []) ->
	Name = Req:post_param("name"),
	Password = Req:post_param("password"),
	Person = person:new(id, Name, user_lib:hash_for(Name, Password)),
	case Person:save() of
		{ok, SavedPerson} ->
			{redirect, [{controller, "welcome"}, {action, "index"}] };
		{error,[Reason]} -> 
			{ok, [{error, Reason}]}
	end.