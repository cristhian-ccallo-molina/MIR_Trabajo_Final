if poraz>=7.9
    f=1
else
    f=0
end
if porbl>=7.9
    e=1
else
    e=0
end
if porne>=7.9
    r=1
else
    r=0
end
if porro>=7.9
    n=1
else
    n=0
end
if pormo>=7.9
    a=1
else
    a=0
end
if pormc>=7.9
    d=1
else
    d=0
end
cuentacolor=f+e+r+n+a+d;
texto=set(handles.edit15,'String',num2str(cuentacolor));
if cuentacolor>3
    jk='MÚLTIPLES COLORES PRESENTES'
else
    
end
 

jk='COLOR NORMAL'
 
text2=set(handles.edit16,'String',char(jk));
