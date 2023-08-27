#include<iostream>
#include<time.h>

using namespace std;

void count_time(){
    // 该函数用于单线程计时操作，使用时改一下函数就好了
    time_t start, end;
    start = clock();
    //在此处运行你的函数

    end = clock();
    cout<<"CPU cost time: "<<(end - start)/1000.0 <<" S"<<endl;
}
