
personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch,  boxeador).

pareja(marsellus, mia).
pareja(pumkin,honeyBunny).

%trabajaPara( Empleador, Empleado )

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).
amigo(marvin,jules).

% 1) 

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje,mafioso(maton)).
realizaActividadPeligrosa(Personaje):-
    personaje(Personaje,ladron(lista)),
    member(licorerias,lista).

tieneEmepleadosPeligrosos(Personaje):-
    trabajaPara(Personaje,Empleado),
    realizaActividadPeligrosa(Empleado).

esPeligroso(Personaje):-
    realizaActividadPeligrosa(Personaje),
    tieneEmepleadosPeligrosos(Personaje).

% 2) 

/*
2. duoTemible/2 que relaciona dos personajes cuando son peligrosos y además son pareja o amigos. Considerar que Tarantino también nos dió los siguientes hechos:

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedo)
*/

sonPeligrosos(Personaje1,Personaje2):-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2).

parejaOamigos(Personaje1,Personaje2):-
    amigo(Personaje1,Personaje2).
parejaOamigos(Personaje1,Personaje2):-
    amigo(Personaje2,Personaje1).
parejaOamigos(Personaje1,Personaje2):-
    pareja(Personaje1,Personaje2).
parejaOamigos(Personaje1,Personaje2):-
    pareja(Personaje2,Personaje1).
        

duoTerrible(Personaje1,Personaje2):-
    personaje(Personaje1,_),
    personaje(Personaje2,_),
    sonPeligrosos(Personaje1,Personaje2),
    parejaOamigos(Personaje1,Personaje2).

/*

3.  estaEnProblemas/1: un personaje está en problemas cuando 
el jefe es peligroso y le encarga que cuide a su pareja
o bien, tiene que ir a buscar a un boxeador. 
Además butch siempre está en problemas. 

*/

% encargo (Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)

encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    pareja(Personaje,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

estaEnProblemas(Personaje):-
    encargo(_,Personaje,buscar(Buscado,_)),
    personaje(Buscado,boxeador).

% 4) 

estaCerca(Personaje,Cercano):-
    amigo(Personaje,Cercano).
estaCerca(Personaje,Cercano):-
    amigo(Cercano,Personaje).
estaCerca(Personaje,Cercano):-
    trabajaPara(Personaje,Cercano).

sanCayetano(Personaje):-
    personaje(Personaje,_),
    personaje(OtraPersona,_),
    forall(estaCerca(Personaje,OtraPersona),encargo(Personaje,OtraPersona,_)).

% 5) 

encargos(Personaje,CantidadDeEncargos):-
    findall(Encargo,encargo(Personaje,_,Encargo),Encargos),
    length(Encargos,CantidadDeEncargos).

masAtareado(Personaje):-
    personaje(Personaje,_),
    encargos(Personaje,CantidadDeEncargos),
    forall((personaje(Otro,_),(Otro \= Personaje),encargos(Otro,OtraCantidad)), CantidadDeEncargos > OtraCantidad).

/* 6) personajesRespetables/1: genera la lista de todos los personajes respetables. Es respetable cuando su actividad tiene un nivel de respeto mayor a 9. Se sabe que:

Las actrices tienen un nivel de respeto de la décima parte de su cantidad de peliculas.
Los mafiosos que resuelven problemas tienen un nivel de 10 de respeto, los matones 1 y los capos 20.
Al resto no se les debe ningún nivel de respeto. 

*/

calcularNivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,_),
    nivelDeRespeto(Personaje,Nivel).

nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,actriz(Peliculas)),
    length(Peliculas,CantidadDePeliculas),
    Nivel is CantidadDePeliculas * 0,1.

nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(Adjetivo)),
    Adjetivo = resuelveProblemas,
    Nivel is 10.

nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(Adjetivo)),
    Adjetivo = maton,
    Nivel is 1.
nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(Adjetivo)),
    Adjetivo = capo,
    Nivel is 20.

esRespetable(Personaje):-
    nivelDeRespeto(Personaje,Nivel),
    Nivel > 9.

personajesRespetables(Personajes):-    
    findall(Personaje,(personaje(Personaje,_),esRespetable(Personaje)),Personajes).

/*

7. hartoDe/2: un personaje está harto de otro, cuando todas las tareas asignadas al primero requieren 
interactuar con el segundo (cuidar, buscar o ayudar) o un amigo del segundo. Ejemplo:

encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


*/

hartoDe(Personaje,Otro):-
    personaje(Personaje,_),
    personaje(Otro,_),
    amigo(Otro,AmigoDeOtro),
    hartoDe(Personaje,AmigoDeOtro).

hartoDe(Personaje,Otro):-
    personaje(Personaje,_),
    personaje(Otro,_),
    forall(encargo(_,Personaje,cuidar(_)),encargo(_,Personaje,cuidar(Otro))),
    forall(encargo(_,Personaje,ayudar(_)),encargo(_,Personaje,ayudar(Otro))),
    forall(encargo(_,Personaje,buscar(_)),encargo(_,Personaje,buscar(Otro))).
/*

8. Ah, algo más: nuestros personajes tienen características. Lo cual es bueno, porque nos ayuda a diferenciarlos cuando están de a dos. Por ejemplo:

Desarrollar duoDiferenciable/2, que relaciona a un dúo (dos amigos o una pareja) en el que uno tiene al menos una característica que el otro no. 
*/
caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

/*
   VER: 
*/
duoDiferenciable(Personaje1,Personaje2):-
    personaje(Personaje1,Caracteristica1),
    personaje(Personaje2,Caracteristica2),
    parejaOamigos(Personaje1,Personaje2),
    member(Caracteristica,Caracteristica1),
    not(member(Caracteristica,Caracteristica2)).

duoDiferenciable(Personaje1,Personaje2):-
    personaje(Personaje1,Caracteristica1),
    personaje(Personaje2,Caracteristica2),
    parejaOamigos(Personaje,Personaje2),
    member(Caracteristica,Caracteristica2),
    not(member(Caracteristica,Caracteristica1)).
    









