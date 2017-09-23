-module(second).

-export([solution/1]).

-define(is_valid_digit_char(Char), (Char >= 48 andalso Char =< 57)).

-type digit() :: 48..57.
-type separator() :: $\ .
-type number_string() :: [digit()].
-type number_sum() :: non_neg_integer().
-type valid_string() :: [digit() | separator()].


%% Interface


-spec solution(String :: string()) ->
    Ret :: valid_string().

solution(String) ->
    NumbersOrddict = split_string(String),
    {_NumbersSums, Numbers} = lists:unzip(orddict:to_list(NumbersOrddict)),
    lists:flatten(
        lists:join($\ ,
            lists:map(fun(L) ->
                lists:join($\ , lists:sort(L))
            end, Numbers))).


%% Internals


-spec split_string(String :: string()) ->
    Ret :: orddict:orddict(KeyT :: number_sum(), ValueT :: number_string()).

split_string(String) ->
    split_string_loop(String, {orddict:new(), []}).


-spec split_string_loop(
    String :: string(),
    SupAcc :: {
        Acc :: orddict:orddict(KeyT :: number_sum(), ValueT :: number_string()),
        Num :: number_string()
    }
) ->
    Ret :: orddict:orddict(KeyT :: number_sum(), ValueT :: number_string()).

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


-spec number_sum(Num :: number_string()) ->
    Ret :: number_sum().

number_sum(Num) when is_list(Num) ->
    lists:sum(lists:map(fun(I) -> I - 48 end, Num)).
