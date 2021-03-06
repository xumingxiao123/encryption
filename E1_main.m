%---------------------加密流程--------------------------------------
%---------------------开始程序-------------------------------------
%clear;
%Vertex：明文图像读取
%A：一维系统生成的伪随机序列
%E：加密过程中的矩阵
%D:  解密过程中的矩阵
%T：存储小数部分数据的矩阵
%F：小数部分的加密过程
%G：矩阵数据变化时的矩阵
%-----------------------------------------------------------------
%Vertex = zeros(1,1);
Vertex=read_STL_ASCII('导弹全正stl模型.txt');
 h =hash(Vertex,'SHA512');
%  Vertex=read_STL_ASCII('missile1.stl');
[M,N]=size(Vertex);%数组大小X*Y
 %P1=reshape(Vertex,1,M*N);
 %P2=str2double(P1);
%%--------------------显示初始图像---------------------------------
 show_3D_scatter3(Vertex,M);
 show_3D_fill3(Vertex,M);

%---------------------混沌系统生成-----------------------------------
%SHE-3生成系统初始值
u0=0.5;
x0=0.2357;
%带入初值，迭代200次，达到充分混沌状态
x=x0;
u=3.89+0.11*u0;
for i=1:200
    x=u*x*(1-x);
end
%产生A1
A1=zeros(1,M*N);
A1(1)=x;
for i=1:M*N-1
A1(i+1)=u*A1(i)*(1-A1(i));%将生成的混沌序列写入A1
end
%产生A2
A2=zeros(1,M*N);
A2(1)=A1(M*N);
for i=1:M*N-1
A2(i+1)=u*A2(i)*(1-A2(i));%将生成的混沌序列写入A2
end
%产生A3
A3=zeros(1,M*N);
A3(1)=A2(M*N);
for i=1:M*N-1
A3(i+1)=u*A3(i)*(1-A3(i));%将生成的混沌序列写入A3
end
%产生A4
A4=zeros(1,M*N);
A4(1)=A3(M*N);
for i=1:M*N-1
A4(i+1)=u*A4(i)*(1-A4(i));%将生成的混沌序列写入A4
end
%产生A5
A5=zeros(1,M*N);
A5(1)=A4(M*N);
for i=1:M*N-1
A5(i+1)=u*A5(i)*(1-A5(i));%将生成的混沌序列写入A4
end
%---------------------增加随机数据-----------------------------------------------
% [G1,M1]=increase_data(Vertex,A1,A2);
% show_3D_scatter3(G1,M1);
% show_3D_fill3(G1,M1);%G1就是增加数据后的矩阵，M1是行数
%-------------------浮点数小数（Decimals）部分存储-----------------------------
%  Vertex(1,1)=50;
T1=floor(Vertex);
T2=(Vertex-T1)*10000;
F1=E_1(T2,A4,A5);%只进行置乱处理
%-----------------------置乱处理-------------------------------------------------
E1=E_1(Vertex,A1,A2);%费雪耶兹置乱和排序置乱
%-----------------------输出程序测试---------------------------------------------
show_3D_scatter3(E1,M);
show_3D_fill3(E1,M);
%----------------------扩散处理----------------------------------------------------
E2=E_2(E1,A3);
E3=E2+F1*0.0001;
% E3(1:20,:)=0;
%------------------------显示加密后的图像---------------------------------------------------
% show_3D_scatter3(E3,M);
% show_3D_fill3(E3,M);
% %-----------------------密文写入文件--------------------------------------------------------
%   write_STL_ASCII(E3,'密文');
 
