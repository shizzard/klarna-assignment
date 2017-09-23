-module(second_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").



can_get_minimal_case_test() ->
    ?assertEqual("1 2 3 4 5", second:solution("1 2 3 4 5")).


can_handle_multiple_separators_test() ->
    ?assertEqual("1 2 3 4 5", second:solution("1 2  3   4    5")).


can_handle_empty_string_test() ->
    ?assertEqual("", second:solution("")).


can_handle_long_strings_test() ->
    {ok, [OriginalString]} = file:consult(code:lib_dir(second, test) ++ "/priv/long_string_original.terms"),
    {ok, [ExpectedString]} = file:consult(code:lib_dir(second, test) ++ "/priv/long_string_sorted.terms"),
    ?assertEqual(ExpectedString, second:solution(OriginalString)).


can_get_badarg_on_enexpected_char_test() ->
    ?assertException(throw, badarg, second:solution("1 2 3 4 a")).


can_get_basic_sort_test() ->
    ?assertEqual("1 2 3 4 5", second:solution("5 1 4 2 3")).


can_get_number_sum_based_sort_test() ->
    ?assertEqual("1000 11 41 15 54 67", second:solution("54 67 11 41 15 1000")).


can_get_number_based_sort_test() ->
    ?assertEqual("14 41 45 54 67 76", second:solution("54 76 14 67 45 41")).
