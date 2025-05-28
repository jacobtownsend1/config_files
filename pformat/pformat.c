#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#define LINE_MAX 12
#define VAR_NAME "buffer"

typedef enum {
    PYTHON,
    C,
    RAW
} option;

void printHelp(){
     printf("Usage: pformat <option> <filename>\n\noptions:\n\tp : format output for python\n\tc : format output for C\n\tr : output raw bytes\n");
}

int parseArgv(char * argument){
    if(strcmp(argument, "r") == 0){
        return RAW;
    }
    if(strcmp(argument, "c") == 0){
        return C;
    }
    if(strcmp(argument, "p") == 0){
        return PYTHON;
    }

    return -1;
}

void printPython(uint8_t * buffer, int fileSize){
    int j = 1;
    for(int i = 0; i < fileSize; i++){
        if (i == 0)
            printf("%s = b\"", VAR_NAME);
        else if(j == 1)
             printf("%s += b\"", VAR_NAME);
    
        printf("\\x%02x", buffer[i]);

        if(i == fileSize - 1 || j == LINE_MAX) {
            printf("\"\n");
            j = 1;
            continue;
        }

        j++;
    }
}

void printC(uint8_t * buffer, int fileSize){
    printf("char %s[] = ", VAR_NAME);
    int j = 1;
    for(int i = 0; i < fileSize; i++){
        if(i == 0)
            printf("\"");
        else if (j == 1)
            printf("\t\t\"");

        printf("\\x%02x", buffer[i]);

        if(i == fileSize - 1) {
            printf("\";\n");
        }
        else if(j == LINE_MAX) {
            printf("\"\n");
            j = 1;
            continue;
        }

        j++;
    }
}

void printRaw(uint8_t * buffer, int fileSize){
    int j = 1;
    for(int i = 0; i < fileSize; i++){
        printf("%02x ", buffer[i]);

        if(i == fileSize - 1 || j == LINE_MAX) {
            printf("\n");
            j = 1;
            continue;
        }
        j++;
    }
}

int main(int argc, char ** argv){
    printf("\n");

    if(argc < 3){
        printHelp();
        printf("\n");
        return 0;
    }

    FILE* file;
    int8_t * bytes;
    int fileSize;

    //Get the size of the file
    struct stat st;
    stat(argv[2], &st);
    fileSize = st.st_size;

    bytes = (uint8_t *) malloc(fileSize);
    if(bytes == NULL){
        printf("[!] Failed allocating memory!\n\n");
        return -1;
    }

    file = fopen(argv[2], "r");
    if(file == NULL){
        printf("[!] Failed opening file!\n\n");
        free(bytes);
        return -1;
    }

    while(!feof(file)){
        fread(bytes, fileSize, 1, file);
    }

    switch(parseArgv(argv[1])){
        case PYTHON:
            printPython(bytes, fileSize);
            break;
        case C:
            printC(bytes, fileSize);
            break;
        case RAW:
            printRaw(bytes, fileSize);
            break;
        default:
            printHelp();
            break;
    }

    printf("\n");
    fclose(file);
    free(bytes);
    return 1;
}


