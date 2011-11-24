!SLIDE

# Mnesia is beyond NoSQL, It's NoQL

!SLIDE
* Erlang ships with a mature NoQL database called Mnesia.
  * erlang has been around for 10 years

!SLIDE
# It allows you to store any erlang term with no need to serialse, even lambdas.

!SLIDE
# You query the database with erlang its self.

!SLIDE
# It's distributed with eventual consistency.

!SLIDE
# And it's fast - soft realtime fast.

!SLIDE
# I'll also be covering some of the idioms of erlang and a brief introduction to the language to put the database in its context.

!SLIDE

# Thank you

### This talk
* github.com/logaan/erlang-presentation

### References
* erldocs.com
* http://www.erlang.org/doc/apps/mnesia/
* http://noss.github.com/2009/04/04/mnesia-sucks-not.html
* http://vimeo.com/17162381

!SLIDE

# Random facts
* Used by couchdb
* Used commercially for over 10 years
* Can scale out to 50 nodes
* Build in support for sharding
* Incremental backup
* Distribution to several nodes gives
  * Fault tollerance
  * Efficiency
    * DB is on the same machine
    * And in the same address space
    * As your application
* A transaction is just a fun
* Table types
  * ram_copies
    * specify which nodes will hold ram copies
    * backed up at regular intervals
    * not journaled
  * disc_copies
    * journals
    * can re-create ram copy from initial dump + log
  * disc_only_copies
    * full disc copy
    * slower, obviously
    * doesn't have to be re-built from log

# Drawbacks
* Erlang only interface
* Each table per node can only store 4gb of data
  * Because mnesia internally uses 32bit ints for addresses
  * Switching to a 64bit system will not solve this

