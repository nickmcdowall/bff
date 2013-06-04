-module(bff_post_controller, [Req]).
-compile(export_all).

before_(_) ->
	user_lib:require_login(Req).

create('GET', [], Person) ->
	ok;
create('POST', [], Person) ->
	PostText = Req:post_param("post_text"),
	NewPost = post:new(id, PostText, Person:id()),
	case NewPost:save() of
		{ok, SavedPost} -> 
			{redirect, [{action, "list"}]};
		{error, ErrorList} -> 
			{ok, [{errors, ErrorList}, 
			{new_msg, NewPost}]}
	end.

list('GET', [], Person) ->
	Posts = boss_db:find(post, []),
	{ok, [{posts, Posts}, {person, Person}]}.

view('GET', [PostId], Person) ->
    Post = boss_db:find(PostId),
    {ok, [{post, Post}]}.


remove('POST', [], Person) ->
	boss_db:delete(Req:post_param("post_id")),
	{redirect, [{action, "list"}]}.