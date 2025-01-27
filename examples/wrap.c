
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
	if (argc < 2) {
		fprintf(stderr, "Usage: %s <command> [args...]\n", argv[0]);
		return 1;
	}

	pid_t pid = fork();
	if (pid < 0) {
		perror("fork");
		return 1;
	} else if (pid == 0) {
		execvp(argv[1], &argv[1]);
		perror(argv[1]);
		exit(1);
	}

	int status;
	waitpid(pid, &status, 0);

	return WIFEXITED(status) ? WEXITSTATUS(status) : 1;
}

