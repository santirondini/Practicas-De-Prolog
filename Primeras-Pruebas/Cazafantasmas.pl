
% herramientasRequeridas ( Tarea , Herramientas requeridas )

herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).
herramientasRequeridas(trapear, [trapeador]).

% Ver lo de la lista. 

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(egon,trapeador).
tiene(winston,varita).
tiene(ray,_).

% 2)

satisface(Integrante,Herramienta):-
    tiene(Integrante,Herramienta). 

satisface(Integrante,aspiradora(Potencia)):-
    tiene(Integrante,aspiradora(X)),
    Potencia > X.

% 3)

puedeRealizar(Integrante,Tarea):-
    tiene(Integrante,varita).

puedeRealizar(Integrante,Tarea):-
    tiene(Integrante,_),
    herramientasRequeridas(Tarea,HerramientasNecesarias),
    satisface(Integrante,Herramienta),
    member(Herramienta,HerramientasNecesarias).

% 4)

tareaPedida(Cliente,Tarea,Metro^2).
precio(Tarea,PrecioPorMetro2).

calcularPrecioDeTarea(Tarea,Precio):-
    tareaPedida(_,Tarea,Metros2),
    precio(Tarea,PrecioPorMetro2),
    Precio is PrecioPorMetro2*Metros2.

% Un pedido es una lista de tareas

cuantoSale(Cliente,PrecioFinal):-
    tareaPedida(Cliente,_,_),
    findall(Precio,(tareaPedida(Cliente,Tarea,_),calcularPrecioDeTarea(Tarea,Precio)),Precios),
    sum_list(PrecioFinal,Precios). 

% 5) 

/* Tomo este formato como pedido; 

tareaPedida(Juan,Tarea1,Metro^2).
tareaPedida(Juan,Tarea2,Metro^2).
tareaPedida(Juan,Tarea3,Metro^2).
tareaPedida(Juan,Tarea4,Metro^2).

*/

acepta(peter,_).

acepta(ray,Cliente):-
    forall(tareaPedida(Cliente,Tarea,_), Tarea \=  limpiarTecho).

acepta(winston,Cliente):-
    cuantoSale(Cliente,PrecioFinal),
    PrecioFinal > 500.

tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramienta,CantidadDeHerramientas),
    CantidadDeHerramientas > 2.

tareaCompleja(limpiarTecho).

acepta(egon,Cliente):-
    tareaPedida(Cliente,Tarea,_),
    tareaCompleja(Tarea).

acepta(Persona,Cliente):-
    forall(tareaPedida(Cliente,Tarea,_),puedeRealizar(Persona,Tarea)),
    acepta(Persona,Cliente).

% 6) 

herramientaRemplazable(ordenarCuarto,escoba).
 
/* Deberíamos poner en todas las partes del código, que este tambien considere
las herramientas remplazables que pondriamos aca arriba. 




    








