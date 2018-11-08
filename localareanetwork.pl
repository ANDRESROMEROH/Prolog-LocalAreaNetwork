% Definicion del Grafo %

%Servidores:
servidor(1).
servidor(2).
servidor(3).

%Clientes:
cliente(4).
cliente(5).
cliente(6).
cliente(7).
cliente(8).
cliente(9).

% VERTICES -> vertice(NodoSalida, NodoLlegada, Confianza, Velocidad, Tipo)

%Conexiones de 1:
vertice(1,2,0.99,20).
vertice(1,3,0.95,30).
vertice(1,4,0.99,20).
vertice(1,5,0.95,0.1).

%Conexiones de 2:
vertice(2,1,0.99,25).
vertice(2,3,0.98,40).
vertice(2,6,0.97,0.03).
vertice(2,7,0.95,0.02).

%Conexiones de 3:
vertice(3,1,0.95,30).
vertice(3,2,0.98,40).
vertice(3,7,0.90,0.04).
vertice(3,8,0.96,0.01).
vertice(3,9,0.98,0.03).

%Conexiones de 4:
vertice(4,1,0.99,20).

%Conexiones de 5:
vertice(5,1,0.95,0.1).

%Conexiones de 6:
vertice(6,2,0.97,0.03).

%Conexiones de 7:
vertice(7,2,0.95,0.02).
vertice(7,3,0.90,0.04).

%Conexiones de 8:
vertice(8,3,0.96,0.01).

%Conexiones de 9:
vertice(9,3,0.98,0.03).

% FIN Definicion del Grafo...


% Predicados Auxiliares

%Predicado que verifica si 2 nodos estan conectados
% X -> Nodo Salida
% Y -> Nodo Llegada
% C -> Confianza
% V -> Velocidad
conectados(X,Y,C,V):-
    vertice(X,Y,C,V) ; vertice(Y,X,C,V).

% FIN Predicados Auxiliares...


%Predicados a Completar:

%conexion(A,B).
%conexion(A,B,Ruta).
%velocidad_maxima(A,B,Ruta,V).
%velocidad_maxima(A,B,V).
%confiabilidad(A,B,Ruta,P).
