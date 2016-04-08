/*
 ============================================================================
 Name        : Assignment CMCP
 Author      : Mihaita Alexandru Lupoiu
 Version     : 0.0.1
 Description : LDL' Factorization using OpenMP and MPI
 ============================================================================
 */
#include <stdio.h>
#include <stdlib.h>
#include "tools.h"

void printMatrix(double** matrix,size_t size){
    printf("\n *************** MATRIX ****************\n\n");
    int i,j;
    for(i = 0; i < size; i++) {
        for (j = 0; j < size; ++j) {
            printf(" %f ",matrix[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

void printMatrixCustom(double* matrix,size_t size_r,size_t size_c){
    printf("\n *************** MATRIX ****************\n\n");
    int i,j;
    for(i = 0; i < size_r; i++) {
        for (j = 0; j < size_c; ++j) {
            printf(" %f ",matrix[i*size_c+j]);
        }
        printf("\n");
    }
    printf("\n");
}

void printMatrixCustomCPU(double* matrix,size_t size_r,size_t size_c, int poces){
    printf("\n *************** MATRIX Process %d ****************\n\n",poces);
    int i,j;
    for(i = 0; i < size_r; i++) {
        for (j = 0; j < size_c; ++j) {
            printf(" %f ",matrix[i*size_c+j]);
        }
        printf("\n");
    }
    printf("\n");
}

void printVector(double* vector, size_t size){
    printf("\n *************** VECTOR ****************\n\n");
    int i;
    for(i = 0; i < size; i++) {
        printf(" %f ",vector[i]);
    }
    printf("\n");
}

void initialize(double **matrix ,size_t size){
    //double A[3][3] = {{2,2,1},{2,5,2},{1,2,2}};

    int i,j, randomValue;
    for(i = 0; i < size; i++) {
        for (j = 0; j <= i; j++) {
            if(i==j){
                //matrix[i][j] = A[i][j];
                matrix[i][j]= (rand() % 100 + 1)+200;
            }else{
                //matrix[i][j] = A[i][j];
                //matrix[j][i] = A[j][i];
                randomValue = rand() % 100 + 1;
                matrix[i][j] = randomValue;
                matrix[j][i] = randomValue;
            }
        }
    }
}

void initializeCust(double *matrix ,size_t size){
    //double A[3][3] = {{2,2,1},{2,5,2},{1,2,2}};

    int i,j, randomValue;
    for(i = 0; i < size; i++) {
        for (j = 0; j <= i; j++) {
            if(i==j){
                //matrix[i+j*size] = A[i][j];

                matrix[i+j*size] = (rand() % 100 + 1)+200;
            }else{
                //matrix[i+j*size] = A[i][j];
                //matrix[j+i*size] = A[j][i];

                randomValue = rand() % 100 + 1;
                matrix[i+j*size] = randomValue;
                matrix[j+i*size] = randomValue;
            }
        }
    }
}

void copyMatrix(double **matrix, double **matrixToCopy ,size_t size){
    int i,j;
    for(i = 0; i < size; i++) {
        for (j = 0; j <= i; j++) {
                matrixToCopy[i][j] = matrix[i][j];
                matrixToCopy[j][i] = matrix[j][i];
            }
    }
}
void copyMatrixCustom(double *matrix, double *matrixToCopy ,size_t size){
    int i,j;
    for(i = 0; i < size; i++) {
        for (j = 0; j <= i; j++) {
            matrixToCopy[i*size+j] = matrix[i*size+j];
            matrixToCopy[j*size+i] = matrix[j*size+i];
        }
    }
}

double **make2dmatrix(size_t size) {
    int i;
    double **m;
    m = (double**)calloc(size,sizeof(double*));
    for (i=0;i<size;i++)
        m[i] = (double*)calloc(size,sizeof(double));
    return m;
}

void free2dmatrix(double **matrix, size_t size) {
    int i;
    if (!matrix) return;
    for(i=0;i<size;i++)
        free(matrix[i]);
    free(matrix);
}

double **make2dmatrixCustom(size_t size_r,size_t size_c){
    int i;

    double *dado = (double *)calloc(size_r*size_c,sizeof(double));

    double **array = (double **)calloc(size_r,sizeof(double*));

    for(i = 0; i < size_r; i++)
        array[i] = &(dado[size_c*i]);

    return array;
};
