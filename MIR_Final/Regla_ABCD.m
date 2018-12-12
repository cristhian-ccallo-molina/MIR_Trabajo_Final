[FileName,PathName] = uigetfile('*.png');
global imagen
%  global C2
%  global B2
imagen = (imread([PathName '\' FileName])); 
axes(handles.imagenoriginal);
imshow (imagen),title('IMAGEN ORIGINAL');
set(imagenoriginal,'toolbar','figure');
set(imagenoriginal,'menubar','figure');
if isempty(x)
    diametroreferencial=1.5;
elseif y<=3; 
    diametroreferencial=0;
elseif (y>3)&&(y<6);
    diametroreferencial=1.5;
elseif y>=6
    diametroreferencial=2.5;
end
%pasar a escala de grises%
RGB2 = imadjust(imagen,[0.3 0.7],[]);
imagen_g=rgb2gray(imagen);
% convertir imagen a binaria (negro y blanco) 
imagen_b= ~im2bw(imagen_g); 
tam=size(imagen_b);
tama=tam(1)*tam(2);
if tama<=2000
    %elimina objetos con menos de 20 pixeles 
    imagen_e= bwareaopen(imagen_b,20);
else
    imagen_e= bwareaopen(imagen_b,70);
end
numtot=find(imagen_b==1);
numtotal=size(numtot);
tam=size(imagen_b);
if tam(1)>=tam(2);
    a=tam(1);
else
    a =tam(2);
end
[~, threshold] = edge(imagen_e, 'sobel');
%factor de ajuste del umbral 
fudgeFactor = .5;
% Primero, usamos edge y el operador Sobel para calcular el valor umbral. 
imagen_s = edge(imagen_e,'sobel', threshold * fudgeFactor);
%Permite añadir puntos a un objeto en los pixeles que tocan el borde en
%una imagen binaria, aumentando la definición de la imagen 
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
se180 = strel('line', 3, 180);
se270 = strel('line', 3, 270);
%dilata la imagen
imagen_d = imdilate(imagen_s, [se270 se180 se90 se0]);
%rellena los vacíos de la matriz binaria 
imagen_h = imfill(imagen_d, 'holes');
%suprime las estructuras que son más livianas que sus alrededores 
imagen_b= imclearborder(imagen_h, 8);
sd = strel('diamond',1);
%difumina la imagen
imagen_f = imerode(imagen_b,sd);
imagen_final = imerode(imagen_f,sd);
axes(handles.imagen_binaria);
imshow (imagen_final),title('IMAGEN BINARIA');
%traza un borde en los huecos de las imágenes
[B, ~] = bwboundaries(imagen_final,'holes');
%permite encontrar el centro de la figura, area y perimetro 
stats = regionprops(imagen_final,'Area','Centroid','Perimeter');
%perimetro = stats.Perimeter;
[centro]= stats.Centroid;
%redondear los pixeles 
C2=round(centro);
%convierto la celda a matriz 
B2=cell2mat(B);
%muestra el perímetro de una imagen binaria, 1 contorno, 0 el resto 
imagen_p =  bwperim(imagen_final); 
imagen_p=imdilate(imagen_p,[se270 se180 se90 se0]);
salida = imagen; 
salida(imagen_p) = 255;
axes(handles.imagendetectada);
imshow (salida),title('IMAGEN DETECTADA');
%bordes de la lesión en pixeles 
B2=cell2mat(B);
%Ubicación de los pixeles que coinciden con el eje
[filay,columnay] = find(B2(:,1) == C2(2));
%coordenadas en en y iguales pero diferentes en x 
ubiy=[filay,columnay];
%tamaño de valores enconttrasos en filas 
tamy=length(ubiy);
%recuperación de los valores en x de los extremos der e izq en x
for i=1:tamy
    s = ubiy(i,1); 
    z(i)= B2([s],[2]);
end
xder = max(z); 
xizq = min(z);
%UBICACIÓN DE PIXEL EN X
[filax,columnax] = find(B2(:,2) == C2(1));
%coordenadas en en x iguales pero diferentes en y 
ubix=[filax,columnax];
%tamaño de valores enconttrasos en filas 
tamx=length (ubix);
%%recuperación de los valores en y de los extremos arriba y abajo
for j=1:tamx
    t= ubix(j,1); 
    w(j)= B2([t],[1]);
end
yarri = max(w); 
yabaj = min(w);
%calculo de la variación en pixeles de los lados der e izq 
vder=xder-C2(1);
vizq=C2(1)-xizq;
varx = abs(vder-vizq);
%calculo de la variación en pixeles de los lados arriba y abajo 
varri=yarri-C2(2);
varabaj=C2(2)-yabaj;
vary = abs(varri-varabaj); 
media=0.0002*tama; 
mediax=round(0.12*tam(1)); 
mediay=round(0.21*tam(2));
if abs(varx - vary) <=	media
    puntos=0;
elseif (varx==mediax)|(vary ==mediax)
    puntos=1.3;
elseif (varx==mediay)|(vary ==mediay)
    puntos=1.3;
else
    puntos=2.6;
end
%COLOR DE LA LESIÓN
f1 = uint8(imagen_final);
%realizo la multiplicación elemento a elemento 
u2=f1.*imagen;
u3=rgb2hsv(u2);
%seleccionamos el matiz 
h1=u3(:,:,1);
% Obtenemos la cantidad de pixeles azules de la lesión 0.6 
az1=sum(sum(((h1>0.45)&(h1<0.75))));
%azul (0.5 y 0.75) +- un margen 
az2=sum(sum(h1>0));
%pixeles dentro del contorno 
poraz=(az1/az2)*100;
poraz=round(poraz); 
if poraz<=37.2
    puntoaz=1*0.5; 
else
    puntoaz=0
end
bl1=sum(sum(((h1>0.001)&(h1<0.02))));
bl2=sum(sum(h1>0));
%numero de pixeles	totales dentro del contorno 
porbl=(bl1/bl2)*100;
porbl=round(porbl);
if porbl<=37.2
    puntobl=1*0.5;
else
    puntobl=0;
end
ne1=sum(sum(((h1>0.9)&(h1<1))));
ne2=sum(sum(h1>0));
%numero de pixeles	totales dentro del contorno 
porne=(ne1/ne2)*100;
porne=round(porne);
if porne<=37.2
    puntone=1*0.5;
else
    puntone=0;
end
ro1=sum(sum(((h1>=0.02)&(h1<0.05))));
%rojo (0 y 0.05) +- un margen 
ro2=sum(sum(h1>0));
%numero de pixeles totales dentro del contorno 
porro=(ro1/ro2)*100;
porro=round(porro);
if porro<=37.2
    puntoro=1*0.5;
else
    puntoro=0;
end
mo1=sum(sum(um(((h1>=0.1)&(h1<0.2)))));
mc2=sum(sum(h1>0));
%numero de pixeles	totales dentro del contorno 
pormc=(mc1/mc2)*100;
pormc=round(pormc);
if pormc<=37.2
    puntomc=1*0.5;
else
    puntomc=0;
end
puntocolor = puntoaz+puntoro+puntone+puntobl+puntomc+puntomo;
% Calculo del diámetro
global yarri
global C2
global B2
global yabaj
global xder
global xizq
diametroy=yarri-yabaj;
diametrox=xder-xizq;
if diametroy >= diametrox;
    diametro= round(diametroy);
elseif diametroy <= diametrox;
    diametro = round(diametrox);
else
    diametro = round(diametrox);
end
%diámetros en los ejes 
radio=(diametroy+diametrox)/4;
%BORDE DE LA LESIÓN
perimetro= stats.Perimeter;
C2=round(centro);
%%%%%%%%%%%%eje 3 y eje 7%%%%%%%%%%%%
[filay,columnay] = find(B2(:,1) == C2(2));
%coordenadas en en y iguales pero diferentes en x
ubiy=[filay,columnay];
%tamaño de valores enconttrasos en filas 
tamy=length(ubiy);
%recuperación de los valores en x de los extremos der e izq en x
for i=1:tamy
    s = ubiy(i,1); 
    z(i)= B2([s],[2]);
end
yarri = max(z); yabaj = min(z);
varri=yarri-C2(2);
varabaj=C2(2)-yabaj;
vary = abs(varri-varabaj);
% % % %%%%%%%%%%%%%%%%%%%%% eje 1 y eje 5%%%%%%%%%%%%%%%
[filax,columnax] = find(B2(:,2) == C2(1));
%coordenadas en en x iguales pero diferentes en y 
ubix=[filax,columnax];
%tamaño de valores enconttrasos en filas 
tamx=length (ubix);
%%recuperación de los valores en y de los extremos arriba y
for j=1:tamx;
    t= ubix(j,1); 
    w(j)= B2([t],[1]);
end
xder=max(w);
xizq=min(w);
vder=xder-C2(1);
vizq=C2(1)-xizq;
varx = abs(vder-vizq);
for m=1:a;
    t25= C2(1)+m; 
    t26= C2(2)+m;
    dp21= find(B2(:,2)==t26 &B2(:,1)==t25 );
    dp21y= B2([dp21],[1]);
    dp21x= B2([dp21],[2]);
    eje2=[dp21x dp21y]; 
    q1=isempty(dp21);
    if q1== 1;%%% esta vacía
    else
        break
    end
end
if q1== 1;%%% esta vacía
    radio2 = round(perimetro/6.28);
else
    radio2=round(hypot(dp21x,dp21y));
end

for k = 1:a;
    t255= C2(1)-k; 
    t266= C2(2)+k;
    dp211= find(B2(:,2)==t266 &B2(:,1)==t255 );
    dp211y= B2([dp211],[1]);
    dp211x= B2([dp211],[2]);
    eje4=[dp211x dp211y]; 
    q11=isempty(dp211);
    if q11== 1;%%% esta vacía
    
    else
        break
    end
end
if q11== 1;%%% esta vacía
    radio4 = round(perimetro/6.28);
else
    radio4=round(hypot(dp211x,dp211y));
end
for k1 = 1:a;
    t55= C2(1)-k1;
    t66= C2(2)-k1;
    dp11= find(B2(:,2)==t66 &B2(:,1)==t55 );
    dp11y= B2([dp11],[1]);
    dp11x= B2([dp11],[2]);
    eje6=[dp11x dp11y];
    q6=isempty(dp11);
    
    if q6== 1;%%% esta vacía
        
    else
        break
    end
end

if q6== 1;%%% esta vacía
    radio6 = round(perimetro/6.28);
else
    radio6=round(hypot(dp11x,dp11y));
end

for k11 = 1:a;
    t555= C2(1)+k11; t666= C2(2)-k11;
    dp22= find(B2(:,2)==t666 &B2(:,1)==t555 );
    dp2y= B2([dp22],[1]);
    dp2x= B2([dp22],[2]);
    eje6=[dp2x dp2y]; 
    q2=isempty(dp22);
    if q2== 1;%%% esta vacía
        
    else
        break
    end
end
if q2== 1;%%% esta vacía
    radio8 = round(perimetro/6.28);
else
    radio8=round(hypot(dp2x,dp2y));
end
%%%%%%%%%%%%%%%%%MEDIA%%%%%%%%%%%%%%%%%
%tolerancia de radio teórica 
tolerancia=round(0.009*numtotal(1));
if vder<=tolerancia;
    punto1=0;
    
else
    punto1=0.1;
end

if radio2<=tolerancia;
    punto2=0;
else
    punto2=0.1;
end

if varri<=tolerancia;
    punto3=0;
    
else
    punto3=0.1;
end

if radio4<=tolerancia;
    punto4=0;
    
else
    punto4=0.1;
end

if vizq<=tolerancia;
    punto5=0;
    
else
    punto5=0.1;
end

if radio6<=tolerancia;
    punto6=0;
else
    punto6=0.1;
end

if varabaj<=tolerancia;
    punto7=0;
else
    punto7=0.1;
end

if radio8<=tolerancia;
    punto8=0;
else
    punto8=0.1;
end

puntob=punto1+punto2+punto3+punto4+punto5+punto6+punto7+punto8;
puntob=punto1+punto2+punto3+punto4+punto5+punto6+punto7+punto8;
%%%%%%%PUNTAJE%%%%%%%%%%%%%
ABCD=puntos+puntob+puntocolor+diametroreferencial;
if ABCD<4.75
    total='BENIGNO';
elseif (ABCD>=4.75&&ABCD<=5.45)
    total='LESIÓN SOSPECHOSA:REQUIERE SEGUIMIENTO';
elseif ABCD>5.45
    total='MELANOMA';
end
texto=set(handles.edit4,'String',num2str(ABCD));
text=set(handles.edit5,'String',char(total));
%%%%%%RECOMENDACION%%%%%%%
if puntos==2.6;
    recomens='A: Simetría Sospechosa - '; 
else
    recomens='A:Simetría Normal - ';
end
%puntob [0-0.8]
if puntob>=0.6;
    recomenb='B:Borde Sospechoso - ';
else
    recomenb='B: Borde Normal - ';
end
%puntob [0-3]
if puntocolor>=2;
    recomenc='C:Color Sospechoso';
else
    recomenc='C: Color Normal';
end
recomenf=[recomens recomenb recomenc];
text=set(handles.recomendacion,'String',char(recomenf));
clear diametroreferencial
clear y
