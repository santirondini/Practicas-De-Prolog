
% mago (Nombre,Sangre,Caracteristicas)

mago(harry,mestiza,[corajudo,amistoso,orgulloso,inteligente]).
mago(draco,pura,[inteligente,orgulloso]).
mago(hermione,impura,[inteligente,orgulloso,responsable]).
mago(ron,_,_).
mago(luna,_,_).

odiaria(harry,slytherin).
odiaria(draco,hufflepuff).

masImportante(gryffindor,corajudo).
masImportante(slytherin,orgulloso).
masImportante(slytherin,inteligente).
masImportante(ravenclaw,inteligente).
masImportante(ravenclaw,responsable).
masImportante(hufflepuff,amistoso).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

permiteEntrar(Casa,Mago):-
    casa(Casa),
    mago(Mago,_,_),
    Casa \= slytherin. 

caracterApropiado(Mago,Casa):-
    casa(Casa),
    mago(Mago,_,Caracteristicas),
    forall(masImportante(Casa,ACumplir),member(ACumplir, Caracteristicas)).

tieneAmistad(Mago):-
    mago(Mago,_,Caracteristicas),
    member(amistoso,Caracteristicas).

% Ver: 

cadenaDeAmistades(Magos):-
    forall(Magos,tieneAmistad(Mago)). 


% Elipisis 

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

malasAcciones(hermione,tercerPiso,-75).
malasAcciones(hermione,biblioteca,-10).
malasAcciones(harry,bosque,-50).
malasAcciones(harry,tercerPiso,-75).

buenasAcciones(ron,ganarAjedrez,50).
buenasAcciones(hermione,usaIntelecto,50).
buenasAcciones(harry,venceVoldemort,60). 

esBuenAlumno(Mago):-
    mago(Mago,_,_),
    buenasAcciones(Mago,_,_),
    not(malasAcciones(Mago,_,_)).

esRecurrente(Accion):-
    malasAcciones(Mago,Accion,_),
    malasAcciones(Mago2,Accion,_),
    Mago \= Mago2.
esRecurrente(Accion):-
    buenasAcciones(Mago,Accion,_),
    buenasAcciones(Mago2,Accion,_),
    Mago \= Mago2.

puntajeDeUnaCasa(Casa,Puntaje):-
    findall(Puntos, (esDe(Mago,Casa),malasAcciones(Mago,_,Puntos)), MalasAcciones),
    findall(Puntos, (esDe(Mago,Casa),buenasAcciones(Mago,_,Puntos)), BuenasAcciones),
    sumlist(MalasAcciones, SumMA),
    sumlist(BuenasAcciones, SumBA),
    Puntaje is SumMA + SumBA. 

casaGanadora(CasaGanadora) :-
    % Encuentra todas las casas
    findall(Casa, casa(Casa), Casas),
    
    % Calcula el puntaje para cada casa
    findall(Puntaje-Casa, (member(Casa, Casas), puntajeDeUnaCasa(Casa, Puntaje)), Puntajes),
    
    % Encuentra el puntaje máximo
    max_member(_-CasaGanadora, Puntajes).

/*
Tomo como que las preguntas sean buenas acciones, al y al cabo, la informacion que nos importa
es la de la dificultad de la pregunta, la cual altera los puntajes.
*/
