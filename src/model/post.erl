-module(post, [Id, PostText, PersonId, CreationTime]).
-compile(export_all).
-belongs_to(person).

% Make sure that the post is valid before saving.
validation_tests() ->
	[
		{fun() -> length(PostText) > 0 end, "What's the point in an empty post?!"},
		{fun() -> length(PostText) =< 500 end, "Way too long dude, keep it to 500!"}
	].