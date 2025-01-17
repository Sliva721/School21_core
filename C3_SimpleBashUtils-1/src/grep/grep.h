#ifndef GREP_H
#define GREP_H

#include <regex.h>
#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define END_FLAG -1

#define MAX_PATTERNS 128
#define BUFFER_SIZE 1024

typedef struct {
  char data[MAX_PATTERNS][BUFFER_SIZE];
  regex_t reg_data[MAX_PATTERNS];
  size_t cur_size;
} Patterns;

typedef struct {
  bool e;
  bool f;
  bool i;
  bool s;
  bool v;
  bool n;
  bool h;
  bool o;
  bool l;
  bool c;
  Patterns patterns;
  size_t file_count;
} Flags;

void init_options(Flags *flags, int argc, char *argv[]);
void options_set(Flags *flags, char адфп);
void flags_free(Flags *flags);
void patterns_init(Patterns *patterns);
void patterns_add_from_string(Patterns *patterns, const char *str);
void patterns_add(Patterns *patterns, const char *patt);
void patterns_add_from_file(Patterns *patterns, char *filename);
void buffer_file(FILE *file, char *buffer, size_t buffer_size);
void patterns_free(Patterns *patterns);
FILE *safe_fopen(const char *filename, const char *modes);
void process_files(int file_count, char *const file_path[], const Flags *flags);
void route_file_greping(FILE *file, const char *filename, const Flags *flags);
void grep_files_with_matches(FILE *file, const char *filename,
                             const Flags *flags);
bool is_match(const char *line, const Flags *flags, regmatch_t *match);
void grep_match_count(FILE *file, const char *filename, const Flags *flags);
void grep_lines_with_matches(FILE *file, const char *filename,
                             const Flags *flags);
void patterns_compile_to_regex(Flags *flags);
void print_invalid_option();
void grep_only_matching(FILE *file, const char *filename, const Flags *flags);
void print_invalid_file(const char *file_name);

#endif // GREP_H
