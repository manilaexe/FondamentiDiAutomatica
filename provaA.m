%% Prova MATLAB Tipo A: script di avvio (da NON modificare, per la consegna
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
%si ricavi la fdt
sys=ss(A,B,C,D)
G=tf(sys)

%Si determinino i poli della funzione di trasferimento e si verifichi se
%coincidono con gli autovalori di A

p=pole(G)

autovalori=eig(A)
%poli e autovalori coincidono quindi il sistema è completamente osservabile
%e controllabile

%ESERCIZIO 2
%si determini il valore della costante K con il quale si otterrebbe un
%errore pari a 0.05 per un ingresso a gradino unitario

syms K
kp=K*dcgain(G)
ep=1/(1+kp)
K=solve(ep==0.05, K)
K=double(K)

%si verifichi se il sistema ad anello chiuso con il valore si K ottenuto
%nel punto precedente risulti o meno stabile tramite l'analisi della
%risposta y(t) al gradino unitario

Gcl=feedback(G*K,1)
figure,step(Gcl)
%sistema instabile

%Si determini il valore del guadagno di Klim per il quale il sistema
%risulta semplicemente stabile tramite l'analisi del margine di ampiezza o
%equivalentemente tramite l'analisi del luogo delle radici

Klim=margin(G)

%Si ponga K1=0.8Klim, si visualizzi l'andamento della risposta al graadino
%y(t) del sistema chiuso in retroazione con tale guadagno e se ne determini
%il tempo di assestamento al 5%

K1=Klim*0.8
Gcl1=feedback(G*K1,1)
figure,step(Gcl1)
