imagen_s = edge(imagen_e,'Canny', threshold * fudgeFactor); 
imagen_h = imfill(imagen_s, 'holes');
%figure,imshow(imagen_h), title('Imagen usando canny'); 
imh=uint8(imagen_h);
u2=imh.*imagen;
%figure,imshow(u2), title('ImagenFinal'); 
axes(handles.axes2);
imshow (u2),title('DESPIGMENTACIÓN DETECTADA');
axes(handles.axes3); pp=imread('despigmentacion.png');
imshow (pp),title('IMAGEN REFERENCIAL');

%pixeles despigmentados
ro2=sum(sum(imh>0));%numero de pixeles	totales dentro del contorno
%
ro3=sum(sum(imagen_finall==1)); por=(ro2/ro3)*100; por=round(por,2);
texto=set(handles.edit2,'String',num2str(por)); 
if por>=30
    message='DESPIGMENTACIÓN CONSIDERABLE';
else
end
 
message='DESPIGMENTACIÓN DESPRECIABLE';
 
text=set(handles.edit4,'String',char(message));
