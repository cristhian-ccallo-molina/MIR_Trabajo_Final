imagenf=nue.*imagen;
%figure, imshow(imagenf), title('global'); 
numobj= bwconncomp(imagen_fi);
number	= numobj.NumObjects 
f1 = uint8 (imagen_final);
%realizo la multiplicación elemento a elemento 
u2=f1.*imagen;
%figure, imshow(u2), title('multiplicacion'); 
u3=rgb2hsv(u2);
%seleccionamos el matiz 
h1=u3(:,:,1);
az1=sum(sum(((h1>0.45)&(h1<0.75))));%azul (0.5 y 0.75) +- un margen 
az2=sum(sum(h1>0));%pixeles dentro del contorno 
poraz=(az1/az2)*100;
poraz=round(poraz)
%COLOR BLANCO
% % Obtenemos la cantidad de pixeles negros de la lesión 0 
bl1=sum(sum(((h1>0.001)&(h1<0.02))));
bl2=sum(sum(h1>0));%numero de pixeles	totales dentro del contorno 
porbl=(bl1/bl2)*100;
porbl=round(porbl)
%COLOR NEGRO
% % Obtenemos la cantidad de pixeles BLANCO de la lesión 1 
ne1=sum(sum(((h1>0.9)&(h1<1))));
ne2=sum(sum(h1>0));%numero de pixeles	totales dentro del contorno 
porne=(ne1/ne2)*100;
porne=round(porne)
%COLOR ROJO
% % Obtenemos la cantidad de pixeles rojos de la lesión 
ro1=sum(sum(((h1>=0.02)&(h1<0.05))));%rojo (0 y 0.05) +- un margen 
ro2=sum(sum(h1>0));%numero de pixeles	totales dentro del contorno 
porro=(ro1/ro2)*100;
porro=round(porro)
%COLOR MARRÓN OSCURO
% % Obtenemos la cantidad de pixeles MARRON OSCURO de la lesión 
mo1=sum(sum(((h1>=0.05)&(h1<0.1))));
mo2=sum(sum(h1>0));%numero de pixeles	totales dentro del contorno 
pormo=(mo1/mo2)*100;
pormo=round(pormo);
%COLOR MARRÓN CLARO
% % Obtenemos la cantidad de pixeles MARRON OSCURO de la lesión 
mc1=sum(sum(((h1>=0.1)&(h1<0.2))));
mc2=sum(sum(h1>0));%numero de pixeles	totales dentro del contorno 
pormc=(mc1/mc2)*100;
pormc=round(pormc);

%%%%%%%%%%%%%%%%%%%COLORES MULTIPLES%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if poraz>0
    f=1;
else
    f=0;
end
if porbl>0
    e=1;
else
    e=0; 
end
 
if porne>0
    r=1;
else
    r=0; 
end
if porro>0
    n=1;
else
    n=0;
end
if pormo>0
    a=1;
else
    a=0;
end
if pormc>0
    d=1;
else
    d=0; 
end
cuentacolor=f+e+r+n+a+d; 
if cuentacolor>3
    jk='MÚLTIPLES COLORES'
else
end
 
jk='COLOR UNIFORME'
 
texto=set(handles.edit1,'String',num2str(jk));
