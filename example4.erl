-module(example4).
-export([loop/0]).
-include_lib("eunit/include/eunit.hrl").

start() ->
  Pid = spawn(example4, loop, []),
  register(printer, Pid).
print(Term) ->
  printer ! {print, Term}.
quit() ->
  printer ! quit.

loop() ->
  receive
    {print, Term} ->
      erlang:display(Term),
      loop();
    quit ->
      ok
  end.

api_test() ->
  start(),
  print("foo"),
  print([1, "two", 3]),
  quit().

