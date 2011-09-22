-module(books).
-compile(export_all).
-include_lib("stdlib/include/qlc.hrl").
-include_lib("eunit/include/eunit.hrl").
-record(book, {isbn, author, title}).

init() ->
  mnesia:create_schema([node()]),
  mnesia:start(),
  mnesia:create_table(book, [
    {attributes, record_info(fields, book)},
    {disc_copies, [node()] }
  ]).

insert(Book) ->
  mnesia:transaction(fun() ->
    mnesia:write(Book)
  end).

select_all() -> 
  {atomic, Results} = mnesia:transaction( 
  fun() ->
    qlc:eval( qlc:q(
      [ X || X <- mnesia:table(book) ] 
    )) 
  end ),
  Results.

in_and_out_test() ->
  Book = #book{ isbn=65786970, author="Joe", title="Girlang" },
  init(),
  insert(Book),
  [Book] = select_all().
