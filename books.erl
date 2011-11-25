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
    {ram_copies, [node()] }
  ]).

insert(Book) ->
  mnesia:transaction(fun() ->
    mnesia:write(Book)
  end).

high_isbn(#book{ isbn=Isbn}) ->
  (Isbn > 60000000) and
  (length(integer_to_list(Isbn)) == 8).

select_author_by_title(Title) -> 
  {atomic, Results} = mnesia:transaction(fun() ->
    qlc:eval(qlc:q(
      [
        X#book.author ||
        X <- mnesia:table(book),
        Title == X#book.title,
        high_isbn(X)] 
    )) 
  end),
  Results.

in_and_out_test() ->
  init(),
  insert(#book{ isbn=65786970, author="Joe", title="Girlang" }),
  ["Joe"] = select_author_by_title("Girlang").
