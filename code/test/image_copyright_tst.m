close all, clear all, clc;

%% Add path for source and image
addpath('../');
addpath('../../image/')
%% cat map
principle_of_dna = [65,67,71,84];
%% Image load
original_img = imread('lena.jpg');
if(length(size(original_img))>2)
    original_img = rgb2gray(original_img);
end
figure(1), subplot(3,2,1), imshow(original_img, []), title('orginal image');

logo_img = imread('cameraman.jpg');
if(length(size(logo_img))>2)
    logo_img = rgb2gray(logo_img);
end

figure(1),subplot(3,2,2), imshow(logo_img, []), title('Logo image');

%% Geberate key for original image
private_o_key = generate_key(original_img);
figure(1),subplot(3,2,3), imshow(private_o_key, []), title('private_key');

%% Geberate key for logo image
private_l_key = generate_key(logo_img);
figure(1),subplot(3,2,4), imshow(private_l_key, []), title('private_key');

%% Encrypted image
encrypted_o_img = encrypt_gray_image(original_img, private_o_key, principle_of_dna);
figure(1),subplot(3,2,5), imshow(encrypted_o_img, []), title('encrypted_original_image');

encrypted_l_img = encrypt_gray_image(logo_img, private_l_key, principle_of_dna);
figure(1),subplot(3,2,6), imshow(encrypted_l_img, []), title('encrypted_logo_image');

%% Water marked image
water_img = bitxor(encrypted_o_img, encrypted_l_img);
figure(2),subplot(2,2,1), imshow(water_img),title('Watermarked image')

%% Verification flow encryped original image, encryped watermark image, keys 
%%Remove water marked image
dwater_img = bitxor(encrypted_o_img, water_img);
figure(2),subplot(2,2,2), imshow(dwater_img),title('De-Watermarked image')

%% Decryped image
decrypted_o_img = decrypt_gray_image(encrypted_o_img, private_o_key, principle_of_dna);
figure(2),subplot(2,2,3) ,imshow(decrypted_o_img,[]), title('decrypted_original image');

decrypted_l_img = decrypt_gray_image(dwater_img, private_l_key, principle_of_dna);
figure(2),subplot(2,2,4) ,imshow(decrypted_l_img,[]), title('decrypted_logo image');
