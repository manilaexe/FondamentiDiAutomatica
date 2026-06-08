%% Prova MATLAB Tipo A: script di avvio (da NON modificare, per la consegna
%  creare un proprio script con i comandi eseguiti man mano nello
%  svolgimento degli esercizi

% Inizializzazione parametri (altoparlante ad attrazione elettromagnetica)
m = 0.1;
b = 0.4;
Ke = 0.6;
R = 4;
L = 0.5;
Ka = 0.5;

% definizione matrici A,B,C,D
A=[-R/L 0 -Ka/L;0 0 1;Ka/m -Ke/m -b/m]
B=[1/L 0 0]'
C=[0 1 0]
D=0

%ESERCIZIO 1   
%trovare la funzione di trasferimento
sys=ss(A,B,C,D)
G=tf(sys)

%trovare i poli e conforntarli con gli autovalori
p=pole(G)

autovalori=eig(G)

%poli ed autovalori
%coincidono quindi il sistema è completamente osservabile e controlabile

%ESERCIZIO 2
%punto a
%Si determini il valore della costante K con il quale si otterrebbe 
% (se il sistema in retroazione con tale K risultasse asintoticamente 
% stabile) un errore a regime e(∞) = 0.05 per un ingresso a gradino unitario.

syms K
kp=K*dcgain(G)
ep=1/(1+kp)
K=solve(ep==0.05, K)
K=double(K)

%punto b
%Si verifichi se il sistema ad anello chiuso, con il valore di K ottenuto 
%al punto precedente,risulti o meno stabile tramite l'analisi della risposta
% y(t) al gradino unitario.

Gcl=feedback(G*K,1)
figure,step(Gcl)
%sistema instabile

%punto c
%Si determini il valore del guadagno Klim per il quale il sistema risulta 
% semplicemente stabile, tramite l'analisi del margine di ampiezza o 
% equivalentemente tramite l'analisi del luogo delle radici (NOTA: in 
% entrambi i casi l'analisi va svolta sulla funzione G(s)).

Klim=margin(G)

%punto d
%Si ponga K1 = 0.8 Klim, si visualizzi l'andamento della risposta al 
% gradino y(t) del sistema chiuso in retroazione con tale guadagno e se 
% ne determini il tempo d'assestamento al 5%.

K1=Klim*0.8
Gcl1=feedback(G*K1, 1)
popt=timeoptions
popt.SettleTimeThreshold=0.5
figure,step(Gcl1)
%sistema stabile
