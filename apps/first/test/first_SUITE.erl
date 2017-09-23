-module(first_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").



can_get_minimal_case_test() ->
    ?assertEqual(3, first:solution(4)).


can_get_happy_path_test() ->
    ?assertEqual(23, first:solution(10)).


can_get_result_on_big_number_test() ->
    ?assertEqual(2333333316666668, first:solution(100000000)).


can_get_valid_result_on_positive_integer_test() ->
    ?assertEqual(0, first:solution(2)).


can_get_badarg_on_negative_integer_test() ->
    ?assertException(throw, badarg, first:solution(-1)).
