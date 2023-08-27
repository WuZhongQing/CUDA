# CUDA算子库
该库用于保存自己写的CUDA算子 \
算子因该具备的特性： 
1. 易迁移性
2. 性能优
3. 支持GPU和CPU
4. 支持多线程 （或者是防止线程冲突）
   

## 常用算子

### [矩阵乘法](https://github.com/WuZhongQing/CUDA/tree/main/%E7%9F%A9%E9%98%B5%E4%B9%98%E6%B3%95%E5%AE%9E%E9%AA%8C)
在这个模块中，分别对比单线程与多线程的运行时间。对比结果如下表所示：
| CPU运行时间 | GPU运行时间 | 备注                             |
| ----------- | ----------- | ---------------------------------|
|  1.186S     |  3.257e-05S  | GPU在使用加法的时候使用了原子操作  |



### CNN
1.CPU版本的CNN操作
卷积的尺寸计算关系为： \
$$![](https://latex.codecogs.com/svg.image?&space;Output=\frac{(Input-Kernal_size&plus;2*Pad)}{Stride}&plus;1)$$

2.GPU版本的CNN操作

3.CPU与GPU版本的操作时间对比


### NMS

### Relu

### ...待续
