#include "grep.h"

int main(int argc, char* argv[]) {
  Flags flags = {0};
  init_options(&flags, argc, argv);
  process_files(argc - optind, argv + optind, &flags);
  flags_free(&flags);
  return 0;
}

void init_options(Flags* flags, int argc, char* argv[]) {
  patterns_init(&flags->patterns);
  char current_option;

  while ((current_option = getopt(argc, argv, "e:f:isvnholc")) != END_FLAG) {
    options_set(flags, current_option);
  }

  if (optind < argc && strcmp(argv[optind], "--") == 0) {
    optind++;
  }

  if (!flags->e && !flags->f) {
    if (optind < argc && argv[optind][0] != '-') {
      patterns_add_from_string(&flags->patterns, argv[optind++]);
    } else {
      print_invalid_option();
    }
  }

  patterns_compile_to_regex(flags);
  flags->file_count = argc - optind;
}

void options_set(Flags* flags, char opt) {
  switch (opt) {
    case 'e':
      flags->e = true;
      if (optarg != NULL) {
        patterns_add_from_string(&flags->patterns, optarg);
      } else {
        print_invalid_option();
      }
      break;
    case 'f':
      flags->f = true;
      if (optarg != NULL) {
        patterns_add_from_file(&flags->patterns, optarg);
      } else {
        print_invalid_option();
      }
      break;
    case 'i':
      flags->i = true;
      break;
    case 's':
      flags->s = true;
      break;
    case 'v':
      flags->v = true;
      break;
    case 'n':
      flags->n = true;
      break;
    case 'h':
      flags->h = true;
      break;
    case 'o':
      flags->o = true;
      break;
    case 'l':
      flags->l = true;
      break;
    case 'c':
      flags->c = true;
      break;
    default:
      print_invalid_option();
  }
}

void patterns_init(Patterns* patterns) { patterns->cur_size = 0; }

void patterns_add_from_string(Patterns* patterns, const char* str) {
  if (str != NULL) {
    char tmp_str[BUFFER_SIZE];
    strncpy(tmp_str, str, BUFFER_SIZE);
    char* token = strtok(tmp_str, "\n");
    while (token != NULL && patterns->cur_size < MAX_PATTERNS) {
      patterns_add(patterns, token);
      token = strtok(NULL, "\n");
    }
  }
}

void patterns_add(Patterns* patterns, const char* patt) {
  if (patterns->cur_size < MAX_PATTERNS) {
    strncpy(patterns->data[patterns->cur_size], patt, BUFFER_SIZE);
    patterns->cur_size++;
  }
}

void patterns_add_from_file(Patterns* patterns, char* filename) {
  FILE* file = safe_fopen(filename, "r");
  char buffer[BUFFER_SIZE];
  buffer_file(file, buffer, BUFFER_SIZE);
  patterns_add_from_string(patterns, buffer);
  fclose(file);
}

FILE* safe_fopen(const char* filename, const char* modes) {
  FILE* file = fopen(filename, modes);
  if (!file) {
    fprintf(stderr, "Ошибка открытия файла: %s\n", filename);
    exit(EXIT_FAILURE);
  }
  return file;
}

void buffer_file(FILE* file, char* buffer, size_t buffer_size) {
  size_t size = 0;
  int ch = fgetc(file);
  while (ch != EOF && size < buffer_size - 1) {
    buffer[size++] = ch;
    ch = fgetc(file);
  }
  buffer[size] = '\0';
}

void process_files(int file_count, char* const file_path[],
                   const Flags* flags) {
  while (file_count > 0) {
    FILE* file = fopen(*file_path, "r");
    if (file != NULL) {
      route_file_greping(file, *file_path, flags);
      fflush(stdout);
      fclose(file);
    } else if (!flags->s) {
      print_invalid_file(*file_path);
    }
    ++file_path;
    --file_count;
  }
}

void print_invalid_file(const char* file_name) {
  fprintf(stderr, "Ошибка открытия файла: %s\n", file_name);
}

void route_file_greping(FILE* file, const char* filename, const Flags* flags) {
  if (flags->l) {
    grep_files_with_matches(file, filename, flags);
  } else if (flags->c) {
    grep_match_count(file, filename, flags);
  } else if (flags->o) {
    grep_only_matching(file, filename, flags);
  } else {
    grep_lines_with_matches(file, filename, flags);
  }
}

void grep_files_with_matches(FILE* file, const char* filename,
                             const Flags* flags) {
  char buffer[BUFFER_SIZE];
  while (fgets(buffer, BUFFER_SIZE, file) != NULL) {
    if (is_match(buffer, flags, NULL)) {
      fprintf(stdout, "%s\n", filename);
      break;
    }
  }
}

bool is_match(const char* line, const Flags* flags, regmatch_t* match) {
  const Patterns* patterns = &flags->patterns;
  bool result = false;
  size_t nmatch = match ? 1 : 0;
  for (size_t i = 0; i < patterns->cur_size; ++i) {
    if (regexec(&patterns->reg_data[i], line, nmatch, match, 0) == 0) {
      result = true;
    }
  }
  if (flags->v) {
    result = !result;
    if (flags->o) {
      result = false;
    }
  }
  return result;
}

void grep_match_count(FILE* file, const char* filename, const Flags* flags) {
  size_t match_count = 0;
  char buffer[BUFFER_SIZE];
  while (fgets(buffer, BUFFER_SIZE, file) != NULL) {
    if (is_match(buffer, flags, NULL)) {
      ++match_count;
    }
  }

  if (flags->file_count > 1 && !flags->h) {
    fprintf(stdout, "%s:", filename);
  }

  fprintf(stdout, "%zu\n", match_count);
}

void grep_lines_with_matches(FILE* file, const char* filename,
                             const Flags* flags) {
  char line[BUFFER_SIZE];
  size_t line_count = 0;

  while (fgets(line, BUFFER_SIZE, file) != NULL) {
    ++line_count;
    if (is_match(line, flags, NULL)) {
      if (flags->file_count > 1 && !flags->h) {
        fprintf(stdout, "%s:", filename);
      }
      if (flags->n) {
        fprintf(stdout, "%zu:", line_count);
      }
      fprintf(stdout, "%s", line);

      if (line[strlen(line) - 1] != '\n') {
        printf("\n");
      }
    }
  }
}

void patterns_compile_to_regex(Flags* flags) {
  Patterns* patterns = &flags->patterns;
  int reg_icase = flags->i ? REG_ICASE : 0;
  for (size_t i = 0; i < patterns->cur_size; ++i) {
    regcomp(&patterns->reg_data[i], patterns->data[i], reg_icase);
  }
}

void print_invalid_option() {
  fprintf(stderr, "invalid options\n");
  exit(EXIT_FAILURE);
}

void grep_only_matching(FILE* file, const char* filename, const Flags* flags) {
  char line[BUFFER_SIZE];
  size_t line_count = 0;
  regmatch_t match;

  while (fgets(line, BUFFER_SIZE, file) != NULL) {
    char* line_ptr = line;
    ++line_count;

    while (is_match(line_ptr, flags, &match)) {
      if (flags->file_count > 1 && !flags->h) {
        fprintf(stdout, "%s:", filename);
      }
      if (flags->n) {
        fprintf(stdout, "%zu:", line_count);
      }
      fprintf(stdout, "%.*s\n", (int)(match.rm_eo - match.rm_so),
              line_ptr + match.rm_so);
      line_ptr += match.rm_eo + 1;
    }
  }
}

void flags_free(Flags* flags) { patterns_free(&flags->patterns); }

void patterns_free(Patterns* patterns) {
  for (size_t i = 0; i < patterns->cur_size; ++i) {
    regfree(&patterns->reg_data[i]);
  }
}
