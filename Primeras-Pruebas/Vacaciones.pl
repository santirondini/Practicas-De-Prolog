
seVa(dodain,pehuenia).
seVa(dodain,sanMartin).
seVa(dodain,esquel).
seVa(dodain,sarmiento).
seVa(dodain,camarones).
seVa(dodain,playasDoradas).

seVa(alf,bariloche).
seVa(alf,sanMartin).
seVa(alf,elBolson).

seVa(santino,esquel).

seVa(nico,marDelPlata).

seVa(vale,calafate).
seVa(vale,bolson).

seVa(martu,Lugar):-
    seVa(alf,Lugar),
    seVa(nico,Lugar).

% atraccion(parqueNacional(nombre)).
% atraccion(cerro(nombre,altura)).
% atraccion(cuerpoDeAgua(nombre,pescarOno,temperaturaPromedio)).
% atraccion(playa(nombre,diferencia)).
% atraccion(excursion(nombre,altura)).

atraccion(esquel,parqueNacional(losAlerces)).
atraccion(esquel,excursion(trochita)).
atraccion(esquel,excursion(trevelin)).

atraccion(pehuenia,cerro(bateaMaguida,2000)).     
atraccion(pehuenia,cuerpoDeAgua(moquehue,si,14)).
atraccion(pehuenia,cuerpoDeAgua(alumine,si,19)).

cumpleCondiciones(Atraccion):-
    atraccion(_,cerro(Atraccion,Altura)), 
    Altura > 2000.

cumpleCondiciones(Atraccion):- 
    atraccion(_,cuerpoDeAgua(Atraccion,si,Temperatura)),
    Temperatura > 20.

cumpleCondiciones(Atraccion):-
    atraccion(_,playa(Atraccion,Diferencia)),
    Diferencia =< 5.

cumpleCondiciones(Atraccion):-
    atraccion(_,excursion(Atraccion,_)),
    atom_length(Atraccion, Length),
    Length > 7.

esCopada(parqueNacional(_)).

esCopada(Atraccion):-
    cumpleCondiciones(Atraccion).

tieneAtraccionCopada(Lugar):-
    atraccion(Lugar,Atraccion),
    esCopada(Atraccion).

vacacionesCopadas(Persona):-
    seVa(Persona,_),
    findall(Lugar,seVa(Persona,Lugar),Lugares),
    forall(member(Lugar,Lugares),tieneAtraccionCopada(Lugar)).

seCruzaron(Persona1,Persona2):-
    seVa(Persona1,Lugar),
    seVa(Persona2,Lugar),
    Persona1 \= Persona2.

noSeCruzaron(Persona1,Persona2):-
    seVa(Persona1,_),
    seVa(Persona2,_),
    Persona1 \= Persona2.
    not(seCruzaron(Persona1,Persona2)).

costoDeVida(sarmiento,100).
costoDeVida(esquel,150).
costoDeVida(pehuenia,180).
costoDeVida(sanMartin,150).
costoDeVida(camarones,135).
costoDeVida(playasDoradas,170).
costoDeVida(bariloche,140).
costoDeVida(calafate,240).
costoDeVida(elBolson,145).
costoDeVida(marDelPlata,140).

esGasolero(Lugar):-
    costoDeVida(Lugar,Costo),
    Costo < 160.

vacacionesGasoleras(Persona):-
    seVa(Persona,_),
    findall(Lugar,seVa(Persona,Lugar),Lugares),
    forall(member(Lugar,Lugares),esGasolero(Lugar)).

itinerario(Persona, Itinerario) :-
    seVa(Persona, _),
    findall(Lugar, seVa(Persona, Lugar), Lugares),
    permutation(Lugares, Itinerario).
