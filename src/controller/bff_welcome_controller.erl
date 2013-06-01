-module(bff_welcome_controller, [Req]).
-compile(export_all).

index('GET', []) ->
	{ok, []}.