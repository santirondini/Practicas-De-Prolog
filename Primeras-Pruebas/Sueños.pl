
% creeEn ( Nombre , Que Creen )

creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).

creeEn(juan,conejo).

creeEn(macarena,reyesMagos).
creeEn(macarena,elMagoCapria).
creeEn(macarena,campanita).

% suenia ( Nombre , Sueño )

suenia(gabriel,ganarLoteria([5,9])).
suenia(gabriel,futbolista(arsenal)).
suenia(juan,cantante(100000)).
suenia(macarena,cantante(10000)).

% 2) 

dificultad(cantante(Discos),Dificultad):-
    Discos > 500000,
    Dificultad is 6.

dificultad(cantante(Discos),Dificultad):-
    Discos =< 500000,
    Dificultad is 4. 

dificultad(ganarLoteria(Numeros),Dificultad):-
    length(Numeros,CantidadDeNumeros),
    Dificultad is CantidadDeNumeros*10.

dificultad(futbolista(arsenal),Dificultad):-
    Dificultad is 3.

dificultad(futbolista(aldosivi),Dificultad):-
    Dificultad is 3.

dificultad(futbolista(Equipo),Dificultad):-
    Dificultad is 16.

esAmbiciosa(Persona):-
    suenia(Persona,_),
    findall(Dificultad,(suenia(Persona,Suenio),dificultad(Suenio,Dificultad)),Dificultades),
    sum_list(Dificultades,SumaTotal),
    SumaTotal > 20. 

% 3)

suenioPuro(futbolista(_)).
suenioPuro(cantante(Discos)):-
    Discos < 200000.

tieneQuimica(Persona,Personaje):-
    creeEn(Persona,Personaje),
    hayQuimica(Persona,Personaje).
    
hayQuimica(Persona,campanita):-
    suenia(Persona,Suenio),
    dificultad(Suenio,Dificultad),
    Dificultad < 5. 

hayQuimica(Persona,Personaje):-
    not(esAmbiciosa(Persona)),
    forall(suenia(Persona,Suenio),suenioPuro(Suenio)).

% 4)

personaje(campanita,si).
personaje(conejo,si).
personaje(reyesMagos,si).

esAmigo(campanita,reyesMagos).
esAmigo(campanita,conejo).
esAmigo(conejo,cavenaghi).

puedeAlegrar(Personaje,Persona):-
    suenia(Persona,_),
    tieneQuimica(Persona,Personaje),
    noHayEnfermos(Personaje).

noHayEnfermos(Personaje):-
    not(personaje(Personaje,si)).
noHayEnfermos(Personaje):-
    esBackUp(Personaje,BuckUp),
    not(personaje(BuckUp,si)).

esBackUp(Personaje,BuckUp):-
    esAmigo(Persona,BuckUp).

esBackUp(Personaje,BuckUp):-
    esAmigo(BuckUp,Personaje).

esBackUp(Personaje,BuckUp):-
    esAmigo(Persona,Otro),
    esAmigo(Otro,BuckUp).




    

