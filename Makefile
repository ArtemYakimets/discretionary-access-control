all: build

build: clean
	if [ ! -d ./build ]; then mkdir build; fi
	gcc -Wall -Werror -Wextra ./src/main.c -o ./build/my_chmod

.SILENT:
.PHONY: test
test: build
	bash ./tests/test.sh
	echo ok

.SILENT:
.PHONY: test_github
test_github: build
	bash ./tests/test.sh github
	echo ok

clean:
	if [ -d ./build ]; then rm -r build; fi
