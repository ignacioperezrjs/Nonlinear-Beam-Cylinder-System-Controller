
% Viga - cilindro
clear


dt=0.002;  % periodo del sistema
k = 1;
tmax=200.0;  % tiempo maximo de la simulacion
% inicializacion variables de salida
yt=zeros(fix(tmax/dt)+1,4);
tt=zeros(fix(tmax/dt)+1,1);



%Valores iniciales 
angulo = 6;
valor = (angulo/180)*pi;

velocidad = 0.001;% en debe ser del orden de 0.01

velocidad_angular = -4;
valor_vel_ang = (velocidad_angular*pi)/180;

ref = 0.0;
pos_inicio = 0.3;
y0=[pos_inicio -0.04 valor valor_vel_ang]; % condiciones iniciales

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% VARIABLES CONTROLADOR ANGULAR %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Valores necesarios para el error
err_ant_ant = 0;
err_ant = 0;
err = 0;

% Valores de los controladores
kp = 6000;
ki = 1000;
kd = 200;

%Valores con su delta tiempo correspondiente

ki_prima = ki*dt;
kd_prima = kd/dt;


% Retención de orden (hacer lo mismo del profe)
u = 0;
u_ant = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% VARIABLES CONTROLADOR POSICIÓN %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pos_err_ant2 = 0;
pos_err_ant = 0;
pos_err = 0;

% Valores de los controladores
pos_kp = 3000;
pos_ki = 250;
pos_kd = 2000;

%Valores con su delta tiempo correspondiente

pos_ki_prima = pos_ki*dt;
pos_kd_prima = pos_kd/dt;

% Valores de U
pos_u = 0;
pos_u_ant = 0;

%pos_ref = 0.41;

I = 0;

for t1=0:dt:tmax
 
    if t1<30, pos_ref = 0.1;
    elseif t1<60, pos_ref = 0.2;
    elseif t1<90, pos_ref = 0.3;
    elseif t1<100, pos_ref = 0.4;
    end
    
    % integrador numerico
    [t,y]=ode23(@(t,y) VB_modelo(t,y,I),[t1 t1+dt],y0);
    
    % toma ultimo valor del vector
    yt(k,:)=y(max(size(y)),:);
    
    % toma ultimo valor tiempo simulado
    tt(k,:)=t(max(size(y)));
    
    % guarda valor de variables para inicio periodo siguiente
    y0=yt(k,:);
    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Flujo CONTROLADOR Angular %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    err_ant_ant = err_ant;
    err_ant = err;
    u_ant = u;
    
    % La variable 1 es la posición
    err = (ref-yt(k,3));
        
    T2 = (kp + ki_prima + kd_prima)*err;
    T3 = (kp + 2*kd_prima)*err_ant;
    T4 = kd_prima*err_ant_ant;
    u = u_ant + T2 - T3 + T4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Flujo CONTROLADOR posición %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pos_err_ant2 = pos_err_ant;
    pos_err_ant = pos_err;
    pos_u_ant = pos_u;
    
    % El error respecto a la posición
    pos_err = (yt(k,1)-pos_ref);
    
    pos_T2 = (pos_kp + pos_ki_prima + pos_kd_prima)*pos_err;
    pos_T3 = (pos_kp + 2*pos_kd_prima)*pos_err_ant;
    pos_T4 = (pos_kd_prima)*pos_err_ant2;
    pos_u = pos_u_ant + pos_T2 - pos_T3 + pos_T4;
    % El valor asignado a la corriente por ambos controladores
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Juntamos ambos controladores %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %if u>200, u = 200;
    %elseif u<-200, u = -200;
    %end
    %if pos_u>200, pos_u = 200;
    %elseif pos_u<-200, pos_u = -200;
    %end

    u_final = u + pos_u;
    if u_final>100, u_final = 100;
    elseif u_final<-100, u_final = -100;
    end
    I = u_final;

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