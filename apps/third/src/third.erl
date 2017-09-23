-module(third).

-export([solution/1]).

-define(
    is_opening_symbol(Symbol),
    ((Symbol == $() orelse (Symbol == $[) orelse (Symbol == ${))
).
-define(
    is_closing_symbol(Symbol),
    ((Symbol == $)) orelse (Symbol == $]) orelse (Symbol == $}))
).
-define(
    does_match(ClosingSymbol, OpeningSymbol),
    (
        (ClosingSymbol == $) andalso OpeningSymbol == $() orelse
        (ClosingSymbol == $] andalso OpeningSymbol == $[) orelse
        (ClosingSymbol == $} andalso OpeningSymbol == ${)
    )
).

-type stack() :: [$( | $[ | ${].


%% Interface


-spec solution(String :: string()) ->
    Ret :: boolean().

solution(String) ->
    solution_loop(String, []).


%% Internals


-spec solution_loop(String :: string(), Stack :: stack()) ->
    Ret :: boolean().

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
