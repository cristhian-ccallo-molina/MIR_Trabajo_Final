imagenf=nue.*imagen;
%figure, imshow(imagenf), title('global'); 
axes(handles.axes22);
imshow (imagenf),title('PUNTOS OSCUROS DETECTADOS');
 
numobj= bwconncomp(imagen_fi); 
number = numobj.NumObjects
texto=set(handles.edit1,'String',num2str(number)); 
if number>=12
    message='EXCESIVOS'
else
end
 
message='NORMALES'
 
text=set(handles.edit2,'String',char(message));

