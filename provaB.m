%% Prova MATLAB Tipo B: script di avvio (da NON modificare!)
%  Per la consegnam creare un proprio script con i comandi eseguiti man 
%  mano nello svolgimento degli esercizi

% Inizializzazione parametri (meccanismo di trasmissione del moto per robot
% collaborativo, es. Light-Weight Robot progettato dall'ente di ricerca
% tedesco DLR)
J1=0.1;
J2=0.1;
K=0.2;
b=0.08;
Km=50;
 
% definizione matrici A,B,C,D
A=[0 1 -1;-K/J1 -b/J1 b/J1;K/J2 b/J2 -b/J2]
B=[0;Km/J1;0]
C=[0 0 1]
D=0

%ESERCIZIO 1
%ricavo funzione di trasferimento
sys=ss(A,B,C,D)
G=tf(sys)

%poli
p=pole(G)

%autovalori
autovalori=eig(A)

%poli e autovalori coincidono quindi il sistema è semplicemente stabile e
%completamente osservabile

%ESERCIZIO 2

%risposta al gradino ad anello chiuso
K=1;
Gcl=feedback(K*G,1)
figure,step(Gcl) %sistema instabile

%valore di K limite per il quale il sistama risulta semplicemente stabile
figure,rlocus(G)

%dal grafico vedo 0,017
Klim=0.017

%pongo K1=0,8Klim e visualizzo la riposta al gradino del sistema chiuso in
%retroazione con tale guadagno e si determini il tempo di assestamento

K1=0.8*Klim
Gcl1=feedback(G*K1,1)
figure,step(Gcl1) %sistema stabile

%errore a regime
p=pole(K1*G)
