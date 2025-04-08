
% Viga - cilindro
clear
angulo = 0.0;
valor = (angulo/180)*pi;

dt=0.002;  % periodo del sistema
k = 1;
tmax=2.0;  % tiempo maximo de la simulacion
% inicializacion variables de salida
yt=zeros(fix(tmax/dt)+1,4);
tt=zeros(fix(tmax/dt)+1,1);


% Referencia
ref = 0.25;
pos_inicio = 0.35;
y0=[pos_inicio 0.0 valor 0.0]; % condiciones iniciales
% Valores necesarios para el error
err_ant_ant = 0;
err_ant = 0;
err = 0;

% Valores de los controladores
kp = 400;
ki = 100;
kd = 1.0;

%Valores con su delta tiempo correspondiente

ki_prima = ki*dt;
kd_prima = kd/dt;


% Retención de orden (hacer lo mismo del profe)
u = 0;
u_ant = 0;
I = 0;

for t1=0:dt:tmax
    
    % integrador numerico
    [t,y]=ode23(@(t,y) VB_modelo(t,y,I),[t1 t1+dt],y0);
    
    % toma ultimo valor del vector
    yt(k,:)=y(max(size(y)),:);
    
    % toma ultimo valor tiempo simulado
    tt(k,:)=t(max(size(y)));
    
    % guarda valor de variables para inicio periodo siguiente
    y0=yt(k,:);
    
    % Variables de suma importancia 
    err_ant_ant = err_ant;
    err_ant = err;
    u_ant = u;
    
    % La variable 1 es la posición
    err = -1*(ref-yt(k,1));
        
    T2 = (kp + ki_prima + kd_prima)*err;
    T3 = (kp + 2*kd_prima)*err_ant;
    T4 = kd_prima*err_ant_ant;
    u = u_ant + T2 - T3 + T4;
    if u>100, u = 100;
    elseif u<-100, u = -100;
    end
  
    I = u;

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