# Klarna assignment

## First assignment

> If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
> Finish the solution so that it returns the sum of all the multiples of 3 or 5 below the number passed in.

### Solution

See [`first.erl`](apps/first/src/first.erl) in application `first`.

```erlang
solution(Num)
when is_integer(Num) andalso Num >= 0 ->
    solution_loop(Num - 1, 0);

solution(_Num) ->
    throw(badarg).


solution_loop(CurrentNum, Acc)
when CurrentNum >= 3
andalso (CurrentNum rem 3 == 0 orelse CurrentNum rem 5 == 0) ->
    solution_loop(CurrentNum - 1, Acc + CurrentNum);

solution_loop(CurrentNum, Acc)
when CurrentNum >= 3 ->
    solution_loop(CurrentNum - 1, Acc);

solution_loop(_CurrentNum, Acc) ->
    Acc.
```
