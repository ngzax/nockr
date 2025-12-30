-module(test_nock_4).
-include_lib("eunit/include/eunit.hrl").

%%
%% Nock 4 Tests:
%%

%%
%% Increment
%% *[a 4 b] -> +*[a b]
%%
nock_4_increment_test() ->
    %% [50 [4 0 1]] -> 51
    %% Subject is 50, formula is [4 0 1]
    %% *[50 4 0 1] -> +*[50 0 1] -> +50 -> 51
    Nock = nock:parse("[50 [4 [0 1]]]"),
    Result = nock:interpret(Nock),
    ?assertEqual(51, Result).
