function [ encoded ] = Encoding_8b10b( bits )

% Convert Decimal values to logical Binary Value
bits = bits(:)' > 0;
% length of data bits 
dataLength = length(bits);
% checking if data in 8's multiple if not padding zeros  
m = mod(dataLength, 8); 
if m > 0
    bits = [bits zeros(1,m)];
end
% length of data bits  
dataLength = length(bits);
% byte count from data bits 
byteCount = dataLength/8;
% reshaping bits to byte wise 
bytes = reshape(bits, 8, byteCount)';
% initializing Output 
encoded = zeros(byteCount, 10);
runnigDisp = 0;
% importing Table of 8b10b encoding
Table_8b10b = csvread('Table_8b10b.csv');
%encoding from table
for i = 1:byteCount
    tmp = bi2de([bytes(i,:) runnigDisp])+1;
    val = Table_8b10b(tmp,:);
    runnigDisp = val(1);
    encoded(i,:) = flipdim(val(2:end),2);
end
% Reshaping Array to single bit Stream
encoded = reshape(encoded', 1, byteCount*10);
 
end
