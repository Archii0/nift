#include <iostream>
#include <cuda_runtime.h>

__global__ void helloCUDA()
{
    printf("Nifty.");
}

int main()
{
    helloCUDA<<<1, 1>>>();
    cudaDeviceSynchronize();
    return 0;
}