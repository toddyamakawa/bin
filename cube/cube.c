
#include <stdio.h>
#include <stdint.h>

#define CUBE_GET_COLOR(side, piece) (((side) >> (3*(piece))) & 0b111)
#define CUBE_SET_COLOR(side, piece, color) side = ((side) | (0b111 << (3*(piece))) & (color << (3*(piece))))

typedef struct {
	uint32_t u;
	uint32_t d;
	uint32_t f;
	uint32_t b;
	uint32_t r;
	uint32_t l;
} Cube;

typedef enum {
	gray,
	yellow,
	white,
	green,
	blue,
	red,
	orange,
} Color;


// Fill one side with a color
void cube_side_fill(uint32_t *side, Color color) {
	uint32_t fill = 0;
	int piece;
	for(piece = 0; piece <= 8; piece++)
		CUBE_SET_COLOR(fill, piece, color);
	*side = fill;
}

void cube_init(Cube *cube) {
	cube_side_fill(&cube->u, white);
	cube_side_fill(&cube->d, yellow);
	cube_side_fill(&cube->f, green);
	cube_side_fill(&cube->b, blue);
	cube_side_fill(&cube->l, orange);
	cube_side_fill(&cube->r, red);
}

int cube_color2ansi(Color c) {
	switch(c) {
		case gray:   return 8;
		case yellow: return 11;
		case white:  return 15;
		case green:  return 10;
		case blue:   return 12;
		case red:    return 9;
		case orange: return 208;
		default:     return 0;
	}
}

void cube_print_side(int x, int y, uint32_t side) {
	int c0, c1, c2, c3, c4, c5, c6, c7, c8;

	c0 = cube_color2ansi(CUBE_GET_COLOR(side, 0));
	c1 = cube_color2ansi(CUBE_GET_COLOR(side, 1));
	c2 = cube_color2ansi(CUBE_GET_COLOR(side, 2));
	c3 = cube_color2ansi(CUBE_GET_COLOR(side, 3));
	c4 = cube_color2ansi(CUBE_GET_COLOR(side, 4));
	c5 = cube_color2ansi(CUBE_GET_COLOR(side, 5));
	c6 = cube_color2ansi(CUBE_GET_COLOR(side, 6));
	c7 = cube_color2ansi(CUBE_GET_COLOR(side, 7));
	c8 = cube_color2ansi(CUBE_GET_COLOR(side, 8));

	//printf("%03d %03d %03d\n", c1, c2, c3);
	//printf("%03d %03d %03d\n", c8, c0, c4);
	//printf("%03d %03d %03d\n", c7, c6, c5);

	printf("\e[%d;%dH", x, y);
	printf("\x1b[38;5;%dm███ \x1b[38;5;%dm███ \x1b[38;5;%dm███", c1, c2, c3);
	printf("\e[%d;%dH", x+1, y);
	printf("\x1b[38;5;%dm▀▀▀ \x1b[38;5;%dm▀▀▀ \x1b[38;5;%dm▀▀▀", c1, c2, c3);

	printf("\e[%d;%dH", x+2, y);
	printf("\x1b[38;5;%dm███ \x1b[38;5;%dm███ \x1b[38;5;%dm███", c8, c0, c4);
	printf("\e[%d;%dH", x+3, y);
	printf("\x1b[38;5;%dm▀▀▀ \x1b[38;5;%dm▀▀▀ \x1b[38;5;%dm▀▀▀", c8, c0, c4);

	printf("\e[%d;%dH", x+4, y);
	printf("\x1b[38;5;%dm███ \x1b[38;5;%dm███ \x1b[38;5;%dm███", c7, c6, c5);
	printf("\e[%d;%dH", x+5, y);
	printf("\x1b[38;5;%dm▀▀▀ \x1b[38;5;%dm▀▀▀ \x1b[38;5;%dm▀▀▀", c7, c6, c5);
	printf("\e[0m");
}

void print_cube(Cube *cube, int x_offset, int y_offset) {
	cube_print_side( 1+x_offset, 13+y_offset, cube->u);
	cube_print_side( 7+x_offset,  1+y_offset, cube->l);
	cube_print_side( 7+x_offset, 13+y_offset, cube->f);
	cube_print_side( 7+x_offset, 25+y_offset, cube->r);
	cube_print_side( 7+x_offset, 37+y_offset, cube->b);
	cube_print_side(13+x_offset, 13+y_offset, cube->d);
}

int main(int argc, char *argv[])
{
	Cube cube;
	int i;
	uint32_t s = 0;
	//for(i = 0; i < argc; i++)
	//	printf("argv[%d] = %s\n", i, argv[i]);

	cube_init(&cube);
	printf("\e[2J");
	print_cube(&cube, 0,0);
	printf("\n");

	return 0;
}


