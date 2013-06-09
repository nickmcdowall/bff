-module(bff_welcome_controller, [Req]).
-compile(export_all).

before_(_) ->
	user_lib:require_login(Req).

index('GET', [], Person) ->
	{ok, [{person, Person}]}.