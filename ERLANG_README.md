# Nockr - Erlang Implementation

An Erlang implementation of the Nock interpreter, converted from the Ruby version.

## Overview

Nock is a minimalist, deterministic, combinatorial language based on functions and expressions. This Erlang implementation provides the same functionality as the Ruby version using Erlang's pattern matching and functional programming features.

## Data Structures

In Erlang, Nouns are represented as:
- **Atoms**: Plain integers (e.g., `42`)
- **Cells**: 2-tuples `{Head, Tail}` (e.g., `{50, 51}`)

## Modules

### noun.erl
Core Noun utilities:
- `from_list/1` - Convert Erlang list to Noun representation
- `to_list/1` - Convert Noun back to list representation
- `at/2` - Tree addressing (implements the `/` operator)
- `is_atom/1`, `is_cell/1` - Type predicates
- `increment/1` - Increment an atom
- `equal/2` - Equality check

### nock.erl
The Nock interpreter:
- `parse/1` - Parse string notation into Noun (e.g., "[[50 51] [0 1]]")
- `interpret/1` - Execute Nock formula
- `nock/1` - Convenience function to parse and interpret

## Implemented Nock Opcodes

### Nock 0: Tree Addressing
```
*[a 0 b] -> /[b a]
```
Access element at position `b` in subject `a`.

Example:
```erlang
nock:nock("[[50 51] [0 2]]").  % Returns 50
```

### Nock 1: Constant
```
*[a 1 b] -> b
```
Return constant `b` regardless of subject.

Example:
```erlang
nock:nock("[[20 30] [1 67]]").  % Returns 67
```

### Nock 4: Increment
```
*[a 4 b] -> +*[a b]
```
Increment the result of interpreting `[a b]`.

Example:
```erlang
nock:nock("[50 [4 [0 1]]]").  % Returns 51
```

## Building and Testing

### Compile
```bash
mkdir -p ebin
erlc -o ebin src/*.erl
```

### Run Tests
This will:
- Compile all src/*.erl files
- Compile all test/*.erl files
- Run all discovered EUnit tests
- Show results

```bash
rebar3 eunit
```

To verify what tests it finds:
```bash
rebar3 eunit --verbose
```

To run specific test modules:
```bash
rebar3 eunit --module=test_nock_0
rebar3 eunit --module=test_nock_0,test_nock_1
```

### Interactive Usage
```bash
erl -pa ebin
```

Then in the Erlang shell:
```erlang
1> nock:nock("[[50 51] [0 1]]").
Interpreting [[50 51] [0 1]] as Nock...
=> {50,51}
{50,51}

2> nock:nock("[[20 30] [1 67]]").
Interpreting [[20 30] [1 67]] as Nock...
=> 67
67

3> nock:nock("[50 [4 [0 1]]]").
Interpreting [50 [4 [0 1]]] as Nock...
=> 51
51
```

## Key Differences from Ruby Implementation

1. **Data Representation**: Erlang uses tuples `{H, T}` instead of Ruby class instances
2. **Pattern Matching**: Leverages Erlang's native pattern matching instead of OOP polymorphism
3. **Immutability**: All data structures are immutable by default
4. **Error Handling**: Uses `throw` for errors instead of Ruby exceptions
5. **Type Checking**: Runtime type checking using guards and predicates

## Architecture

The Erlang implementation follows a functional approach:
- Pure functions for all operations
- Pattern matching for type discrimination
- Recursive tree traversal for addressing
- Tagged tuples for data representation

This makes the code naturally suited to Erlang's strengths while maintaining semantic compatibility with the Ruby version.

## Tree Addressing

The `at/2` function implements Nock's tree addressing:
- `/[1 a]` returns `a` (identity)
- `/[2 [a b]]` returns `a` (head)
- `/[3 [a b]]` returns `b` (tail)
- For indices > 3, binary representation is used to navigate the tree

Example: `/[6 [[a b] [c d]]]` -> `c`
- 6 in binary is `110`
- Remove leading 1: `10`
- `1` = go right (tail), `0` = go left (head)
- Result: `c`

## Future Work

Additional Nock opcodes can be added to `interpret_opcode/3` in `nock.erl`:
- Nock 2: Distribution
- Nock 3: Cell test
- Nock 5: Equality test
- Nock 6-10: Additional operators

## Testing

All tests from the Ruby RSpec suite have been converted to EUnit tests in `test/nock_tests.erl`. Run the test suite to verify the implementation.
