-module(noun).
-export([from_list/1, to_list/1, to_tuples/1, is_atom/1, is_cell/1,
         at/2, increment/1, equal/2]).

%% Noun representation:
%% - Atoms are represented as integers
%% - Cells are represented as {Head, Tail} tuples

%% Convert a list to a Noun (Atom or Cell)
from_list(N) when is_integer(N) ->
    N;
from_list([]) ->
    throw({error, empty_list});
from_list([X]) when is_integer(X) ->
    X;
from_list([X]) when is_list(X) ->
    from_list(X);
from_list([H, T]) ->
    {from_list(H), from_list(T)};
from_list([H | Rest]) ->
    {from_list(H), from_list(Rest)}.

%% Convert a Noun to a list representation
to_list(N) when is_integer(N) ->
    [N];
to_list({H, T}) ->
    HList = case is_integer(H) of
        true -> H;
        false -> to_list(H)
    end,
    TList = case is_integer(T) of
        true -> T;
        false -> to_list(T)
    end,
    [HList, TList].

%% Convert n-ary list to binary tuples (Nock's native structure)
%% [a b c] -> [a [b c]]
to_tuples(L) when not is_list(L) ->
    L;
to_tuples([X]) ->
    to_tuples(X);
to_tuples([H, T]) ->
    [to_tuples(H), to_tuples(T)];
to_tuples([H | Rest]) ->
    [to_tuples(H), to_tuples(Rest)].

%% Type predicates
is_atom(N) when is_integer(N) ->
    true;
is_atom(_) ->
    false.

is_cell({_, _}) ->
    true;
is_cell(_) ->
    false.

%% Tree addressing: at(Index, Noun)
%% /[1 a] -> a
%% /[2 [a b]] -> a
%% /[3 [a b]] -> b
%% /[(a + a) b] -> /[2 /[a b]]
%% /[(a + a + 1) b] -> /[3 /[a b]]
at(1, Noun) ->
    Noun;
at(2, {H, _T}) ->
    H;
at(3, {_H, T}) ->
    T;
at(Index, Noun) when Index > 3, is_tuple(Noun) ->
    %% Convert index to binary, remove leading 1, traverse tree
    Bin = integer_to_binary(Index, 2),
    <<_:1, Rest/bitstring>> = Bin,
    traverse_binary(Rest, Noun);
at(Index, _Noun) when is_integer(Index), Index < 1 ->
    throw({error, invalid_index});
at(_Index, Atom) when is_integer(Atom) ->
    throw({error, atom_has_no_index}).

%% Helper: traverse tree using binary representation
traverse_binary(<<>>, Noun) ->
    Noun;
traverse_binary(<<0:1, Rest/bitstring>>, {H, _T}) ->
    traverse_binary(Rest, H);
traverse_binary(<<1:1, Rest/bitstring>>, {_H, T}) ->
    traverse_binary(Rest, T);
traverse_binary(_, Atom) when is_integer(Atom) ->
    throw({error, invalid_index}).

%% Increment an atom
increment(N) when is_integer(N) ->
    N + 1;
increment({_H, _T}) ->
    throw({error, cannot_increment_cell}).

%% Equality check
equal(A, A) ->
    true;
equal(_, _) ->
    false.
