// main.c
#include <stdio.h>

unsigned int pid();

int main(int argc, char *argv[]) {
  int mpid = pid();
  printf("Process Id : % d\n", mpid);
  return 0;
}

