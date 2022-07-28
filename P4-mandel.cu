
// To run use the following
// nvcc 4-mandel.cu -o run.out -lGL -lGLU -lglut




#include "common/book.h"
#include "common/cpu_bitmap.h"

#define DIM 1000


// __global__ void kernel(unsigned char *ptr)
// {
//     int x = blockIdx.x;
//     int y = blockIdx.y;

//     int offset = x+y*gridDim.x;

//     int juliaValue = julia(x,y);
//     ptr[offset*4+0] = 255*juliaValue;
//     ptr[offset*4+0] = 0;
//     ptr[offset*4+0] = 0;
//     ptr[offset*4+0] = 255;
// }

int main (void)
{
    CPUBitmap bitmap(DIM, DIM);

    unsigned char *dev_bitmap;

    HANDLE_ERROR(cudaMalloc((void**)&dev_bitmap, bitmap.image_size()));

    dim3 grid(DIM,DIM);
    kernel <<<grid, 1>>> (dev_bitmap);

    HANDLE_ERROR(cudaMemcpy (bitmap.get_ptr(), dev_bitmap, bitmap.image_size(), cudaMemcpyDeviceToHost));
    bitmap.display_and_exit();

    cudaFree(dev_bitmap);
}