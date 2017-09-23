-module(first).

-export([solution/1]).


%% Interface


-spec solution(Num :: non_neg_integer()) ->
    Ret :: non_neg_integer().

solution(Num)
when is_integer(Num) andalso Num >= 0 ->
    solution_loop(Num - 1, 0);

solution(_Num) ->
    throw(badarg).


%% Internals


-spec solution_loop(CurrentNum :: non_neg_integer(), Acc :: non_neg_integer()) ->
    Ret :: non_neg_integer().

solution_loop(CurrentNum, Acc)
when CurrentNum >= 3
andalso (CurrentNum rem 3 == 0 orelse CurrentNum rem 5 == 0) ->
    solution_loop(CurrentNum - 1, Acc + CurrentNum);

solution_loop(CurrentNum, Acc)
when CurrentNum >= 3 ->
    solution_loop(CurrentNum - 1, Acc);

solution_loop(_CurrentNum, Acc) ->
    Acc.
