#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
  char fen[1024];
  char color;
  char castle[5];
  char ep[3];
  char sm[3];
  char move[5];
  char fmvn[5];
  int num;
  char rest[10];

  /* fen                                          c c e s  move  fmvn num */
  /* 4r1k1/5pp1/2p5/2b4Q/1pP4P/3P2q1/1PRB1P2/3B3K b - - sm g3f2; fmvn num; */
  while (scanf("%s %c %s %s %s %s %s %d %s\n", fen, &color, castle, ep, sm, move, fmvn, &num, rest) != EOF) {
    if (move[strlen(move)-1] == ';')
      move[strlen(move)-1] = '\0';
    printf("\"%d\",\"%s %c %s %s\",\"%s\"\n", num, fen, color, castle, ep, move);
  }
}
