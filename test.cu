#include <iostream>
#include <stdio.h>
#include "./common/book.h"

__global__ void add(int a, int b, int *c)
{
    *c = a + b;
}

int main(void)
{
    int count;
    cudaDeviceProp prop;
    HANDLE_ERROR(cudaGetDeviceCount(&count));
    HANDLE_ERROR(cudaGetDeviceProperties(&prop, count - 1));
    printf(" --- General Information for device %d ---\n", count);
    printf("Name: %s\n", prop.name);
    printf("Compute capability: %d.%d\n", prop.major, prop.minor);
    printf("Clock rate: %d\n", prop.clockRate);
    printf("Device copy overlap: ");
    if (prop.deviceOverlap)
        printf("Enabled\n");
    else
        printf("Disabled\n");
    printf("Kernel execition timeout : ");
    if (prop.kernelExecTimeoutEnabled)
        printf("Enabled\n");
    else
        printf("Disabled\n");
    printf(" --- Memory Information for device %d ---\n", count);
    printf("Total global mem: %ld\n", prop.totalGlobalMem);
    printf("Total constant Mem: %ld\n", prop.totalConstMem);
    printf("Max mem pitch: %ld\n", prop.memPitch);
    printf("Texture Alignment: %ld\n", prop.textureAlignment);
    printf(" --- MP Information for device %d ---\n", count);
    printf("Multiprocessor count: %d\n", prop.multiProcessorCount);
    printf("Shared mem per mp: %ld\n", prop.sharedMemPerBlock);
    printf("Registers per mp: %d\n", prop.regsPerBlock);
    printf("Threads in warp: %d\n", prop.warpSize);
    printf("Max threads per block: %d\n", prop.maxThreadsPerBlock);
    printf("Max thread dimensions: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
    printf("Max grid dimensions: (%d, %d, %d)\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
    printf("\n");
    // std::cout<< "name "<< prop.name<< std::endl;
    // std::cout<< "totalGloblaMem "<< prop.totalGlobalMem<< std::endl;
    // std::cout<< "max threads dim "<< prop.maxThreadsDim[0]<< prop.maxThreadsDim[1]<< prop.maxThreadsDim[2]<<std::endl;
    // std::cout<< "max threads per block "<< prop.maxThreadsPerBlock<< std::endl;
    // std::cout<< "compute mode "<< prop.computeMode<< std::endl;
    // std::cout<< "max Grid size "<< prop.maxGridSize[1]<< std::endl;
    // std::cout<<"count is: "<<count<<std::endl;
    int c;
    int *dev_c;
    HANDLE_ERROR(cudaMalloc((void **)&dev_c, sizeof(int)));
    add<<<1, 1>>>(2, 7, dev_c);
    HANDLE_ERROR(cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost));
    printf("2 + 7 = %d\n", c);
    cudaFree(dev_c);
    return 0;
}
