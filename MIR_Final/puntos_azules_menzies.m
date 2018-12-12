imag = uint8(imagen_fi);
 
imagf=imag.*imagen;
%figure, imshow(imagf), title('global'); 
axes(handles.axes2);
imshow (imagf),title('PUNTOS AZULES DETECTADOS'); 
u7=rgb2hsv(imagf);
%seleccionamos el matiz 
h7=u7(:,:,1);
% Obtenemos la cantidad de pixeles azules de la lesión 0.6 
az11=sum(sum(((h7>0.45)&(h7<0.75))));%azul (0.5 y 0.75) +- un margen 
az22=sum(sum(h7>0));%pixeles dentro del contorno 
porazu=(az11/az22)*100;
porazu=round(porazu); 
texto=set(handles.edit1,'String',num2str(porazu)); 
if porazu>=7.9;
    message='EXISTEN PUNTOS AZULES EN LA LESIÓN';
elseif porazu<7.9;
    message='NO EXISTEN PUNTOS AZULES EN LA LESIÓN';
end
text2=set(handles.edit3,'String',char(message));


