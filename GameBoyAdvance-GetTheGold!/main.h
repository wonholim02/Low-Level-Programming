#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

struct snake {
  int heading;
  int length;
  int row;
  int col;
};

struct state {
   int currentState;
   int nextState;
};

struct position {
	u32 size;
	u32 sizeX;
	u32 sizeY;
};

#endif
