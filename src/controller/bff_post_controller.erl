-module(bff_post_controller, [Req]).
-compile(export_all).

create('GET', []) ->
	ok;
create('POST', []) ->
	PostText = Req:post_param("post_text"),
	NewPost = post:new(id, PostText),
	case NewPost:save() of
		{ok, SavedPost} -> 
			{redirect, [{action, "list"}]};
		{error, ErrorList} -> 
			{ok, [{errors, ErrorList}, 
			{new_msg, NewPost}]}
	end.

list('GET', []) ->
	Posts = boss_db:find(post, []),
	{ok, [{posts, Posts}]}.

remove('POST', []) ->
	boss_db:delete(Req:post_param("post_id")),
	{redirect, [{action, "list"}]}.