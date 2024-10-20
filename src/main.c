#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <permissions (octal)> <file>\n", argv[0]);
        return 1;
    }

    char *endptr;
    unsigned long mode = strtoul(argv[1], &endptr, 8); 

    if (mode > 07777 || *endptr != '\0') {
        fprintf(stderr, "Invalid mode: %s\n", argv[1]);
        return 1;
    }

    if (chmod(argv[2], (mode_t)mode) == -1) {
        fprintf(stderr, "Error changing permissions of %s: %s\n", argv[2], strerror(errno));
        return 1;
    }

    printf("Permissions of '%s' successfully changed to %o\n", argv[2], (unsigned int)mode);
    return 0;
}
