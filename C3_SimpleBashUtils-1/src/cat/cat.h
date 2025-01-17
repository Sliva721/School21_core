#ifndef CAT_H
#define CAT_H

#define END_FLAG -1
#define READ_MODE "r"

#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct Flags {
  bool b;
  bool e;
  bool n;
  bool s;
  bool t;
  bool E;
  bool v;
} Flags;

const struct option LONG_FLAG[] = {{"number-nonblank", 0, NULL, 'b'},
                                   {"show-ends", 0, NULL, 'E'},
                                   {"number", 0, NULL, 'n'},
                                   {"squeeze-blank", 0, NULL, 's'},
                                   {"show-tabs", 0, NULL, 'T'},
                                   {"show-nonprinting", 0, NULL, 'v'},
                                   {NULL, 0, NULL, 0}};

const char FLAG[] = "beEnstTv";

void set_flags(const char flag, Flags* const flags);
void print_invalid_flag();
void init_flags(int argc, char* const argv[], Flags* flags);
void process_file(int file_count, char* const file_path[],
                  const Flags* const flags);
void print_invalid_file(const char* const file_name);
void input_console(FILE* file, const Flags* const flags);

#endif
