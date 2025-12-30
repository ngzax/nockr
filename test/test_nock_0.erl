-module(test_nock_0).
-include_lib("eunit/include/eunit.hrl").

%%
%% Nock 0 Tests: Tree Addressing
%% *[a 0 b] -> /[b a]
%%

nock_0_slot_1_test() ->
    %% [[50 51] [0 1]]
    Nock = nock:parse("[[50 51] [0 1]]"),
    Subject = noun:at(2, Nock),
    Opcode = noun:at(2, noun:at(3, Nock)),
    Slot = noun:at(3, noun:at(3, Nock)),

    %% Verify structure
    ?assertEqual([50, 51], noun:to_list(Subject)),
    ?assertEqual(0, Opcode),
    ?assertEqual(1, Slot),

    %% Interpret: should return the whole subject
    Result = nock:interpret(Nock),
    ?assertEqual({50, 51}, Result),
    ?assertEqual([50, 51], noun:to_list(Result)).

nock_0_slot_2_test() ->
    %% [[50 51] [0 2]]
    Nock = nock:parse("[[50 51] [0 2]]"),
    Opcode = noun:at(2, noun:at(3, Nock)),
    Slot = noun:at(3, noun:at(3, Nock)),

    ?assertEqual(0, Opcode),
    ?assertEqual(2, Slot),

    %% Interpret: should return the head of subject (50)
    Result = nock:interpret(Nock),
    ?assertEqual(50, Result).

nock_0_bad_slot_test() ->
    %% [[50 51] [0 8]] - slot 8 doesn't exist in [50 51]
    Nock = nock:parse("[[50 51] [0 8]]"),
    Opcode = noun:at(2, noun:at(3, Nock)),
    Slot = noun:at(3, noun:at(3, Nock)),

    ?assertEqual(0, Opcode),
    ?assertEqual(8, Slot),

    %% Should crash on invalid slot
    ?assertThrow({error, _}, nock:interpret(Nock)).

nock_0_cell_slot_test() ->
    %% [[50 51] [0 [0 1]]] - slot must be an atom
    Nock = nock:parse("[[50 51] [0 [0 1]]]"),

    %% Should crash when slot is a cell
    ?assertThrow({error, slot_must_be_atom}, nock:interpret(Nock)).

%%
%% Nock 1 Tests: Constant
%% *[a 1 b] -> b
%%

nock_1_echo_atom_test() ->
    %% [[20 30] [1 67]] -> 67
    Nock = nock:parse("[[20 30] [1 67]]"),
    Result = nock:interpret(Nock),
    ?assertEqual(67, Result).

nock_1_echo_cell_test() ->
    %% [[20 30] [1 [2 587]]] -> [2 587]
    Nock = nock:parse("[[20 30] [1 [2 587]]]"),
    Result = nock:interpret(Nock),
    ?assertEqual([2, 587], noun:to_list(Result)).
