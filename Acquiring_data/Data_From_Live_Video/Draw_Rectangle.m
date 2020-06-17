%Programa que dibuja un ractángulo sobre un video en vivo tomado por la
%webcam.
%Fecha: 12/06/20
%Autor: Nicolás Alejandro Ávila
%Descripción: Dibuja un ractángulo a través de los parámetros ya conocidos
%[xsupleft,ysupleft,width,height] sobre el video en vivo tomado por la
%webcam. 

function draw_rectangle(rectange)

%Inicia en video en vivo
vid = videoinput('winvideo');

%Se obtiene, a través de la resolución de la camara, el tamaño de la
%ventana a usar.
vidInfo = imaqhwinfo(vid);
vidRes = vid.VideoResolution;
imWidth = vidRes(1);
imHeight = vidRes(2);
numBands = vid.NumberOfBands;

%Se crea un objeto figura
hFig = figure;

%Crea un objeto con los ejes de la figura
hAxes = axes(hFig);

%Crea un objeto imagen, sobre el cual se dibujará el rectángulo y se
%mostrará el video. Más especificamente, crea una matriz de ceros con los
%tamaños antes obtenidos y con el tipo de datos del video.
hImage = image(hAxes, zeros(imHeight, imWidth, numBands, vidInfo.NativeDataType));

%Muestra el video sobre el objeto imagen
preview(vid, hImage);

%Dibuja el rectángulo
hLine = rectangle('Position', rectange, 'EdgeColor','r','LineWidth',2 );

end