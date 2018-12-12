u3=rgb2hsv(u2);
%seleccionamos el matiz h1=u3(:,:,1);
s1=u3(:,:,2);
v1=u3(:,:,3);
% Obtenemos la cantidad de pixeles azules de la lesión 0.6
azh1=sum(sum(((h1>0.065)&(h1<0.483))));%azul (0.5 y 0.75) +- un margen 
azh2=sum(sum(h1>0));%pixeles dentro del contorno 
porhaz=(azh1/azh2)*100
% Obtenemos la cantidad de pixeles azules de la lesión 0.6 
azs1=sum(sum(((s1>0.08)&(s1<0.494))));%azul (0.5 y 0.75) +- un margen 
azs2=sum(sum(s1>0));%pixeles dentro del contorno 
porsaz=(azs1/azs2)*100
% Obtenemos la cantidad de pixeles azules de la lesión 0.6 
azv1=sum(sum(((v1>0.231)&(v1<0.404))));%azul (0.5 y 0.75) +- un margen 
azv2=sum(sum(v1>0));%pixeles dentro del contorno 
porvaz=(azv1/azv2)*100
promedio= (porhaz+porsaz+porvaz)/3; 
promedio=round(promedio,2); 
text=set(handles.edit2,'String',num2str(promedio)); 
if promedio >=37.2;
    message='PRESENTE'; 
else
    message='AUSENTE'; 
end
text2=set(handles.edit4,'String',char(message));
