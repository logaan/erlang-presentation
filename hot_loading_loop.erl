-module(hot_loading_loop).
-compile(export_all).

start() ->
  spawn(fun loop/0).

loop() ->
  io:format("Hello World~n"),
  timer:sleep(2000),
  hot_loading_loop:loop().

