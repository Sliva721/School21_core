compile = gcc -Wall -Werror -Wextra -std=c11 


.PHONY: all clean s21_cat

all: s21_cat

s21_cat: cat.c
	$(compile) cat.c -o s21_cat

clean:
	rm -f s21_cat