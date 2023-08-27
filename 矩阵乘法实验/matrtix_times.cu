#include<iostream>
#include <cuda_runtime.h>
#include<stdio.h>

using namespace std;


#define LINE 700
#define TYPE int


__global__ void two_matrix_times(const TYPE* a, const TYPE* b, TYPE* c,int rows, int cols){
    // 此代码用于求两个矩阵之间的二范数距离
    int x = blockIdx.x*blockDim.x + threadIdx.x;//x,y 在全局kernal中的位置
    if(x < rows*cols){
        // (*c) += (a[x] - b[x])*(a[x] - b[x]); //这种方式会产生竞争
        atomicAdd(c, (a[x] - b[x])*(a[x] - b[x]));
        __syncthreads();//等待所有的线程计算完成
    }
    
}

void print_matrixs(const TYPE* res, int rows, int cols){
    for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
            cout<<" "<<res[rows*i + j];
        }
        cout<<endl;
    }
    
}

void init_matrix(TYPE* data, int rows, int cols, TYPE num){
    for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
            data[i*rows+j] = num;
        }
    }
}

int main(int argc, char const *argv[])
{

    cudaEvent_t start, stop; //创建event
    float elapsedTime;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    size_t size = LINE*LINE*sizeof(TYPE);
    TYPE *D_a, *D_b, *D_c;
    TYPE *H_a, *H_b, *H_c;


    H_a = (TYPE *)malloc(size); // 在Host中分配内存，否则会报错
    H_b = (TYPE *)malloc(size); // 在Host中分配内存，否则会报错
    H_c = (TYPE *)malloc(sizeof(TYPE)); // 在Host中分配内存，否则会报错
    *H_c = 0;
    // cout<<"before malloc "<<*H_c<<endl;
    cudaMalloc((void **)&D_a, size);  //在GPU上分配内存
    cudaMalloc((void **)&D_b, size);
    cudaMalloc((void **)&D_c, sizeof(TYPE));

    init_matrix(H_a, LINE, LINE,3);//初始化矩阵
    init_matrix(H_b, LINE, LINE,1);//初始化矩阵
    
    cudaMemcpy(D_a, H_a, size, cudaMemcpyHostToDevice); //将host上的内容copy到device上。注意这个函数的位置
    cudaMemcpy(D_b, H_b, size, cudaMemcpyHostToDevice);
    cudaMemcpy(D_c, H_c, sizeof(TYPE), cudaMemcpyHostToDevice);

    cudaEventRecord(start, 0); //开始计时
    two_matrix_times<<<958, 512>>>(D_a,D_b,D_c,LINE, LINE); //执行kernal
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsedTime, start, stop); //结束计时，且将运行时间保存在elapsedTime
    cout<<"GPU cost time: "<<elapsedTime/1000.0<<" S"<<endl;

    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    cudaMemcpy(H_c, D_c, sizeof(TYPE),cudaMemcpyDeviceToHost);  // 将运算结果返回给Host
    cout<<"Final result is "<<*H_c<<endl;

    cudaFree(D_a);
    cudaFree(D_b);
    cudaFree(D_c);

    return 0;
}
