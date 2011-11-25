!SLIDE

# Erlang
### Is a pretty cool guy.

!SLIDE

# On the agenda

* Brief overview of Erlang
* Datatypes
* What a program looks like

!SLIDE

# Brief overview
* Compiled, functional, dynamic
* Variables that don't
* Lightweight processes, message sending
* Pattern matching, tail call optimisation
* Hot code loading

!SLIDE

# Datatypes

!SLIDE

# Numbers

@@@ erlang
    42
    1.8
    2.3e-3
@@@

!SLIDE

# Atoms

@@@ erlang
    hello
    hot_dog
    'Foo'
    'so desu ne'
@@@

!SLIDE

# Binaries

@@@ erlang
    <<10,20>>
    <<"ABC">>
    <<1,17,42:16>>
    <<1024/utf8>>
@@@

!SLIDE

# Funs

@@@ erlang
    fun (X) -> X+1 end
@@@

!SLIDE

# Tuples

@@@ erlang
    { foo, 42, { lol, cats } }
@@@

!SLIDE

# Lists

@@@ erlang
    [ foo, 42, [ lol, cats ] ]
    [ 1 | [ 2, 3 ] ]
@@@

!SLIDE

# Process ID (Pid)

@@@ erlang
    spawn(fun () -> timer:sleep(5000) end). 
    <0.35.0>
@@@

!SLIDE

# Strings (Kinda)

@@@ erlang
    "foo"
    [$f, $o, $o]
    [102, 111, 111]
@@@

!SLIDE

# Booleans (Kinda)

@@@ erlang
    true
    false
@@@

!SLIDE

# Records (Kinda)

@@@ erlang
    #person{ name="John", age=23 }
    { person, "John", 23 }
@@@

!SLIDE

# What a program looks like

!SLIDE code

# Hello world

@@@ erlang
    -module(example).                        1
    -export([longness/1]).                   2
    -include_lib("eunit/include/eunit.hrl"). 3
                                             4
    % Erlang already has length/1            5
    longness([]) ->                          6
      0;                                     7
    longness([_H|T]) ->                      8
      1 + longness(T).                       9
                                             10
    longness_test() ->                       11
      4 = longness([1,2,3,4]).               12
@@@

!SLIDE

# REPL

    logaan@logmac:slidedown-erlang$ erl
    Eshell V5.7.5  (abort with ^G)

    1> c(example).
    {ok,example}

    2> example:test().
      Test passed.
    ok

    3> example:longness([1,2]).
    2

!SLIDE

# Message sending

@@@ erlang
    loop() ->                                1 
      receive                                2 
        {print, Term} ->                     3 
          erlang:display(Term),              4 
          loop();                            5 
        quit ->                              6 
          ok                                 7 
      end.                                   8 
                                             9
    loop_test() ->                           10
      Pid = spawn(example2, loop, []),       11
      Pid ! {print, "foo"},                  12
      Pid ! {print, [1,"two",3]},            13
      Pid ! quit.                            14
@@@

!SLIDE

# APIs

@@@ erlang
    start() ->                               1
      spawn(example3, loop, []).             2
    print(Pid, Term) ->                      3
      Pid ! {print, Term}.                   4
    quit(Pid) ->                             5
      Pid ! quit.                            6
                                             7
    api_test() ->                            8
      Pid = start(),                         9
      print(Pid, "foo"),                     10
      print(Pid, [1, "two", 3]),             11
      quit(Pid).                             12
@@@                                                 

!SLIDE

# Global services

@@@ erlang
    start() ->                               1
      Pid = spawn(example4, loop, []),       2
      register(printer, Pid).                3
    print(Term) ->                           4
      printer ! {print, Term}.               5
    quit() ->                                6
      printer ! quit.                        7
                                             8
    api_test() ->                            9
      start(),                               10
      print("foo"),                          11
      print([1, "two", 3]),                  12
      quit().                                13
@@@

!SLIDE

# What we've covered

* Brief overview of Erlang
* Datatypes
* What a program looks like

!SLIDE

# Thank you

### This talk
* github.com/logaan/erlang-presentation

### References
* erldocs.com
* wikibooks.org/wiki/Erlang_Programming
* erlang.org/doc/reference\_manual/users\_guide.html

