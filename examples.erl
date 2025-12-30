#!/usr/bin/env escript
%%! -pa ebin

-module(examples).
-export([main/1]).

main(_) ->
    io:format("~n=== Nock Interpreter Examples ===~n~n"),

    %% Example 1: Tree addressing (Nock 0)
    io:format("Example 1: Tree Addressing~n"),
    io:format("  Input: [[50 51] [0 1]]~n"),
    R1 = nock:nock("[[50 51] [0 1]]"),
    io:format("  Result: ~p~n~n", [R1]),

    %% Example 2: Get head
    io:format("Example 2: Get Head of Cell~n"),
    io:format("  Input: [[50 51] [0 2]]~n"),
    R2 = nock:nock("[[50 51] [0 2]]"),
    io:format("  Result: ~p~n~n", [R2]),

    %% Example 3: Constant (Nock 1)
    io:format("Example 3: Return Constant~n"),
    io:format("  Input: [[20 30] [1 67]]~n"),
    R3 = nock:nock("[[20 30] [1 67]]"),
    io:format("  Result: ~p~n~n", [R3]),

    %% Example 4: Constant with cell
    io:format("Example 4: Return Cell Constant~n"),
    io:format("  Input: [[20 30] [1 [2 587]]]~n"),
    R4 = nock:nock("[[20 30] [1 [2 587]]]"),
    io:format("  Result: ~p~n~n", [R4]),

    %% Example 5: Increment (Nock 4)
    io:format("Example 5: Increment~n"),
    io:format("  Input: [50 [4 [0 1]]]~n"),
    R5 = nock:nock("[50 [4 [0 1]]]"),
    io:format("  Result: ~p~n~n", [R5]),

    %% Example 6: Direct API usage
    io:format("Example 6: Direct API Usage~n"),
    Noun = noun:from_list([50, 51]),
    io:format("  Created noun from [50, 51]: ~p~n", [Noun]),
    Head = noun:at(2, Noun),
    io:format("  Head (at index 2): ~p~n", [Head]),
    Tail = noun:at(3, Noun),
    io:format("  Tail (at index 3): ~p~n", [Tail]),
    Incremented = noun:increment(Head),
    io:format("  Incremented head: ~p~n~n", [Incremented]),

    io:format("=== All examples completed ===~n~n").
