## Third assignment

Original problem:

> Write a function called validBraces that takes a string of braces, and determines if the order of the braces is valid. validBraces should return true if the string is valid, and false if it's invalid.

> All input strings will be nonempty, and will only consist of open parentheses `(` , closed parentheses `)`, open brackets `[`, closed brackets `]`, open curly braces `{` and closed curly braces `}`.

> A string of braces is considered valid if all braces are matched with the correct brace. For example:

> `'(){}[]'` and `'([{}])'` would be considered valid, while `'(}'`, `'[(])'`, and `'[({})](]'` would be considered invalid.

### Solution

See [`third.erl`](apps/third/src/third.erl) in application `third`.

Obvious idea is to use stack here.

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

### Tests

See [`third_SUITE.erl`](test/third_SUITE.erl).
