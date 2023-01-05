
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define CUBE_GET_COLOR(side, piece) (((side) >> (3*(piece))) & 0b111)
#define CUBE_SET_COLOR(side, piece, color) side = ((side) & (~(0b111 << (3*(piece)))) | (color << (3*(piece))))

// =============================================================================
// DATA TYPES
// =============================================================================
typedef union {
	uint32_t all;
	struct {
		uint32_t p0 : 3;
		uint32_t p1 : 3;
		uint32_t p2 : 3;
		uint32_t p3 : 3;
		uint32_t p4 : 3;
		uint32_t p5 : 3;
		uint32_t p6 : 3;
		uint32_t p7 : 3;
		uint32_t p8 : 3;
	};
	struct {
		uint32_t center : 3;
		uint32_t top    : 9;
		uint32_t        : 3;
		uint32_t bottom : 3;
	};
	struct {
		uint32_t        : 6;
		uint32_t right  : 3;
	};
	// left is impossible
} Side;

typedef struct {
	Side u;
	Side d;
	Side f;
	Side b;
	Side r;
	Side l;
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


// =============================================================================
// COLORS
// =============================================================================

// Fill one side with a color
void cube_side_fill(Side *side, Color color) {
	uint32_t fill;
	int piece;
	for(piece = 0; piece <= 8; piece++)
		CUBE_SET_COLOR(fill, piece, color);
	side->all = fill;
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

	// Debug code
	//printf("%03d %03d %03d\n", c1, c2, c3);
	//printf("%03d %03d %03d\n", c8, c0, c4);
	//printf("%03d %03d %03d\n", c7, c6, c5);
	//exit(0);

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
	printf("\e[0m\n");
}

void cube_print(Cube *cube, int x_offset, int y_offset) {
	cube_print_side( 1+x_offset, 13+y_offset, cube->u.all);
	cube_print_side( 7+x_offset,  1+y_offset, cube->l.all);
	cube_print_side( 7+x_offset, 13+y_offset, cube->f.all);
	cube_print_side( 7+x_offset, 25+y_offset, cube->r.all);
	cube_print_side( 7+x_offset, 37+y_offset, cube->b.all);
	cube_print_side(13+x_offset, 13+y_offset, cube->d.all);
}


// =============================================================================
// MOVES
// =============================================================================

// 'U' move
void cube_move_u(Cube *cube) {
	Side side__f;
	side__f.top = cube->f.top;
	cube->f.top = cube->r.top;
	cube->r.top = cube->b.top;
	cube->b.top = cube->l.top;
	cube->l.top = side__f.top;
}

// Cube rotations
void cube_move_x(Cube *cube) {
	Side side__f;
	side__f.all = cube->f.all;
	cube->f.all = cube->d.all;
	cube->d.all = cube->b.all;
	cube->b.all = cube->u.all;
	cube->u.all = side__f.all;
}
void cube_move_y(Cube *cube) {
	Side side__f;
	side__f.all = cube->f.all;
	cube->f.all = cube->l.all;
	cube->l.all = cube->b.all;
	cube->b.all = cube->r.all;
	cube->r.all = side__f.all;
}
void cube_move_z(Cube *cube) {
	Side side__u;
	side__u.all = cube->u.all;
	cube->u.all = cube->l.all;
	cube->l.all = cube->d.all;
	cube->d.all = cube->r.all;
	cube->r.all = side__u.all;
}

void cube_move(Cube *cube, char face, int dir) {
	Side tmp;

	switch(face) {
		case 'U':
			switch(dir) {
				case -1:
				case 3: cube_move_u(cube);
				case 2: cube_move_u(cube);
				case 1: cube_move_u(cube);
				default: break;
			}
			break;

		case 'D':
			cube_move_x(cube);
			cube_move_x(cube);
			switch(dir) {
				case -1:
				case 3: cube_move_u(cube);
				case 2: cube_move_u(cube);
				case 1: cube_move_u(cube);
				default:
					cube_move_x(cube);
					cube_move_x(cube);
					break;
			}
			break;

		case 'x':
			switch(dir) {
				case -1:
				case 3: cube_move_x(cube);
				case 2: cube_move_x(cube);
				case 1: cube_move_x(cube);
				default: break;
			}
			break;

		case 'y':
			switch(dir) {
				case -1:
				case 3: cube_move_y(cube);
				case 2: cube_move_y(cube);
				case 1: cube_move_y(cube);
				default: break;
			}
			break;

		case 'z':
			switch(dir) {
				case -1:
				case 3: cube_move_z(cube);
				case 2: cube_move_z(cube);
				case 1: cube_move_z(cube);
				default: break;
			}
			break;

	}
}

// =============================================================================
// MAIN
// =============================================================================
int main(int argc, char *argv[])
{
	Cube cube;
	int move;
	//int i;
	//for(i = 0; i < argc; i++)
	//	printf("argv[%d] = %s\n", i, argv[i]);

	cube_init(&cube);
	printf("\e[2J");
	cube_print(&cube, 0, 0);

	//cube_move(&cube, 'x', 1); cube_print(&cube, 0, 0); exit(1);

	cube_move(&cube, 'x', 1); cube_print(&cube, 0, 0); printf("1\n"); sleep(1);
	cube_move(&cube, 'x', 1); cube_print(&cube, 0, 0); printf("2\n"); sleep(1);
	cube_move(&cube, 'U', 1); cube_print(&cube, 0, 0); printf("3\n"); sleep(1);
	cube_move(&cube, 'x', 1); cube_print(&cube, 0, 0); printf("4\n"); sleep(1);
	cube_move(&cube, 'x', 1); cube_print(&cube, 0, 0); printf("5\n"); sleep(1);


	//cube_move(&cube, 'D', 1);
	//sleep(1);
	//cube_print(&cube, 0, 0);

	return 0;
}


