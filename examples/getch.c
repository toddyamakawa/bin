
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>


struct termios orig_termios;

void disable_raw_mode() {
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
}

void enable_raw_mode() {
	tcgetattr(STDIN_FILENO, &orig_termios);
	atexit(disable_raw_mode);

	struct termios new_termios = orig_termios;
	new_termios.c_lflag &= ~(ECHO | ICANON);
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &new_termios);
}

int main() {
	//enable_raw_mode();

	char c = '\0';
	while(c != 'q') {
		int n = read(STDIN_FILENO, &c, 1);
		if(n != 1) continue;
		if(iscntrl(c)) {
			printf("%d\r\n", c);
		}
		else {
			printf("%d ('%c')\r\n", c, c);
		}
	}
	return 0;
}

