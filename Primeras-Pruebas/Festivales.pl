anioActual(2015).

%festival(nombre, lugar, bandas, precioBase).

%lugar(nombre, capacidad).

festival(lulapaluza, lugar(hipodromo,40000), [miranda, paulMasCarne, muse], 500).
festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).
festival(personalFest, lugar(geba, 5000), [tanBionica, miranda, muse, pharrellWilliams], 300).
festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).

%banda(nombre, año, nacionalidad, popularidad).

banda(paulMasCarne, 1960, uk, 70).
banda(muse,1994, uk, 45).
banda(kiss,1973, us, 63).
banda(erucaSativa,2007, ar, 60).
banda(judasPriest,1969, uk, 91).
banda(tanBionica,2012, ar, 71).
banda(miranda,2001, ar, 38).
banda(laRenga,1988, ar, 70).
banda(blackSabbath,1968, uk, 96).
banda(pharrellWilliams,2014, us, 85).


%entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).

% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).


entradasVendidas(lulapaluza,campo, 600).
entradasVendidas(lulapaluza,plateaGeneral(zona1), 200).
entradasVendidas(lulapaluza,plateaGeneral(zona2), 300).
entradasVendidas(mostrosDelRock,campo,20000).
entradasVendidas(mostrosDelRock,plateaNumerada(1),40).
entradasVendidas(mostrosDelRock,plateaNumerada(2),0).

% … y asi para todas las filas

entradasVendidas(mostrosDelRock,plateaNumerada(10),25).
entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).
entradasVendidas(mostrosDelRock,plateaGeneral(zona2),500).

plusZona(hipodromo, zona1, 55).
plusZona(hipodromo, zona2, 20).
plusZona(granRex, zona1, 45).
plusZona(granRex, zona2, 30).
plusZona(aerodromo, zona1, 25).

% 1) 

esReciente(Banda):-
    banda(Banda,Anio,_,_),
    anioActual(AnioActual),
    AnioActual - Anio =< 4.

popoularidadMayorA(Banda,Numero):-
    banda(Banda,_,_,Popularidad),
    Popularidad > Numero.

estaDeModa(Banda):-
    esReciente(Banda),
    popoularidadMayorA(Banda,70).

/*
2) esCareta/1. Se cumple para todo festival que cumpla alguna de las siguientes condiciones:

que participen al menos 2 bandas que estén de moda.
que no tenga entradas razonables (ver punto 3).
si toca Miranda.
?- esCareta(Festival).
Festival = personalFest ;
Festival = ...

*/


%festival(nombre, lugar, bandas, precioBase).
%lugar(nombre, capacidad).

participanBandasDeModa(Festival):-
    festival(Festival,_,Bandas,_),
    banda(Banda1,_,_,_),
    banda(Banda2,_,_,_),
    estaDeModa(Banda1),
    estaDeModa(Banda2),
    member(Banda1,Bandas),
    member(Banda2,Bandas).

esCareta(Festival):-
    participanBandasDeModa(Festival).

esCareta(Festival):-
    festival(Festival,_,Bandas,_),
    member(miranda,Bandas).


% entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).
% festival(nombre, lugar, bandas, precioBase).
% lugar(nombre, capacidad).
% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).
% banda(nombre, año, nacionalidad, popularidad).


% Campo ----------------------------------------------------------------

popularidadTotal(Festival,PopoularidadTotal):-
    festival(Festival,_,Bandas,_),
    findall(Popularidad,(member(Banda,Bandas),banda(Banda,_,_,Popularidad)),Populares),
    sum_list(Populares, PopoularidadTotal).
    
entradaRazonable(Festival,campo):-
    festival(Festival,_,_,PrecioBase),
    entradasVendidas(Festival,campo,_),
    popularidadTotal(Festival,PopoularidadTotal),
    PrecioBase < PopoularidadTotal.

% Platea Numerada ----------------------------------------------------------------

hayAlgunaBandaDeModa(Festival):-
    festival(Festival,_,Bandas,_),
    member(Banda,Bandas),
    estaDeModa(Banda).

% entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).
% festival(nombre, lugar, bandas, precioBase).
% lugar(nombre, capacidad).
% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).
% banda(nombre, año, nacionalidad, popularidad).


precio(Festival,plateaNumerada(NumeroDeFila),Precio):-
    festival(Festival,_,_,PrecioBase),
    entradasVendidas(Festival,plateaNumerada(NumeroDeFila),_),
    Precio is (PrecioBase + 200) / NumeroDeFila.

entradaRazonable(Festival,plateaNumerada(NumeroDeFila)):-
    festival(Festival,_,_,PrecioBase),
    not(hayAlgunaBandaDeModa(Festival)),
    precio(Festival,plateaNumerada(NumeroDeFila),Precio),
    Precio < 750.

entradaRazonable(Festival,plateaNumerada(NumeroDeFila)):-
    festival(Festival,lugar(_,Capacidad),_,PrecioBase),
    popularidadTotal(Festival,PopoularidadTotal),
    precio(Festival,plateaNumerada(NumeroDeFila),Precio),
    Precio < Capacidad / PopoularidadTotal.

% Platea General ----------------------------------------------------------------

precio(Festival,plateaGeneral(Zona),Precio):-
    festival(Festival,_,_,PrecioBase),
    plusZona(_,Zona,Plus),
    Precio is ((PrecioBase + 200) / NumeroDeFila). 

entradaRazonable(Festival,plateaGeneral(Zona)):-
    festival(Festival,_,_,PrecioBase),
    plusZona(_,Zona,Plus),
    precio(Festival,plateaGeneral(Zona),Precio),
    Plus <  Precio / 10.





