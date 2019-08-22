test:
	-chmod +x ./tests
	./tests

install:
	-@sudo cp wilt /usr/local/bin/wilt

uninstall:
	-@sudo rm /usr/local/bin/wilt
