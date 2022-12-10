#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int starts_with_4(char *str, char *with) {
  char sub[5];
  memcpy(sub, &str[0], 4);
  sub[4] = '\0';

  // https://www.ibm.com/docs/en/i/7.4?topic=functions-strcmp-compare-strings
  if (strcmp(sub, with) == 0) {
    return 1;
  } else {
    return 0;
  }
}

int get_add_value(char *str) {
  // https://www.ibm.com/docs/en/i/7.4?topic=functions-strstr-locate-substring
  char *result = strstr(str, " ");

  // https://www.ibm.com/docs/en/i/7.4?topic=functions-atoi-convert-character-string-integer
  int value = atoi(result);

  return value;
}

int signal_strength(int cycle, int register_value) {
  if (cycle == 20 || (cycle - 20) % 40 == 0) {
    return cycle * register_value;
  } else {
    return 0;
  }
}

int is_sprite_visible(int draw_position, int register_value) {
  if (abs(draw_position - register_value) <= 1) {
    return 1;
  } else {
    return 0;
  }
}

int main()
{
  int cycle = 0;
  int register_x = 1;
  int total_signal_strength = 0;
  int draw_position = 0;

  while (1) {
    char *line = NULL;
    size_t size;

    if (getline(&line, &size, stdin) == -1) {
      break;
    }

    int noop = starts_with_4(line, "noop");
    int add = starts_with_4(line, "addx");

    if (noop || add) {
      int sub_cycle = noop ? 1 : 2;
      int add_value = noop ? 0 : get_add_value(line);

      while (sub_cycle-- > 0) {
        cycle++;
        total_signal_strength += signal_strength(cycle, register_x);

        if (is_sprite_visible(draw_position, register_x)) {
          printf("#");
        } else {
          printf(".");
        }

        draw_position++;
        if (draw_position == 40) {
          draw_position = 0;
          printf("\n");
        }
      }

      register_x = register_x + add_value;
    }
  }

  printf("\nTotal Signal Strength: %d\n", total_signal_strength);

  return 0;
}
