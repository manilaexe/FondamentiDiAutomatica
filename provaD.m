%% Prova MATLAB Tipo D: script di avvio (da NON modificare!)
%  Per la consegnam creare un proprio script con i comandi eseguiti man 
%  mano nello svolgimento degli esercizi

% Inizializzazione parametri (sistema svolgitore-avvolgitore con "ballerino")
Lf=3;
Ef=9;
md=0.5;
Bd=2;
Kd=1.5;
R=0.2;
V1=3;

% Inizializzazione matrici A, B, C, D
A = [ -V1/Lf, -(2*Ef)/Lf,      0;
        2/md,     -Bd/md, -Kd/md;
           0,          1,      0]       
B = [ (Ef*R)/Lf; 0; 0]
C = [ 0   0   1]
D = 0

%ESERCIZIO 1
%Si ricavi la funzione di trasferimento

sys=ss(A,B,C,D)
G=tf(sys)

%si determinino i poli della fdt e si verifichi che coincidono con gli
%autovalori di A 

p=pole(G)
autovalori=eig(A)
%autovalori e poli cioncidono quindi il sitema è completamente
%controllabile e osservabile

%ESERCIZIO 2
%si determini il valore della costante K con il quale i otterrebbe un
%errore a regime di 0.02 per un ingresso a gradino unitario 

syms K;
kp=K*dcgain(G)
ep=1/(1+kp)
K=solve(ep==0.02, K);
K=double(K)

%Si verifichi se il sistema ad anello chiuso, con valore di K ottenuto al
%punto precedene risulti o meno stabile stramite l'analisi della risposta
%y(t) al gradino unitario 

Gcl=feedback(G*K,1)
figure,step(Gcl) %stabile di poco

%Si determini il valore del guadagno Klim per il quale il sistema risulta
%semplicemente stabile, tramite l'analisi del margine di ampiezza o
%equivalentemente tramite l'analisi el luogo delle radici

figure,margin(G)
Klim=db2mag(36)

%Si ponga K1=0.8Klim si visualizzi l'andamento della risposta al gradino
%y(t) del sistema chiuso in retroazione con tale guadagno e se ne determini
%il tempo di assestamento al 5%
K1=K*0.8
Gcl1=feedback(K1*G,1)
figure,step(Gcl1)
