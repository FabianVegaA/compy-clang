#ifndef GEN_H
#define GEN_H

struct gen {
  int (*next)();
  int continue_from;
};

typedef int (*fptr)();

#endif