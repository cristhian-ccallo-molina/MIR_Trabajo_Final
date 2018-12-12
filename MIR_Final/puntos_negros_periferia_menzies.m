u3=rgb2hsv(imj);
%seleccionamos el matiz 
h1=u3(:,:,1);
%COLOR NEGRO
% % Obtenemos la cantidad de pixeles negros de la lesión 0 
ne1=sum(sum(((h1>0.001)&(h1<0.02))));
ne2=sum(sum(h1>0));%numero de pixeles	totales dentro del contorno 
porne=(ne1/ne2)*100;
porne = round(porne,2); 
texto=set(handles.edit1,'String',num2str(porne)); 
axes(handles.axes3);
if porne>=7.9;
    message='EXISTE PRESENCIA DE PUNTOS NEGROS EN LA PERIFERIA';
else
end
 
message='NO EXISTE PRESENCIA DE PUNTOS NEGROS EN LA PERIFERIA';
 
pp=imread('puntosperiferia.png');
imshow (pp),title('IMAGEN REFERENCIAL'); 
text=set(handles.edit5,'String',char(message));

