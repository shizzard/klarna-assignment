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

## Second assignment

> You are provided a string containing a list of positive integers separated by a space (" "). Take each value and calculate the sum of its digits, which we call it's "weight". Then return the list in ascending order by weight, as a string joined by a space.

> For example 99 will have "weight" 18, 100 will have "weight"
> 1 so in the ouput 100 will come before 99.

> Example:

> "56 65 74 100 99 68 86 180 90" ordered by numbers weights becomes:
> "100 180 90 56 65 74 68 86 99"

> When two numbers have the same "weight", let's consider them to be strings and not numbers:

> 100 is before 180 because its "weight" (1) is less than the one of 180 (9)
and 180 is before 90 since, having the same "weight" (9) it comes before as a string.

> All numbers in the list are positive integers and the list can be empty.

### Solution

See [`second.erl`](apps/second/src/second.erl) in application `second`.

Solution is based on `orddict` data structure usage to get numbers sorted by sum. Sorting "equal" numbers is performed with `lists:sort/1` function.

```erlang
solution(String) ->
    NumbersOrddict = split_string(String),
    {_NumbersSums, Numbers} = lists:unzip(orddict:to_list(NumbersOrddict)),
    lists:flatten(
        lists:join($\ ,
            lists:map(fun(L) ->
                lists:join($\ , lists:sort(L))
            end, Numbers))).


split_string(String) ->
    split_string_loop(String, {orddict:new(), []}).


split_string_loop([$\ | String], {Acc, []}) ->
    % 'skip extra space' case
    split_string_loop(String, {Acc, []});

split_string_loop([$\ | String], {Acc, Num}) ->
    % 'add number to acc' case
    split_string_loop(String, {orddict:append(number_sum(Num), Num, Acc), []});

split_string_loop([Char | String], {Acc, Num})
when ?is_valid_digit_char(Char) ->
    % 'add digit to number' case
    split_string_loop(String, {Acc, Num ++ [Char]});

split_string_loop([_Char | _String], {_Acc, _Num}) ->
    % 'invalid character' case
    throw(badarg);

split_string_loop([], {Acc, []}) ->
    % 'end empty last number' case
    Acc;

split_string_loop([], {Acc, LastNum}) ->
    % 'end non-empty last number' case
    orddict:append(number_sum(LastNum), LastNum, Acc).


number_sum(Num) when is_list(Num) ->
    lists:sum(lists:map(fun(I) -> I - 48 end, Num)).
```

## Third assignment

> Write a function called validBraces that takes a string of braces, and determines if the order of the braces is valid. validBraces should return true if the string is valid, and false if it's invalid.

> All input strings will be nonempty, and will only consist of open parentheses `(` , closed parentheses `)`, open brackets `[`, closed brackets `]`, open curly braces `{` and closed curly braces `}`.

> A string of braces is considered valid if all braces are matched with the correct brace. For example:

> `'(){}[]'` and `'([{}])'` would be considered valid, while `'(}'`, `'[(])'`, and `'[({})](]'` would be considered invalid.

### Solution

See [`third.erl`](apps/third/src/third.erl) in application `third`.

```erlang
solution(String) ->
    solution_loop(String, []).


solution_loop([Symbol | String], Stack)
when ?is_opening_symbol(Symbol)
andalso length(String) =< length(Stack) ->
    % 'opening symbol on too large stack' case
    false;

solution_loop([Symbol | String], Stack)
when ?is_opening_symbol(Symbol) ->
    % 'opening symbol' case
    solution_loop(String, [Symbol | Stack]);

solution_loop([Symbol | String], [StackedSymbol | Stack])
when ?is_closing_symbol(Symbol)
andalso ?does_match(Symbol, StackedSymbol) ->
    % 'closing symbol match' case
    solution_loop(String, Stack);

solution_loop([Symbol | _String], _Stack)
when ?is_closing_symbol(Symbol) ->
    % 'closing symbol mismatch' case
    false;

solution_loop([_Symbol | String], Stack) ->
    % 'non-opening and non-closing symbol' case
    solution_loop(String, Stack);

solution_loop([], []) ->
    % 'end empty string and empty stack' case
    true;

solution_loop([], _Stack) ->
    % 'end empty string and non-empty stack' case
    false.
```
