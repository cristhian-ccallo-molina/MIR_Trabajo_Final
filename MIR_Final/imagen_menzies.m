[FileName,PathName] = uigetfile('*.jpg'); 
global imagen
imagen = (imread([PathName '\' FileName])); 
axes(handles.axes1);
imshow (imagen),title('IMAGEN ORIGINAL'); 
axes(handles.axes); 
ppu=imread('reticular.png');
imshow (ppu),title('IMAGEN REFERENCIAL');