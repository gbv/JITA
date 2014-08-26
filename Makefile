jita-de.html: jita-de.txt jita-de-intro.md
	cp jita-de-intro.md jita-de.md
	./jita-de-to-markdown.pl < $< >> jita-de.md
	pandoc -t html5 -s -S -o $@ jita-de.md
