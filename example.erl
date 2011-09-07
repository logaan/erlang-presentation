-module(example).
-export([longness/1]).
-include_lib("eunit/include/eunit.hrl").

% Erlang already has length/1
longness([]) ->
  0;
longness([_H|T]) ->
  1 + longness(T).

longness_test() ->
  4 = longness([1,2,3,4]).

