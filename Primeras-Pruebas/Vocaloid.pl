
% cantante( Nombre , Canción , Minutos ).

cantante(megurineluka,nightFever,4).
cantante(megurineluka,foreverYoung,5).

cantante(hatsumeMiku,tellYourWorld,4).

cantante(gumi,foreverYoung,4).
cantante(gumi,tellYourWorld,20).

cantante(seeU,novemberRain,6).
cantante(seeU,nightFever,5).

tieneMasDeDosCanciones(Vocaloid):-
    cantante(Vocaloid,Cancion1,_),
    cantante(Vocaloid,Cancion2,_),
    Cancion1 \= Cancion2.

% findall( El tipo de dato, Condiciones, Lista Filtrada ). 

cancionesMasDe15(Vocaloid):-
    findall(Minutos,cantante(Vocaloid,_,Minutos),Tiempos),
    sum_list(Tiempos, Total),
    Total > 15.

esNovedoso(Vocaloid):-
    tieneMasDeDosCanciones(Vocaloid),
    cancionesMasDe15(Vocaloid).

totalDeCancionesMayorA(Vocaloid,ListaDeCanciones,MayorA):-
    cantante(Vocaloid,_,_),
    findall(Minutos,cantante(Vocaloid,_,Minutos),ListaDeCanciones),
    length(ListaDeCanciones,Tamanio),
    Tamanio > MayorA. 

sumaTotalDeCanciones(Vocaloid,TiempoTotal):-
    cantante(Vocaloid,_,_),
    findall(Minutos,cantante(Vocaloid,_,Minutos),ListaDeTiempos),
    sum_list(ListaDeTiempos,TiempoTotal). 

concierto(mikuExpo,estadosUnidos,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions,estadosUnidos,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).

cumpleRequisitos(Vocaloid,gigante(CantidadDeCanciones,TiempoMinimo)):-
    cantante(Vocaloid,_,_),
    totalDeCancionesMayorA(Vocaloid,ListaDeCanciones,CantidadDeCanciones),
    sumaTotalDeCanciones(Vocaloid,TiempoTotal),
    TiempoTotal > TiempoMinimo.

cumpleRequisitos(Vocaloid,mediano(CantidadMaxima)):-
    cantante(Vocaloid,_,_),
    sumaTotalDeCanciones(Vocaloid,TiempoTotal),
    TiempoTotal < CantidadMaxima.

cumpleRequisitos(Vocaloid,pequenio(TiempoMinimo)):-
    cantante(Vocaloid,_,Cancion),
    Cancion > TiempoMinimo.

puedeTocarEn(Concierto,Vocaloid):-
    cantante(Vocaloid,_,_),
    concierto(Concierto,_,_,Tipo),
    cumpleRequisitos(Vocaloid,Tipo). 

cantidadDeCanciones(Vocaloid,CantidadDeCanciones):-
    cantante(Vocaloid,_,_),
    findall(Minutos,cantante(Vocaloid,_,Minutos),ListaDeCanciones),
    length(ListaDeCanciones,CantidadDeCanciones).

calcularFama(Vocaloid,NivelDeFama):-
    cantante(Vocaloid,_,_),
    findall(Niveles,(puedeTocarEn(Concierto,Vocaloid),concierto(Concierto,_,Niveles,_)),ListaDeNiveles),
    sum_list(ListaDeNiveles,Fama),
    cantidadDeCanciones(Vocaloid,CantidadDeCanciones),
    NivelDeFama is CantidadDeCanciones*Fama.

masFamoso(Vocaloid):-
    cantante(Vocaloid,_,_),
    calcularFama(Vocaloid,Fama),
    forall((calcularFama(OtroVocaloid,OtraFama),OtroVocaloid \= Vocaloid), Fama >= OtraFama).

conoce(megurineLuka,hatsumeMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).

conocido(Vocaloid,Conocido):- % Directo
    conoce(Vocaloid,Conocido).

conocido(Vocaloid,Conocido):- % Indirecto
    conoce(Vocaloid,Otro),
    conocido(Otro,Conocido).

esUnico(Vocaloid,Concierto):-
    cantante(Vocaloid,_,_),
    puedeTocarEn(Concierto,Vocaloid), 
    not((puedeTocarEn(Concierto,OtroVocaloid),conocido(Vocaloid,OtroVocaloid))). 





    
    
    



    

