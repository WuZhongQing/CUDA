#include<time.h>
#include<iostream>

using namespace std;

#define LINE 700

void cpu_matrixs_times(int* a, int* b, int *c, int rows, int cols){

    for(int i=0;i<rows*cols ;i++){
        *c += (a[i] - b[i])*(a[i] - b[i]);
    }   
}



int main(int argc, char const *argv[])
{
    
    int a[LINE][LINE];
    int b[LINE][LINE];
    int *c  = new int;
    *c = 0;
    time_t start, end;
    for(int i=0;i<LINE;i++){
        for(int j=0;j<LINE;j++){
            a[i][j]=3;
            b[i][j]=1;
        }

    }
    start = clock();
    cpu_matrixs_times((int*)&a,(int*)&b,c,LINE,LINE);
    end = clock();

    cout<<"Final result is : "<<*c<<endl;
    cout<<"Cost time: "<<(end - start)/1000.0 <<" lS"<<endl;
    delete c;
    // for(int i=0;i<LINE;i++){
    //     for(int j=0;j<LINE;j++){

    //         cout<<" "<<c[i][j];
    //     }
    //     cout<<endl;
    // }


    return 0;
}
