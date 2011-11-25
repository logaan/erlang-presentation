!SLIDE

# Mnesia is beyond NoSQL, It's NoQL

!SLIDE
## Boring header stuff
@@@ erlang
    -module(books).
    -compile(export_all).

    -include_lib("stdlib/include/qlc.hrl").
    -include_lib("eunit/include/eunit.hrl").
@@@

!SLIDE
## Records like a RDBMS
@@@ erlang
    -record(book, {isbn, author, title}).
@@@

!SLIDE
## Less config than Oracle
@@@ erlang
    init() ->
      mnesia:create_schema([node()]),
      mnesia:start(),
      mnesia:create_table(book, [
        {attributes,
          record_info(fields, book)},
        {ram_copies, [node()]}]).
@@@

!SLIDE
## Transactions are just lambdas
@@@ erlang
    insert(Book) ->
      mnesia:transaction(fun() ->
        mnesia:write(Book)
      end).
@@@

!SLIDE
## Describe your data with normal code
@@@ erlang
    high_isbn(#book{ isbn=Isbn }) ->
      (Isbn > 60000000) and
      (length(integer_to_list(Isbn)) == 8).
@@@

!SLIDE
## List comprehension to query
@@@ erlang
      [ X#book.author ||
        X <- mnesia:table(book),
        Title == X#book.title,
        high_isbn(X)])) 
@@@

!SLIDE
## That last slide was a lie
@@@ erlang
    select_author_by_title(Title) -> 
      {atomic, Results} = mnesia:transaction(
        fun() ->
          qlc:eval(qlc:q(
            ...
          ))
        end),
      Results.
@@@

!SLIDE
## Which gives us
@@@ erlang
    in_and_out_test() ->
      init(),
      insert(#book{
        isbn=65786970,
        author="Joe",
        title="Girlang" }),
      ["Joe"] =
      select_author_by_title("Girlang").
@@@ erlang

!SLIDE
## Drawbacks
* Erlang only interface
* 4gb per table per node
* Manually resolve network split

!SLIDE
## In summary
* Store anything
* Query with erlang
* Distributed
* Super fast
* Mature

!SLIDE

## Thank you

### This talk
* github.com/logaan/erlang-presentation

### References
* erldocs.com
* http://www.erlang.org/doc/apps/mnesia/
* http://noss.github.com/2009/04/04/mnesia-sucks-not.html
* http://vimeo.com/17162381


