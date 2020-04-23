function [dscore,index]=Shang(X)
%%导入数据
data= X;
%% 数据归一化处理 需要单独分情况处理，此处只为实例
[n,m]=size(data);
maxdata(:,1)=repmat(max(data(:,1)),n,1);
maxdata(:,2:3)=repmat(min(data(:,2:3)),n,1);
mindata(:,1)=repmat(min(data(:,1)),n,1);
mindata(:,2:3)=repmat(max(data(:,2:3)),n,1);
max_min=abs(maxdata-mindata);
stddata=abs(data-mindata)./max_min;
%% 利用信息熵计算各指标的权重
f=(1+stddata)./repmat(sum(1+stddata),n,1);
e=-1/log(n)*sum(f.*log(f));
d=1-e;
w=d/sum(d); % 权重
%% 计算熵权决策矩阵&确定正理想解和负理想解
normdata=repmat(w,n,1).*stddata; % 加权决策矩阵
posideal=max(normdata); % 正理想解
negideal=min(normdata); % 负理想解
%% 计算加权后的决策数据与正负理想解的欧式距离
dtopos=sqrt(sum((normdata-repmat(posideal,n,1)).^2,2));
dtoneg=sqrt(sum((normdata-repmat(negideal,n,1)).^2,2));
%% 计算各样本与理想解得接近程度并得到排序结果
d=dtoneg./(dtoneg+dtopos);
[dscore,index]=sort(d,'descend');
%% 结果
result=[{'排名(降序)/原序号'},{'接近程度'}; num2cell(index),num2cell(dscore)]

