function f_img = feat_ext(A)
%% Feature extraction
[dwt_img] = dwt2(A, 'sym4');
[dwt_img] = dwt2(dwt_img, 'sym4');

%% binarization by SVD
A = dwt_img;

B = padarray(A,[1 1]);
[m, n] = size(B);
for i = 2:m-1
    for j = 2:n-1
        [~,s,~] = svd(B(i-1:i+1,j-1:j+1));
        arr = reshape(s, [1 numel(s)]); %convert to 1-D array
        A(i-1,j-1) = mod(round(max(arr)), 2);  %if even set zero, else if odd, 1 
    end
end
f_img = uint8(A);
end
