-module(bff_tests).
-compile(export_all).

start() ->
	boss_web_test:get_request("/", [], 
		[fun boss_assert:http_redirect/1], [
			"Redirect to login page",
			fun(Response1) ->
				boss_web_test:follow_redirect(Response1, 
					[fun boss_assert:http_ok/1], [
						"Navigate to Register page",
						fun(Response2) ->
							boss_web_test:follow_link("Register", Response2,
							[
							 fun boss_assert:http_ok/1,
							 fun(Response2) -> boss_assert:tag_with_text("h4", "Sign Up:", Response2) end
							], [])
						end
					])
			end
		]).
