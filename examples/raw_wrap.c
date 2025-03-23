
// https://viewsourcecode.org/snaptoken/kilo

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <termios.h>
#include <unistd.h>
#include <unistd.h>

struct termios orig_termios;

void disable_raw_mode() {
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
}

void enable_raw_mode() {

	// Get current termios
	if(tcgetattr(STDIN_FILENO, &orig_termios) == -1) {
		perror("tcgetattr");
		exit(1);
	}

	// Restore termios on exit
	atexit(disable_raw_mode);

	// Set new termios
	struct termios new_termios = orig_termios;
	new_termios.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
	new_termios.c_oflag &= ~(OPOST);
	new_termios.c_cflag |= (CS8);
	new_termios.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
	new_termios.c_cc[VMIN] = 0;
	new_termios.c_cc[VTIME] = 1;

	if(tcsetattr(STDIN_FILENO, TCSAFLUSH, &new_termios) == -1) {
		perror("tcsetattr");
		exit(1);
	}
}

int main(int argc, char *argv[]) {
	if(argc < 2) {
		fprintf(stderr, "Usage: %s <command> [args...]\n", argv[0]);
		return 1;
	}

	enable_raw_mode();

	pid_t pid = fork();
	if(pid < 0) {
		perror("fork");
		return 1;
	} else if(pid == 0) {
		execvp(argv[1], &argv[1]);
		perror(argv[1]);
		exit(1);
	}

	int status;
	waitpid(pid, &status, 0);

	return WIFEXITED(status) ? WEXITSTATUS(status) : 1;
}

