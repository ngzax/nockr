-module(nock).
-export([parse/1, interpret/1, nock/1]).

%% Parse a string representation into a Nock expression
%% Example: "[[50 51] [0 1]]" -> {{50, 51}, {0, 1}}
parse(String) when is_list(String) ->
    %% Tokenize the string
    Tokens = tokenize(String),
    %% Parse tokens into a list structure
    {Term, _} = parse_tokens(Tokens),
    %% Convert to Noun
    noun:from_list(Term).

%% Tokenize string into brackets and numbers
tokenize(String) ->
    tokenize(String, []).

tokenize([], Acc) ->
    lists:reverse(Acc);
tokenize([$[|Rest], Acc) ->
    tokenize(Rest, ['['|Acc]);
tokenize([$]|Rest], Acc) ->
    tokenize(Rest, [']'|Acc]);
tokenize([$ |Rest], Acc) ->  % skip spaces
    tokenize(Rest, Acc);
tokenize([C|Rest], Acc) when C >= $0, C =< $9 ->
    {Num, Remaining} = parse_number([C|Rest], []),
    tokenize(Remaining, [list_to_integer(lists:reverse(Num))|Acc]).

%% Parse a number from the input
parse_number([C|Rest], Acc) when C >= $0, C =< $9 ->
    parse_number(Rest, [C|Acc]);
parse_number(Rest, Acc) ->
    {Acc, Rest}.

%% Parse tokens into nested list structure
parse_tokens(['['|Rest]) ->
    parse_list(Rest, []);
parse_tokens([N|Rest]) when is_integer(N) ->
    {N, Rest}.

%% Parse a list until we hit the closing bracket
parse_list([']'|Rest], Acc) ->
    {lists:reverse(Acc), Rest};
parse_list(Tokens, Acc) ->
    {Elem, Remaining} = parse_tokens(Tokens),
    parse_list(Remaining, [Elem|Acc]).

%% Main interpreter entry point
nock(Input) when is_list(Input) ->
    Nock = parse(Input),
    io:format("Interpreting ~s as Nock...~n", [Input]),
    Result = interpret(Nock),
    io:format("=> ~p~n", [Result]),
    Result.

%% Interpret a Nock expression
%% Nock structure: [Subject Formula]
interpret(NockExpr) ->
    case is_nock(NockExpr) of
        false ->
            throw({error, invalid_nock_expression});
        true ->
            Subject = subject(NockExpr),
            Formula = formula(NockExpr),
            Opcode = opcode(Formula),
            interpret_opcode(Opcode, Subject, Formula)
    end.

%% Check if this is a valid Nock expression
is_nock({_Subject, {_OpCode, _Arg}}) ->
    true;
is_nock(_) ->
    false.

%% Extract subject from Nock expression: /[2 [subject formula]]
subject(NockExpr) ->
    noun:at(2, NockExpr).

%% Extract formula from Nock expression: /[3 [subject formula]]
formula(NockExpr) ->
    noun:at(3, NockExpr).

%% Extract opcode from formula: /[2 formula]
opcode(Formula) ->
    noun:at(2, Formula).

%% Extract slot/argument from formula: /[3 formula]
slot(Formula) ->
    noun:at(3, Formula).

%% Interpret based on opcode
%% Nock 0: Tree addressing
%% *[a 0 b] -> /[b a]
interpret_opcode(0, Subject, Formula) ->
    Slot = slot(Formula),
    case noun:is_atom(Slot) of
        false ->
            throw({error, slot_must_be_atom});
        true ->
            noun:at(Slot, Subject)
    end;

%% Nock 1: Constant
%% *[a 1 b] -> b
interpret_opcode(1, _Subject, Formula) ->
    slot(Formula);

%% Nock 4: Increment
%% *[a 4 b] -> +*[a b]
interpret_opcode(4, Subject, Formula) ->
    %% Get the argument at position 3 of the formula
    Arg = noun:at(3, Formula),
    %% Create a new Nock expression [Subject Arg] and interpret it
    Base = noun:from_list([noun:to_list(Subject), noun:to_list(Arg)]),
    Result = interpret(Base),
    %% Increment the result if it's an atom
    case noun:is_atom(Result) of
        true ->
            noun:increment(Result);
        false ->
            throw({error, cannot_increment_cell})
    end;

interpret_opcode(Opcode, _Subject, _Formula) ->
    throw({error, {unknown_opcode, Opcode}}).
