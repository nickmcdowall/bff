-module(bff_user_controller, [Req]).
-compile(export_all).

login('GET', []) ->
    {ok, [{redirect, Req:header(referer)}]};
login('POST', []) ->
    Name = Req:post_param("name"),
    case boss_db:find(person, [{name, Name}]) of
        [Person] ->
            case Person:check_password(Req:post_param("password")) of
                true ->
                    {redirect, proplists:get_value("redirect",
                        Req:post_params(), "/"), Person:login_cookies()};
                false ->
                    {ok, [{error, "Bad name/password combination"}]}
            end;
        [] ->
            {ok, [{error, "No Person named " ++ Name}]}
    end.