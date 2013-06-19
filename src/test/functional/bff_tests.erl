-module(bff_tests).
-compile(export_all).

start() ->
	boss_web_test:get_request("/", [], 
		[fun boss_assert:http_redirect/1], [
			"Redirect to login page",
			fun(Response1) ->
				boss_web_test:follow_redirect(Response1, 
					[
					 	fun boss_assert:http_ok/1,
						fun(Response1) -> boss_assert:tag_with_text("title", "Sign In", Response1) end
					], [
						"Login with unregistered user",
						fun(Response2a) -> boss_web_test:submit_form("login", 
							[{"Username:", "clive"}, {"Password:", "abc"}], Response2a, 
							[
							 	fun boss_assert:http_ok/1,
								fun(Response2a) -> boss_assert:tag_with_text("p", "Invalid username/password", Response2a) end
							], [])
						end,
						
						"Navigate to Register page",
						fun(Response2b) ->
							boss_web_test:follow_link("Register", Response2b,
							[
								fun boss_assert:http_ok/1,
								fun(Response2b) -> boss_assert:tag_with_text("title", "Register", Response2b) end
							], 
							[
								"Register blank user",
								fun(Response3a) -> 
									boss_web_test:submit_form("register", 
									[{"Username:", ""}, {"Password:", ""}], Response3a, 
									[
									 	fun boss_assert:http_ok/1,
										fun(Response3a) -> boss_assert:tag_with_text("p", "Username can't be empty!", Response3a) end
									], [])
								end
							])
						end
					])
			end
		]).
