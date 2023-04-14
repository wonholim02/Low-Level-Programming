#include "main.h"

#include <stdio.h>
#include <stdlib.h>
#include "images/startPage.h"
#include "images/victory.h"
#include "images/end2.h"
#include "images/fox.h"
#include "images/gold.h"
#include "images/rift.h"
#include "images/baron.h"
#include "images/ani1.h"
#include "images/ani2.h"
#include "images/ani3.h"
#include "images/ani4.h"
#include "gba.h"

enum gba_state {
  START,
  PLAY,
  WIN,
  LOSE,
  INSTRUCTION,
};


int extraCreditState = 1;
int firstSTART = 1;
int firstPLAY = 1;
int firstWIN = 1;
int firstLOSE = 1;
int firstINST = 1;
int gain = 1;
int more = 0;
const struct position player = {10, 10, 10};
u32 dieCondition = 0;
u32 playerSize = player.size;
u32 playerX = 25;
u32 playerY = 50;
u32 score = 0;
u32 bestScore = 0;
u32 try = 100;
u32 mazeEndX = 125;
u32 mazeEndY = 60;
char scoreStr[16];
char scoreStr2[16];

int checkCollision(u32 playerX, u32 playerY) {
    if ((playerX < 20 || playerY < 40 || playerX > 140 || playerY > 215
    || ((playerX < 90 && playerY > 140)) 
    || ((playerX > 30 && playerX < 50) && (playerY > 10 && playerY < 90))
    || ((playerX > 100 && playerX < 120) && (playerY > 10 && playerY < 180)) 
    || ((playerX > 100 && playerX < 135) && (playerY > 90 && playerY < 110))
    || ((playerX > 125 && playerX < 150) && (playerY > 140 && playerY < 160))
    || ((playerX > 70 && playerX < 90) && (playerY > 110 && playerY < 215))
    )) {
        return 1;
    }
    return 0;
}
int main(void) {
  REG_DISPCNT = MODE3 | BG2_ENABLE;
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;
  enum gba_state state = START;

  while (1) {
    waitForVBlank();
    currentButtons = BUTTONS;
    switch (state) {
      case START:
        if (extraCreditState == 1) {
          drawImageDMA(70, 85, 50, 50, ani1);
          extraCreditState++;
        } else if (extraCreditState == 25) {
          drawImageDMA(70, 85, 50, 50, ani2);
          extraCreditState++;
        } else if (extraCreditState == 50) {
          drawImageDMA(70, 85, 50, 50, ani3);
          extraCreditState++;
        } else if (extraCreditState == 75) {
          drawImageDMA(70, 85, 50, 50, ani4);
          extraCreditState++;
        } else if (extraCreditState == 100) {
          extraCreditState = -20;
        }
        extraCreditState++;
        if (firstSTART) {
          drawFullScreenImageDMA(startPage);
          drawString(40, 80, "GET THE GOLD!", COLOR(30, 30, 30));
          drawString(125, 60, "PRESS START TO PLAY", COLOR(30, 30, 30));
          drawString(15, 45, "PRESS -> TO SEE INSTURCTION", COLOR(30, 30, 30));
          drawString(140, 55, "PRESS SELECT TO RESET", COLOR(30, 30, 30));
          firstSTART = 0;
        }
        if (KEY_JUST_PRESSED(BUTTON_RIGHT, currentButtons, previousButtons)) {
            state = INSTRUCTION;
        }
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
            fillScreenDMA(BLACK);
            score = 0;
            vBlankCounter = 0;
            state = PLAY;
        }
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          score = 0;
          try = 100;
          state = START;
          playerX = 25;
          playerY = 50;
          firstPLAY = 1;
          firstWIN = 1;
          firstLOSE = 1;
          firstSTART = 1;
          dieCondition = 0;
          gain = 1;
        }
        break;
      case PLAY:
        if (firstPLAY) {
          drawFullScreenImageDMA(rift);
          drawImageDMA(30,161,60,30,baron); // Monster
          drawRectDMA(40, 30, 30, 10, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(0, 150, 5, 80, COLOR(0,5, 10)); // wall - completed
          drawRectDMA(0, 0, 240, 20, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(80, 205, 30, 10, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(80, 120, 30, 10, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(150, 20, 155, 10, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(110, 20, 80, 10, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(220, 0, 30, 240, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(135, 150, 5, 30, COLOR(0, 5, 10)); // wall - completed
          drawRectDMA(110, 100, 5, 25, COLOR(0, 5, 10)); // wall - completed
          drawImageDMA(125, 60, 20, 20, gold); // Ending point
          drawString(5, 100, "PRESS SELECT TO RESET", COLOR(30, 30, 30));
          firstPLAY = 0;
        }
        u32 sizeX = player.sizeX;
        u32 sizeY = player.sizeY;
        printf("X: %d", sizeX);
        printf("Y: %d", sizeY);
        
        drawImageDMA(playerX, playerY, sizeX, sizeY, fox);
        if (gain) {
          drawRectDMA(0, 0, 30, 20, COLOR(0, 5, 10));
          gain = 0;
          snprintf(scoreStr, 16, "LIFE: %d", try);
          drawString(5, 5, scoreStr, COLOR(30, 30, 30));
          drawString(5, 5, 0, COLOR(30, 30, 30));
        }

        if (KEY_JUST_PRESSED(BUTTON_RIGHT, currentButtons, previousButtons)) {
          playerY = playerY + 5;
          if (checkCollision(playerX, playerY)) {
            if (dieCondition != 3) {
              dieCondition = 2;
            }
            state = LOSE;
          } else {
            try = try - 1;
            if (try == 0) {
              dieCondition = 1;
              state = LOSE;
            }
            gain = 1;
          }
        } else if (KEY_JUST_PRESSED(BUTTON_LEFT, currentButtons, previousButtons)) {
          playerY = playerY - 5;
          if (checkCollision(playerX, playerY)) {
            if (dieCondition != 3) {
              dieCondition = 2;
            }
            state = LOSE;
          } else {
            try = try - 1;
            if (try == 0) {
              dieCondition = 1;
              state = LOSE;
            }
            gain = 1;
          }
        } else if (KEY_JUST_PRESSED(BUTTON_UP, currentButtons, previousButtons)) {
          playerX = playerX - 5;
          if (checkCollision(playerX, playerY)) {
            if (dieCondition != 3) {
              dieCondition = 2;
            }
            state = LOSE;
          } else {
            try = try - 1;
            if (try == 0) {
              dieCondition = 1;
              state = LOSE;
            }
            gain = 1;
          }
        } else if (KEY_JUST_PRESSED(BUTTON_DOWN, currentButtons, previousButtons)) {
          playerX = playerX + 5;
          if (checkCollision(playerX, playerY)) {
            if (dieCondition != 3) {
              dieCondition = 2;
            }
            state = LOSE;
          } else {
            try = try - 1;
            if (try == 0) {
              dieCondition = 1;
              state = LOSE;
            }
            gain = 1;
          }
        }
        if ((playerX == mazeEndX + 5)  && (playerY == mazeEndY + 5)) {
          state = WIN;
        }
        if (try <= 0) {
          state = LOSE;
        }

        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          score = 0;
          try = 100;
          state = START;
          playerX = 25;
          playerY = 50;
          firstPLAY = 1;
          firstWIN = 1;
          firstLOSE = 1;
          firstSTART = 1;
          dieCondition = 0;
          gain = 1;
        }
        break;
      case WIN:
        if (firstWIN) {
          score = (try + 50);
          drawFullScreenImageDMA(victory);
          snprintf(scoreStr, 16, "SCORE: %d", score);
          drawString(112, 95, scoreStr, COLOR(30, 30, 30));
          drawString(132, 60, "PRESS SELECT TO RESET", COLOR(30, 30, 30));
          if (bestScore < score) {
            drawString(15, 85, "BEST SO FAR!", COLOR(30, 30, 30));
            bestScore = score;
          }
          firstWIN = 0;
        }
        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          score = 0;
          try = 100;
          state = START;
          playerX = 25;
          playerY = 50;
          firstPLAY = 1;
          firstWIN = 1;
          firstLOSE = 1;
          firstSTART = 1;
          dieCondition = 0;
          gain = 1;
        }
        break;
      case LOSE:
        if (firstLOSE) {
          drawFullScreenImageDMA(end2);
          score = (try - 50);
          if (playerX > 90 && playerY > 140) {
              dieCondition = 3;
          }
          if (dieCondition == 1) {
            drawString(10, 75, "USED ALL TRIALS", COLOR(30, 30, 30));
          } else {
            drawString(10, 65, "PLAYER WAS KILLED!", COLOR(30, 30, 30));
          }
          snprintf(scoreStr, 16, "SCORE: %d", score);
          drawString(112, 95, scoreStr, COLOR(30, 30, 30));
          drawString(132, 60, "PRESS SELECT TO RESET", COLOR(30, 30, 30));
          firstLOSE = 0;
        }
        if (bestScore < score) {
          bestScore = score;
        }
        firstLOSE = 0;
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          score = 0;
          try = 100;
          state = START;
          playerX = 25;
          playerY = 50;
          firstPLAY = 1;
          firstWIN = 1;
          firstLOSE = 1;
          firstSTART = 1;
          dieCondition = 0;
          gain = 1;
        }
        break;
      case INSTRUCTION: //for extra credit #2
        if (firstINST) {
          if (more) {
            drawFullScreenImageDMA(startPage);
            drawString(15, 55, "INSTRUCTION", COLOR(30, 30, 30));
            drawString(35, 55, "1.DO NOT TORUCH WALL", COLOR(30, 30, 30));
            drawString(55, 55, "2.DO NOT APPROACH MONSTER", COLOR(30, 30, 30));
            drawString(75, 55, "3.# OF MOVE IS LIMITED", COLOR(30, 30, 30));
            drawString(95, 55, "4.GET THE GOLD", COLOR(30, 30, 30));
            snprintf(scoreStr2, 16, "BEST SCORE: %d", bestScore);
            drawString(105, 55, scoreStr2, COLOR(30, 30, 30));
            drawString(120, 55, "PRESS LEFT TO SEE LESS", COLOR(30, 30, 30));
            drawString(130, 55, "PRESS START TO PLAY", COLOR(30, 30, 30));
            drawString(140, 55, "PRESS SELECT TO BACK", COLOR(30, 30, 30));
            firstINST = 0;
          } else {
            drawFullScreenImageDMA(startPage);
            drawString(15, 55, "INSTRUCTION", COLOR(30, 30, 30));
            drawString(35, 55, "1.DO NOT TORUCH WALL", COLOR(30, 30, 30));
            drawString(55, 55, "2.DO NOT APPROACH MONSTER", COLOR(30, 30, 30));
            snprintf(scoreStr2, 16, "BEST SCORE: %d", bestScore);
            drawString(105, 55, scoreStr2, COLOR(30, 30, 30));
            drawString(120, 55, "PRESS RIGHT TO SEE MORE", COLOR(30, 30, 30));
            drawString(130, 55, "PRESS START TO PLAY", COLOR(30, 30, 30));
            drawString(140, 55, "PRESS SELECT TO BACK", COLOR(30, 30, 30));
            firstINST = 0;
          }
        }
        if (KEY_JUST_PRESSED(BUTTON_LEFT, currentButtons, previousButtons)) {
            more = 0; 
            firstINST = 1;
        }
        if (KEY_JUST_PRESSED(BUTTON_RIGHT, currentButtons, previousButtons)) {
            more = 1; 
            firstINST = 1;
        }
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
            fillScreenDMA(BLACK);
            score = 0;
            vBlankCounter = 0;
            state = PLAY;
        }
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          score = 0;
          try = 100;
          state = START;
          playerX = 25;
          playerY = 50;
          firstPLAY = 1;
          firstWIN = 1;
          firstLOSE = 1;
          firstSTART = 1;
          dieCondition = 0;
          gain = 1;
        }
        break;
    }
    previousButtons = currentButtons;
  }
  return 0;
}