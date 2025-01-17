compile = gcc -Wall -Werror -Wextra -std=c11 



.PHONY: all clean s21_grep

all: s21_grep

s21_grep: grep.c
	$(compile) grep.c -o s21_grep

clean:
	rm -f s21_grep