-module(functional_tests).
-compile(export_all).

start() ->
	boss_web_test:get_request("/", [], [
		fun boss_assert:http_ok/1
	], []).
