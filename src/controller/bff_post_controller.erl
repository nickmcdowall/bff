-module(bff_post_controller, [Req]).
-compile(export_all).

before_(_) ->
	user_lib:require_login(Req).

create('GET', [], Person) ->
	{ok, [{person, Person}]};
create('POST', [], Person) ->
	PostText = Req:post_param("post_text"),
	NewPost = post:new(id, PostText, Person:id(), erlang:now()),
	case NewPost:save() of
		{ok, SavedPost} -> 
			{redirect, [{controller, "welcome"},{action, "index"}]};
		{error, ErrorList} -> 
			{ok, [{errors, ErrorList}, 
			{new_msg, NewPost}]}
	end.

list('GET', [], Person) ->
	{ok, [{posts, Person:posts()}, {person, Person}]}.


remove('POST', [], Person) ->
	boss_db:delete(Req:post_param("post_id")),
	{redirect, [{controller, "welcome"},{action, "index"}]}.