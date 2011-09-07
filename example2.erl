-module(example2).
-export([loop/0]).
-include_lib("eunit/include/eunit.hrl").

loop() ->
  receive
    {print, Term} ->
      erlang:display(Term),
      loop();
    quit ->
      ok
  end.

loop_test() ->
  Pid = spawn(example2, loop, []),
  Pid ! {print, "foo"},
  Pid ! {print, [1,"two",3]},
  Pid ! quit.

