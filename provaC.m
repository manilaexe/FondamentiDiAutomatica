%% Prova MATLAB Tipo C: script di avvio (da NON modificare!)
%  Per la consegnam creare un proprio script con i comandi eseguiti man 
%  mano nello svolgimento degli esercizi

% definizione matrici A,B,C,D per il modello della dinamica dell'angolo di
% pitch di un aereo (v. https://ctms.engin.umich.edu )
A=[-0.3 50 0;-0.1 -0.4 0; 0 50 0]
B=[0.2 0.1 0]'
C=[0 0 1]
D=0

%ESERCIZIO 1
%funzione di trasferimento
sys=ss(A,B,C,D)
G=tf(sys)

%poli della funzione
p=pole(G)

%autovalori della funzione
autovalori=eig(A)

%poli e autovalori coincidono quindi il sistema è completamente osservabile
%e controllabile

%ESERCIZIO 2
%si verifichi il sistema ad anello chiuso con guadagno K=1 risulti o meno
%stabile con l'analisi della risposta y(t) al gradino 

s=tf('s')
H=(1/(1+(s/50)))
Gcl=feedback(G,H)
figure,step(Gcl)

%Valore del guadagno Klim per il quale il sistema risulta semplicemente
%stabile tramite n'analisi del margine di impiezza o tramite l'analisi del
%luogo delle radici 
L=G*H
Klim=margin(L)

%si ponga K1=0.8Klim si visualizzi l'andamento della risposta al gradino
%del sistema chiuso in retroazione con tale guadagno e si determini il
%tempo di assestamento al 5%
K1=0.8*Klim
Gcl1=feedback(G*K1,1)
Popt=timeoptions;
Popt.SettleTimeThreshold=0.05;
figure,step(Gcl1,Popt)

%Si determni l'errore a regime motivandone il valore tramite le righe di
%commento

%il valore è uguale a 1 quindi l'errore a regime è nullo 
