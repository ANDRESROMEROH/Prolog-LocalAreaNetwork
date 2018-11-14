% Universidad Nacional de Costa Rica
% Paradigmas de Programación
% Proyecto #3: Red de Área Local en Prolog
% Andrés Romero Hernández, 4-0230-0958.
% Estefanía Murillo Romero, 1-1700-0387.
% II Ciclo, 2018


% Definición del Grafo %

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

% VÉRTICES -> vertice(NodoSalida, NodoLlegada, Confianza, Velocidad)

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

% FIN Definición del Grafo...


% Predicados Auxiliares
% X -> Nodo Salida
% Y -> Nodo Llegada
% C -> Confianza
% V -> Velocidad
% D -> Dato de Entrada
% E -> Dato de Salida
conectados(X,Y):- %Predicado que verifica si 2 nodos estan conectados directamente
    vertice(X,Y,_,_) ; vertice(Y,X,_,_).

velocidad(X,Y,V):-
	vertice(X,Y,_,V).

confianza(X,Y,C):-
    vertice(X,Y,C,_).

aux(D,E):- ( is_list(D) -> E = D ; E = [D]). %Devuelve una lista en caso de que el elemento de entrada no lo sea.

primero([X|_],X). %Devuelve el primer elemento de una lista
% FIN Predicados Auxiliares...


%Predicados a Completar:

%conexión(A,B).
%Ejemplo #1: conexion(9,3). -> true.
%Ejemplo #2: conexion(1,6). -> true.
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
    

%conexión(A,B,Ruta).
%Ejemplo #1: conexion(9,6,Ruta). 
%Ejemplo #2: conexion(8,7,Ruta).
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

%velocidad_maxima(A,B,Ruta,V)
%Ejemplo #1: velocidad_maxima(9,6,[9,3,2,6],V). -> V=30.
%Ejemplo #2: velocidad_maxima(7,4,[7,3,1,4],V). -> V=40.
velocidad_maxima(A,B,Ruta,V):-
	vel(A,B,Ruta,Velocidades),
	min_list(Velocidades,V).

vel(A,B,[A,B],V):-
	velocidad(A,B,V).

vel(X,Y1,[_|LRuta],Velocidades):-
    primero(LRuta,Y2),
    conectados(X,Y2),           
    servidor(Y2),
    Y2 \== Y1,
    velocidad(X,Y2,V),
    vel(Y2,Y1,LRuta,V2),
    aux(V2,C),
    append([V],C,Velocidades).

%velocidad_maxima(A,B,V)
%Ejemplo #1: velocidad_maxima(8,6,V). -> V=10.
%Ejemplo #2: velocidad_maxima(5,9,V). -> V=30.
velocidad_maxima(A,B,V):-
    conectados(A,B),
    velocidad(A,B,V).

velocidad_maxima(A,B,V):-
    vel(A,B,V).

vel(A,B,Vel):-
    conexion(A,B,Ruta),
    velocidad_maxima(A,B,Ruta,Vel).

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