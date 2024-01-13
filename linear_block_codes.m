%program for linear block codes 
clc;
clear;
close all;
n=input("Enter the value of n:- ");
k=input("Enter the value of k:- ");
p=input("Enter the parity elements in the form of [values;values;values;....]:- ");
num_messages = 2^k; % for all the messages possible
all_messages = dec2bin(0:num_messages-1, k) - '0';% converting them to binary values 

%Generation of generator matrix 
g=[eye(k),p];%gives the value the generator matrix
disp("The genrator matrix is as follows:- ");
disp(g);%displays the generator matrix
table_data = zeros(num_messages, n);

% Encode each message and populate the table
for i = 1:num_messages
    msg = all_messages(i, :);
    encoded_msg = encode(msg, n, k, 'linear/binary', g);
    table_data(i, :) = encoded_msg;
end

% Display the table
disp('Message Bits   |   Encoded Code');
disp('--------------------------------');
for i = 1:num_messages
    fprintf('%s     | %s\n', num2str(all_messages(i, :)), num2str(table_data(i, :)));
end

%consider the linear block code defined as 
msg=input("Enter the message bits:- (!!The number of columns should be equal to k!!)"); %declaring the message bits
op=input("Choose the operation to be executed type[encode/decode]:- ",'s'); %a string is choose to by user
h=[p',eye(n-k)]; %calculation of parity check matrix
disp("Parity Check matrix:- ");
disp(h);
if strcmpi(op,'encode')
    code=encode(msg,n,k,'linear/binary',g);
    disp("The coded message:- (Linear Block code)");
    disp(code);
    %calculation of the coded messages in tabular form
    % Initialize a table to store the results

else

   %giving the received code in the form of bits 
    rec=input("Give the recieved code to check wheather it's errorless or not[!!introduce only one bit error!!]:- ");
    syt=mod(rec*h',2);
    if (syt == 0)
    disp("The code is errorless ")
    dec_msg=decode(rec,n,k,'linear/binary',g);%function required for decoding the received code
    disp("The decoded message is:- ");
    disp(dec_msg);
else
    disp("The code is having a error...");
    disp("The position where the error is present at this position");
    ep=find(ismember(h',syt,'rows')); %to find the error bit position
    disp(ep);
    c_matrix=zeros(1,n);
    c_matrix(ep)=1;
    disp("the error bits look like:-"); %generates the error bits
    disp(c_matrix);

    corrected_ep=mod(c_matrix+rec,2); %correction of the error bits
    disp("the corrected code is as follows:- ");
    disp(corrected_ep);
    dec_msg=decode(corrected_ep,n,k,'linear/binary',g); %the funciton for decoding the recieved code
    disp('The decoded message is:- ');
    disp(dec_msg);
    end
end
