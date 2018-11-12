% Universidad Nacional de Costa Rica
% Paradigmas de Programacion
% Proyecto #3: Red de Are Local en Prolog
% Andres Romero Hernandez, 4-0230-0958.
% Estefania Murillo Romero, 1-1700-0387.


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

% VERTICES -> vertice(NodoSalida, NodoLlegada, Confianza, Velocidad)

%Conexiones de 1:
vertice(1,2,0.99,25000).
vertice(1,3,0.95,30000).
vertice(1,4,0.99,20000).
vertice(1,5,0.95,100).

%Conexiones de 2:
vertice(2,1,0.99,25000).
vertice(2,3,0.98,40000).
vertice(2,6,0.97,30).
vertice(2,7,0.95,20).

%Conexiones de 3:
vertice(3,1,0.95,30000).
vertice(3,2,0.98,40000).
vertice(3,7,0.90,40).
vertice(3,8,0.96,10).
vertice(3,9,0.98,30).

%Conexiones de 4:
vertice(4,1,0.99,20000).

%Conexiones de 5:
vertice(5,1,0.95,100).

%Conexiones de 6:
vertice(6,2,0.97,30).

%Conexiones de 7:
vertice(7,2,0.95,20).
vertice(7,3,0.90,40).

%Conexiones de 8:
vertice(8,3,0.96,10).

%Conexiones de 9:
vertice(9,3,0.98,30).

% FIN Definicion del Grafo...


% Predicados Auxiliares
% X -> Nodo Salida
% Y -> Nodo Llegada
% C -> Confianza
% V -> Velocidad
conectados(X,Y):- %Predicado que verifica si 2 nodos estan conectados directamente
    vertice(X,Y,_,_) ; vertice(Y,X,_,_).

velocidad(X,Y,V):-
	vertice(X,Y,_,V).

confianza(X,Y,C):-
    vertice(X,Y,C,_).

aux(X,C):- ( is_list(X) -> C = X ; C = [X]).

primero([X|_],X). %Devuelve el primer elemento de una lista
% FIN Predicados Auxiliares...


%Predicados a Completar:

%conexion(A,B).
conexion(X,Y):-
    visitar(X,Y,[X]).

visitar(X,Y,_) :- 
    conectados(X,Y).

visitar(X,Y1,Visitado):-
    conectados(X,Y2),           
    servidor(Y2),
    Y2 \== Y1,
    \+member(Y2,Visitado),
    visitar(Y2,Y1,[Y2|Visitado]). 
    

%conexion(A,B,Ruta).
conexion(X,Y,Ruta):-
    visitar(X,Y,[X],Inversa), 
    reverse(Inversa,Ruta).

visitar(X,Y,R,[Y|R]) :- 
    conectados(X,Y).

visitar(X,Y1,Visitado,Ruta):-
    conectados(X,Y2),           
    servidor(Y2),
    Y2 \== Y1,
    \+member(Y2,Visitado),
    visitar(Y2,Y1,[Y2|Visitado],Ruta).  



	
velocidad_maxima(A,B,Ruta,V):-
	vel(A,B,Ruta,Velocidades),
	min_list(Velocidades,V).
	

vel(A,B,[A,B],V):-
	velocidad(A,B,V).

% vel(A,B,[A,X|Xr],Velocidades):-
% 	member(B,Xr),
% 	velocidad(A,X,V1),
% 	append([V1],[Velocidades],Velocidades),
% 	vel(X,B,[X|Xr],Velocidades).

vel(X,Y1,[_|LRuta],Velocidades):-
    primero(LRuta,Y2),
    conectados(X,Y2),           
    servidor(Y2),
    Y2 \== Y1,
    velocidad(X,Y2,V),
    vel(Y2,Y1,LRuta,V2),
    aux(V2,C),
    append([V],C,Velocidades).


%velocidad_maxima(A,B,V).


% confiabilidad(A,B,Ruta,P).
% Ejemplo #1: confiabilidad(9,5,[9,3,1,5],C). -> C = 0.88445 .
% Ejemplo #2: confiabilidad(9,6,[9,3,2,6],C). -> C = 0.931588 .

confiabilidad(X,Y,Ruta,P):-
    c2(X,Y,Ruta,P).

c2(X,Y,[X,Y],P) :- 
    vertice(X,Y,P,_).

c2(X,Y1,[_|LRuta],Confianza):-
    primero(LRuta,Y2),
    conectados(X,Y2),           
    servidor(Y2),
    Y2 \== Y1,
    confianza(X,Y2,C4),
    c2(Y2,Y1,LRuta,C3),
    Confianza is C4 * C3.