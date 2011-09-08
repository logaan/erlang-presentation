default:
	slidedown talk.md > talk.html
open:
	open talk.html
clean:
	rm *.beam
	rm *.html
install:
	bundle install
	easy_install pygments
