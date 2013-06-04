-module(person, [Id, Name, PasswordHash]).
-compile(export_all).
-has({posts, many}).

-define(SECRET_STRING, "A bff is for life not just christmas!").

session_identifier() ->
    mochihex:to_hex(erlang:md5(?SECRET_STRING ++ Id)).

check_password(Password) ->
	lager:info("..Checking password:, ~p", [Password]),
    Salt = mochihex:to_hex(erlang:md5(Name)),
    user_lib:hash_password(Password, Salt) =:= PasswordHash.

login_cookies() ->
	lager:info("..in login_cooking function, user_id Id::, ~p", [Id]),
    [ mochiweb_cookies:cookie("user_id", Id, [{path, "/"}]),
        mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}]) ].