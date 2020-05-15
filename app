#include <stdio.h>
#include <stdlib.h>

int isPrime(int n) {
        if(n == 1) {
                return 0;
        }
    int i;
    for (i = 2; i <= n / 2; ++i) {
        if (n % i == 0) {
            return 0;
        }
    }
    return 1;
}

/// This method returns false, if it is not possible to find a way
/// this can be the case, when whole triangle is filled only with 
// prime numbers
int findMaxSum(int num[100][100], int row, int col, int totalRows, int *sum) {
        if(isPrime(num[row][col])) {
                return 0;
        }
    if (row == totalRows - 1) {
        // we are at last stage, then there is no move.
        *sum = num[row][col];
        return 1;
    }

    // check both moves, and which one results in better move
    int sum1 = 0, sum2 = 0;
    int status = 0;

    if(findMaxSum(num, row + 1, col, totalRows, &sum1)) {
            status = 1;
    }
    if(findMaxSum(num, row + 1, col + 1, totalRows, &sum2)) {
            status = 1;
    }

    if(status) {
            *sum = num[row][col] + (sum1 > sum2 ? sum1 : sum2);
            return 1;
    } else {
            return 0;
    }
}

int main(void) {
    FILE *myFile;
    myFile = fopen("somenumbers.txt", "r");

    if (myFile == NULL) {
        printf("Error Reading File\n");
        exit(0);
    }

    // I assume, maximum triangle size is 100x100
    int numbers[100][100];
    int row = 0;
    int col = 0, i = 0;
    int totalRows;

    while (!feof(myFile)) {
        // If it is row i, then it will have (i+1) numbers
        for (col = 0; col < (row + 1); col++) {
            fscanf(myFile, "%d", &numbers[row][col]);
        }

        // Move to next row
        row++;
    }

    totalRows = row;

    // Print the matrix
    for (i = 0; i < totalRows; i++) {
        for (col = 0; col < (i + 1); col++) {
            printf("%d ", numbers[i][col]);
        }
        printf("\n");
    }

        int sum;
        int status = findMaxSum(numbers, 0, 0, totalRows, &sum);

        if(status) {
                printf("\nThe maximum possible sum of the matrix is %d\n", sum);
        } else {
                printf("\nIt is not possible to reach to the last row in the matrix.\n");
        }

    return 0;
}
