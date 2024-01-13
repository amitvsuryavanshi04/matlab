clc;
clear;
close all;
disp("Hello this is am custom matlab code for the generation of the linear");
disp(" block where the encoded messages are encoded using an customized function");
disp("I hereby request to just have a look on it and just make any improvements by mentioning it on your name on that line as comment.");
disp("Please share this code to needy and increase my views on github...");

n=input("Enter the value of n:- ");
k=input("Enter the value of k:- ");
p=input("Enter the parity elements in the form of [values;values;values;....]:- ");
% Generate the generator matrix
g = [eye(k), p];

% Generate all possible message bit combinations
num_msg = 2^k;
all_msg = dec2bin(0:num_msg-1, k) - '0';

% Initialize a table to store the results
table_data = zeros(num_msg, n);

% Encode each message and populate the table
for i = 1:num_msg
    msg = all_msg(i, :);
    encoded_msg = linear_custom(msg, g);
    table_data(i, :) = encoded_msg;
end

% Display the table
disp('Message Bits   |   Encoded Code');
disp('--------------------------------');
for i = 1:num_msg
    fprintf('%s              |   %s\n', num2str(all_msg(i, :)), num2str(table_data(i, :)));
end

function enc_code = linear_custom(msg, g)%custom function called linear_custom is used 
    % Check if the size of the message is compatible with the generator matrix
    [k, n] = size(g);
    if length(msg) ~= k
        error('Invalid message size.');
    end
    
    % Perform linear block code encoding
    parity_check_bits = mod(msg * g(:, k+1:end), 2);
    enc_code = [msg, parity_check_bits];
end
