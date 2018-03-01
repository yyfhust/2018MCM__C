
w=2.73109


%%%%%%%%%%%%%%%%%%%%TETCB
TETCB_filename = 'C:\Users\yyf\Desktop\MCM\total\TETCB-AZ.csv';
delimiter = {''};
formatSpec = '%f%[^\n\r]';
fileID = fopen(TETCB_filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
TETCB = [dataArray{1:end-1}];

VarName1=power(TETCB,w)
syms a b;
c=[a b]';
A=VarName1';
B=cumsum(A);  
n=length(A);
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;  
end

D=A;D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);

F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G1=[];G1(1)=A(1);
for i=2:(n+41)
    G1(i)=F(i)-F(i-1); 
end
predict1=power(G1,1/w)

A=TETCB'
B=cumsum(A);  
n=length(A);
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;  
end

D=A;D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);

F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G1=[];G1(1)=A(1);
for i=2:(n+41)
    G1(i)=F(i)-F(i-1); 
end

%%%%%%%%%%%%%%%%%%%%CA
filename = 'C:\Users\yyf\Desktop\MCM\total\TETCB-CA.csv';
delimiter = {''};

formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r','n','UTF-8');

fseek(fileID, 3, 'bof');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

fclose(fileID);

raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

rawData = dataArray{1};
for row=1:size(rawData, 1)

    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end

TETCB_CA = cell2mat(raw);

VarName1=power(TETCB_CA,w)
syms a b;

A=VarName1';
B=cumsum(A);  
n=length(A);
for i=1:(n-1)
    CC(i)=(B(i)+B(i+1))/2;  
end

D=A;D(1)=[];
D=D';
E=[-CC;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G2=[];G2(1)=A(1);
for i=2:(n+41)
    G2(i)=F(i)-F(i-1); 
end
predict2=power(G2,1/w)

%%%%%%%%%%%%%%%%%%%%NM
filename = 'C:\Users\yyf\Desktop\MCM\total\TETCB-NM.csv';
delimiter = {''};
formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r','n','UTF-8');
fseek(fileID, 3, 'bof');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
rawData = dataArray{1};
for row=1:size(rawData, 1)
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end

TETCB_NM= cell2mat(raw);

VarName1=power(TETCB_NM,w)
syms a b;

A=VarName1';
B=cumsum(A);  
n=length(A);
for i=1:(n-1)
    CC(i)=(B(i)+B(i+1))/2;  
end
D=A;D(1)=[];
D=D';
E=[-CC;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G3=[];G3(1)=A(1);
for i=2:(n+41)
    G3(i)=F(i)-F(i-1); 
end
predict3=power(G3,1/w)

%%%%%%%%%%%%%TX
filename = 'C:\Users\yyf\Desktop\MCM\total\TETCB-TX.csv';
delimiter = {''};

formatSpec = '%s%[^\n\r]';


fileID = fopen(filename,'r','n','UTF-8');

fseek(fileID, 3, 'bof');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
rawData = dataArray{1};
for row=1:size(rawData, 1)
       regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData(row), regexstr, 'names');
        numbers = result.numbers;
        invalidThousandsSeparator = false;
        if numbers.contains(',')
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        if ~invalidThousandsSeparator
            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch
        raw{row, 1} = rawData{row};
    end
end
TETCB_TX= cell2mat(raw);

VarName1=power(TETCB_TX,w)
syms a b;
A=VarName1';
B=cumsum(A);  
n=length(A);
for i=1:(n-1)
    CC(i)=(B(i)+B(i+1))/2;  
end
D=A;D(1)=[];
D=D';
E=[-CC;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);

F=[];F(1)=A(1);
for i=2:(n+41)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G4=[];G4(1)=A(1);
for i=2:(n+41)
    G4(i)=F(i)-F(i-1); 
end
predict4=power(G4,1/w)
t1=1960:2050;
t2=1960:2009
plot(t2,TETCB,'.r',t1,predict1,'r')  
hold on;
plot(t2,TETCB_CA,'.b',t1,predict2,'b')  
hold on;
plot(t2,TETCB_NM,'.k',t1,predict3,'k')  
hold on;
plot(t2,TETCB_TX,'.m',t1,predict4,'m') 

legend('Original Data,AZ','Prediction Curve,AZ','Original Data,CA','Prediction Curve,CA','Original Data,NM','Prediction Curve,NM','Original Data,TX','Prediction Curve,TX','location','NorthWest');

grid on;

xlabel('Year')
ylabel('Consumption (Billion BTU)')
title('Total Energy Consumption Prediction');
set(gca,'Xtick',1960:5:2050) 