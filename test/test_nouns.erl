-module(test_nouns).
-include_lib("eunit/include/eunit.hrl").

%%
%% Noun Tests
%%

from_list_test() ->
    ?assertEqual(42, noun:from_list([42])),
    ?assertEqual({1, 2}, noun:from_list([1, 2])),
    ?assertEqual({1, {2, 3}}, noun:from_list([1, 2, 3])).

to_list_test() ->
    ?assertEqual([42], noun:to_list(42)),
    ?assertEqual([1, 2], noun:to_list({1, 2})),
    ?assertEqual([[1, 2], 3], noun:to_list({{1, 2}, 3})).

at_test() ->
    Cell = {50, 51},
    ?assertEqual({50, 51}, noun:at(1, Cell)),
    ?assertEqual(50, noun:at(2, Cell)),
    ?assertEqual(51, noun:at(3, Cell)).

increment_test() ->
    ?assertEqual(51, noun:increment(50)).

is_atom_test() ->
    ?assert(noun:is_atom(42)),
    ?assertNot(noun:is_atom({1, 2})).

is_cell_test() ->
    ?assert(noun:is_cell({1, 2})),
    ?assertNot(noun:is_cell(42)).
