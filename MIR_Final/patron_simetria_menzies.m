%%%%%%PERFIL MEDIO%%%%%
%SIMETRÍA PERFECTA, SIMETRÍA EN UN SOLO EJE, SIN SIMETRÍA
tam=size(imagen_b); 
tama=tam(1)*tam(2); 
media=0.0002*tama; 
mediax=round(0.12*tam(1));
mediay=round(0.21*tam(2));
if abs(varx - vary) <=	media 
    puntos='SIMETRÍA';
elseif (varx==mediax)|(vary ==mediax)
    puntos='SIMETRÍA EN UN EJE';
elseif (varx==mediay)|(vary ==mediay)
    puntos='SIMETRÍA EN UN EJE';
else
    puntos='ASIMETRÍA'; 
end
text=set(handles.edit1,'String',char(puntos));
