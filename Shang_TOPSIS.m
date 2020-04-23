function [dscore,index]=Shang(X)
%%��������
data= X;
%% ���ݹ�һ������ ��Ҫ��������������˴�ֻΪʵ��
[n,m]=size(data);
maxdata(:,1)=repmat(max(data(:,1)),n,1);
maxdata(:,2:3)=repmat(min(data(:,2:3)),n,1);
mindata(:,1)=repmat(min(data(:,1)),n,1);
mindata(:,2:3)=repmat(max(data(:,2:3)),n,1);
max_min=abs(maxdata-mindata);
stddata=abs(data-mindata)./max_min;
%% ������Ϣ�ؼ����ָ���Ȩ��
f=(1+stddata)./repmat(sum(1+stddata),n,1);
e=-1/log(n)*sum(f.*log(f));
d=1-e;
w=d/sum(d); % Ȩ��
%% ������Ȩ���߾���&ȷ���������͸������
normdata=repmat(w,n,1).*stddata; % ��Ȩ���߾���
posideal=max(normdata); % �������
negideal=min(normdata); % �������
%% �����Ȩ��ľ�������������������ŷʽ����
dtopos=sqrt(sum((normdata-repmat(posideal,n,1)).^2,2));
dtoneg=sqrt(sum((normdata-repmat(negideal,n,1)).^2,2));
%% ����������������ýӽ��̶Ȳ��õ�������
d=dtoneg./(dtoneg+dtopos);
[dscore,index]=sort(d,'descend');
%% ���
result=[{'����(����)/ԭ���'},{'�ӽ��̶�'}; num2cell(index),num2cell(dscore)]

