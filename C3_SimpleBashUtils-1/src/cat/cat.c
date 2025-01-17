#include "cat.h"

int main(int argc, char* argv[]) {
  Flags flags = {0};
  init_flags(argc, argv, &flags);
  process_file(argc - optind, argv + optind, &flags);

  return EXIT_SUCCESS;
}

void set_flags(const char flag, Flags* const flags) {
  switch (flag) {
    case 'b':
      flags->b = true;
      break;
    case 'e':
      flags->e = flags->v = true;
      break;
    case 'E':
      flags->e = true;
      break;
    case 'n':
      flags->n = true;
      break;
    case 's':
      flags->s = true;
      break;
    case 'v':
      flags->v = true;
      break;
    case 't':
      flags->t = flags->v = true;
      break;
    case 'T':
      flags->t = true;
      break;
    case -1:
      break;
    default:
      print_invalid_flag();
  }
}

void print_invalid_flag() {
  fprintf(stderr, "invalid flag\n");
  exit(EXIT_FAILURE);
}

void init_flags(int argc, char* const argv[], Flags* flags) {
  int long_index = 0;
  char current_option = getopt_long(argc, argv, FLAG, LONG_FLAG, &long_index);

  while (current_option != END_FLAG) {
    set_flags(current_option, flags);
    current_option = getopt_long(argc, argv, FLAG, LONG_FLAG, &long_index);
  }
}

void process_file(int file_count, char* const file_path[],
                  const Flags* const flags) {
  FILE* current_file = NULL;

  while (file_count > 0) {
    current_file = fopen(*file_path, READ_MODE);
    if (!current_file) {
      print_invalid_file(*file_path);
    } else {
      input_console(current_file, flags);
      fflush(stdout);
    }
    file_path++;
    file_count--;
  }
}

void print_invalid_file(const char* const file_name) {
  fprintf(stderr, "%s: No such file or directory\n", file_name);
}

void input_console(FILE* file, const Flags* const flags) {
  char ch, prev;
  static int current_line = 1;

  int squeeze = 0;
  for (prev = '\n'; (ch = getc(file)) != EOF; prev = ch) {
    if (flags->s && ch == '\n' && prev == '\n') {
      if (squeeze == 1) {
        continue;
      }
      squeeze = 1;
    } else {
      squeeze = 0;
    }

    if (flags->b && prev == '\n' && ch != '\n') {
      printf("%*d\t", 6, current_line);
      current_line++;
    }

    if (flags->n && flags->b == false && prev == '\n') {
      printf("%*d\t", 6, current_line);
      current_line++;
    }

    if (flags->e && ch == '\n') {
      putchar('$');
    }

    if (flags->t && ch == '\t') {
      printf("^I");
      continue;
    }

    if (flags->v && ch >= 0 && ch <= 31 && ch != '\n' && ch != '\t') {
      printf("^%c", ch + 64);
      continue;
    }
    putchar(ch);
  }

  fclose(file);
}
