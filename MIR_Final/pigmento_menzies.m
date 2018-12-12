
global imagen
imagen_g=rgb2gray(imagen);
G = fspecial('gaussian',20,5); 
imagen_ii = imfilter(imagen_g,G,255); 
imagen_b= ~im2bw(imagen_g);
imagen_e= bwareaopen(imagen_b,70);
[~, threshold] = edge(imagen_e, 'sobel'); 
fudgeFactor = .5;
imagen_s = edge(imagen_e,'sobel', threshold * fudgeFactor); 
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
se180 = strel('line', 3, 180);
se270 = strel('line', 3, 270);
%dilata la imagen
imagen_d = imdilate(imagen_s, [se270 se180 se90 se0]); 
imagen_h = imfill(imagen_d, 'holes');
imagen_b= imclearborder(imagen_h, 8); 
sd = strel('diamond',1);
%difumina la imagen
imagen_f = imerode(imagen_b,sd); 
imagen_final = imerode(imagen_f,sd); 
f1 = uint8 (imagen_final);
%realizo la multiplicación elemento a elemento u2=f1.*imagen;
imagen_c =edge(imagen_ii,'canny');
imagen_c=imdilate(imagen_c,[se270 se180 se90 se0]);
%cambio unos por ceros imagen_cc=~imagen_c;
f1 = uint8 (imagen_cc);
imagen_nueva=u2.*f1;
%para dilatar la imagen se = ones(1);
imagen_final= imdilate(imagen_nueva,se);
%%figure, imshow(imagen_final), title('filtro canny'); axes(handles.axes2);
imshow (imagen_final),title('RETÍCULOS DETECTADOS')
