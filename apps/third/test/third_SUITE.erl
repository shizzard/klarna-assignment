-module(third_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").



can_get_minimal_positive_case_test() ->
    ?assertEqual(true, third:solution("()")),
    ?assertEqual(true, third:solution("[]")),
    ?assertEqual(true, third:solution("{}")).


can_get_minimal_negative_case_test() ->
    ?assertEqual(false, third:solution(")")),
    ?assertEqual(false, third:solution("[")).


can_handle_empty_string_test() ->
    ?assertEqual(true, third:solution("")).


can_handle_unexpected_char_test() ->
    ?assertEqual(true, third:solution("[(hello)]")).


can_handle_unbalaced_symbols_test() ->
    ?assertEqual(false, third:solution("(()")),
    ?assertEqual(false, third:solution("())")).


can_handle_mismatched_symbols_test() ->
    ?assertEqual(false, third:solution("[)")).
