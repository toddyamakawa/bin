
#include <iostream>
#include <string>
#include <cstdlib>
#include <unistd.h>

void tmpfile(void) {
	std::string tmp;
	char mkstemp_template[] = "/tmp/tmpfile.XXXXXX";
	int fd = mkstemp(mkstemp_template);
	if (fd != -1) {
		tmp = mkstemp_template;
		std::cout << "Generated file name: " << tmp << std::endl;
		close(fd);
	}
}

int main(void) {
	tmpfile();
	return 0;
}

