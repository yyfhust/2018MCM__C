w1=-1
w2=1000
w=2
%%%%%%%%%%%%%%%%%%%%TETCB
filename = 'C:\Users\yyf\Desktop\MCM\total\FFTCB-AZ.csv';
delimiter = {''};

%% 将数据列作为文本读取:
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%s%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r','n','UTF-8');
% 跳过 BOM (字节顺序标记)。
fseek(fileID, 3, 'bof');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 将包含数值文本的列内容转换为数值。
% 将非数值文本替换为 NaN。
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% 将输入元胞数组中的文本转换为数值。已将非数值文本替换为 NaN。
rawData = dataArray{1};
for row=1:size(rawData, 1)
    % 创建正则表达式以检测并删除非数值前缀和后缀。
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        
        % 在非千位位置中检测到逗号。
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % 将数值文本转换为数值。
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end


%% 创建输出变量
TETCB = cell2mat(raw);

VarName1=power(TETCB,w)
syms a b;
c=[a b]';
A=VarName1';
B=cumsum(A);  % 原始数据累加
n=length(A);
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;  % 生成累加矩阵
end
% 计算待定参数的值
D=A;D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% 预测后续数据
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G1=[];G1(1)=A(1);
for i=2:(n+41)
    G1(i)=F(i)-F(i-1); %得到预测出来的数据
end
predict1=power(G1,1/w)

A=TETCB'
B=cumsum(A);  % 原始数据累加
n=length(A);
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;  % 生成累加矩阵
end
% 计算待定参数的值
D=A;D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% 预测后续数据
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G1=[];G1(1)=A(1);
for i=2:(n+41)
    G1(i)=F(i)-F(i-1); %得到预测出来的数据
end




%%%%%%%%%%%%%%%%%%%%CA
filename = 'C:\Users\yyf\Desktop\MCM\total\FFTCB-CA.csv';
delimiter = {''};

%% 将数据列作为文本读取:
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%s%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r','n','UTF-8');
% 跳过 BOM (字节顺序标记)。
fseek(fileID, 3, 'bof');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 将包含数值文本的列内容转换为数值。
% 将非数值文本替换为 NaN。
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% 将输入元胞数组中的文本转换为数值。已将非数值文本替换为 NaN。
rawData = dataArray{1};
for row=1:size(rawData, 1)
    % 创建正则表达式以检测并删除非数值前缀和后缀。
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        
        % 在非千位位置中检测到逗号。
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % 将数值文本转换为数值。
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end


%% 创建输出变量
TETCB_CA = cell2mat(raw);

VarName1=power(TETCB_CA,w)
syms a b;

A=VarName1';
B=cumsum(A);  % 原始数据累加
n=length(A);
for i=1:(n-1)
    CC(i)=(B(i)+B(i+1))/2;  % 生成累加矩阵
end
% 计算待定参数的值
D=A;D(1)=[];
D=D';
E=[-CC;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% 预测后续数据
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G2=[];G2(1)=A(1);
for i=2:(n+41)
    G2(i)=F(i)-F(i-1); %得到预测出来的数据
end
predict2=power(G2,1/w)



%%%%%%%%%%%%%%%%%%%%NM
filename = 'C:\Users\yyf\Desktop\MCM\total\FFTCB-NM.csv';
delimiter = {''};

%% 将数据列作为文本读取:
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%s%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r','n','UTF-8');
% 跳过 BOM (字节顺序标记)。
fseek(fileID, 3, 'bof');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 将包含数值文本的列内容转换为数值。
% 将非数值文本替换为 NaN。
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% 将输入元胞数组中的文本转换为数值。已将非数值文本替换为 NaN。
rawData = dataArray{1};
for row=1:size(rawData, 1)
    % 创建正则表达式以检测并删除非数值前缀和后缀。
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        
        % 在非千位位置中检测到逗号。
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % 将数值文本转换为数值。
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end


%% 创建输出变量
TETCB_NM= cell2mat(raw);

VarName1=power(TETCB_NM,w)
syms a b;

A=VarName1';
B=cumsum(A);  % 原始数据累加
n=length(A);
for i=1:(n-1)
    CC(i)=(B(i)+B(i+1))/2;  % 生成累加矩阵
end
% 计算待定参数的值
D=A;D(1)=[];
D=D';
E=[-CC;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% 预测后续数据
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G3=[];G3(1)=A(1);
for i=2:(n+41)
    G3(i)=F(i)-F(i-1); %得到预测出来的数据
end
predict3=power(G3,1/w)




%%%%%%%%%%%%%TX
filename = 'C:\Users\yyf\Desktop\MCM\total\FFTCB-TX.csv';
delimiter = {''};

%% 将数据列作为文本读取:
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%s%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r','n','UTF-8');
% 跳过 BOM (字节顺序标记)。
fseek(fileID, 3, 'bof');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 将包含数值文本的列内容转换为数值。
% 将非数值文本替换为 NaN。
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% 将输入元胞数组中的文本转换为数值。已将非数值文本替换为 NaN。
rawData = dataArray{1};
for row=1:size(rawData, 1)
    % 创建正则表达式以检测并删除非数值前缀和后缀。
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        
        % 在非千位位置中检测到逗号。
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % 将数值文本转换为数值。
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end


%% 创建输出变量
TETCB_TX= cell2mat(raw);

VarName1=power(TETCB_TX,w)
syms a b;

A=VarName1';
B=cumsum(A);  % 原始数据累加
n=length(A);
for i=1:(n-1)
    CC(i)=(B(i)+B(i+1))/2;  % 生成累加矩阵
end
% 计算待定参数的值
D=A;D(1)=[];
D=D';
E=[-CC;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% 预测后续数据
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G4=[];G4(1)=A(1);
for i=2:(n+41)
    G4(i)=F(i)-F(i-1); %得到预测出来的数据
end
predict4=power(G4,1/w)




t1=1960:2050;
t2=1960:2009
plot(t2,TETCB,'.r',t1,predict1,'r')  %原始数据与预测数据的比较
hold on;
%plot(t2,TETCB_CA,'.b',t1,predict2,'b')  %原始数据与预测数据的比较
%hold on;
plot(t2,TETCB_NM,'.k',t1,predict3,'k')  %原始数据与预测数据的比较
%hold on;
%plot(t2,TETCB_TX,'.m',t1,predict4,'m')  %原始数据与预测数据的比较


%legend('Original Data,AZ','Prediction Curve,AZ','Original Data,CA','Prediction Curve,CA','Original Data,NM','Prediction Curve,NM','Original Data,TX','Prediction Curve,TX','location','NorthWest');

grid on;

xlabel('Year')
ylabel('Consumption (Billion BTU)')
title('Total Consumption Fossil Fuels Prediction');
set(gca,'Xtick',1960:5:2050) %设置间隔
