%%%%%%PERFIL MEDIO%%%%%
%SIMETR�A PERFECTA, SIMETR�A EN UN SOLO EJE, SIN SIMETR�A
tam=size(imagen_b); 
tama=tam(1)*tam(2); 
media=0.0002*tama; 
mediax=round(0.12*tam(1));
mediay=round(0.21*tam(2));
if abs(varx - vary) <=	media 
    puntos='SIMETR�A';
elseif (varx==mediax)|(vary ==mediax)
    puntos='SIMETR�A EN UN EJE';
elseif (varx==mediay)|(vary ==mediay)
    puntos='SIMETR�A EN UN EJE';
else
    puntos='ASIMETR�A'; 
end
text=set(handles.edit1,'String',char(puntos));
