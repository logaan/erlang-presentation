default:
	slidedown talk.markdown > talk.html
mnesia:
	slidedown mnesia_talk.markdown > mnesia_talk.html
clean:
	rm *.beam
	rm *.html
install:
	bundle install
	easy_install pygments
hot_loading:
	erlc reloader.erl hot_loading_loop.erl
	rerun --pattern "*.erl" -x erlc hot_loading_loop.erl &
	erl -noshell -s reloader -s hot_loading_loop
