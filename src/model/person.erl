-module(person, [Id, Name, PasswordHash]).
-compile(export_all).
-has({posts, many}).

-define(SECRET_STRING, "A best friend is for life not just christmas!").

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
		{fun() -> length(Name) > 0 end, "Username can't be empty!"},
		{fun() -> length(Name) =< 100 end, "Username is too long!"},
		{fun() -> length(PasswordHash) > 0 end, "Password can't be empty."}
	].

before_create() -> 
	lager:info("I eat porrige!"),
	case record_exists_with(Name)  of
		false -> ok;
		true  -> {error, ["Sorry, [" ++Name ++ "] has already been taken.."]}
	end.

before_update() ->
	lager:info("The wind in the willows!"),
	Person = boss_db:find(Id),
	case Person:name() =:= Name of
		true -> ok;
		false -> {error, ["Sorry " ++ Person:name() ++ ", usernames cannot be changed."]}
	end.

record_exists_with(Name) ->
	case boss_db:count(person, [name, equals, Name]) of
		0 -> false; 
		_ -> true
	end.
