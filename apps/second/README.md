## Second assignment

Original problem:

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

See [`second.erl`](src/second.erl).

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

### Tests

See [`second_SUITE.erl`](test/second_SUITE.erl).
