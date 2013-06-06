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

validation_tests() ->
	[
		{fun() -> length(Name) > 0 end, "Your name can't be empty, silly!"},
		{fun() -> length(Name) =< 100 end, "Are you kidding me?!"},
		{fun() -> not_a_duplicate(Name) end, "That name has been taken:" ++ Name},
		{fun() -> length(PasswordHash) > 0 end, 
		 	"Password can't be empty.. use 'user_lib:hash_for(\"name\", \"password\").' in the console."}
	].

not_a_duplicate(Name) ->
	case boss_db:find(person, [name, 'equals', Name], []) of
		[]			-> true;
		_Something	-> false
	end.