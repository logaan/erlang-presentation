-module(example3).
-export([loop/0]).
-include_lib("eunit/include/eunit.hrl").

start() ->
  spawn(example3, loop, []).

print(Pid, Term) ->
  Pid ! {print, Term},
  ok.

quit(Pid) ->
  Pid ! quit,
  ok.

loop() ->
  receive
    {print, Term} ->
      erlang:display(Term),
      loop();
    quit ->
      ok
  end.

api_test() ->
  Pid = start(),
  print(Pid, "foo"),
  print(Pid, [1, "two", 3]),
  quit(Pid).

