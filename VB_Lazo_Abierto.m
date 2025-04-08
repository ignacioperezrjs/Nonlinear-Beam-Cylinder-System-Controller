
% Viga - cilindro
clear

y0=[0.1 0.1 0.1 0.1]; % condiciones iniciales
dt=0.001;  % periodo del sistema
k = 1;
tmax=1.0;  % tiempo maximo de la simulacion
% inicializacion variables de salida
I=0;
yt=zeros(fix(tmax/dt)+1,4);
tt=zeros(fix(tmax/dt)+1,1);



for t1=0:dt:tmax
    % integrador numerico
    [t,y]=ode23(@(t,y) VB_modelo(t,y,I),[t1 t1+dt],y0);
    
    % toma ultimo valor del vector
    yt(k,:)=y(max(size(y)),:);
    
    % toma ultimo valor tiempo simulado
    tt(k,:)=t(max(size(y)));
    
    % guarda valor de variables para inicio periodo siguiente
    y0=yt(k,:);
    
    % incrementa periodo
    k=k+1;
end
% dibuja respuesta de desplazamiento horizontal 
figure; plot(tt,yt(:,1)); xlabel('tiempo, segs'); ylabel('r(t), metros');
% dibuja derivada de respuesta de desplazamiento horizontal 
figure; plot(tt,yt(:,2)); xlabel('tiempo, segs'); ylabel('dr(t)/dt, metros');
% dibuja respuesta de angulo
figure; plot(tt,yt(:,3)*180/pi); xlabel('tiempo, segs'); ylabel('Theta, grados');  
% dibuja derivada respuesta de angulo
figure; plot(tt,yt(:,4)*180/pi); xlabel('tiempo, segs'); ylabel('d(Theta)/dt, grados');