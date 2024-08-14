
% persona( Nombre, Edad, Altura (cm))

persona(nina,22,160,joven).
persona(marcos,8,132,niño).
persona(osvaldo,13,129,adolescente).


% atracción (Parque , nombre, edadMinima , alturaMinima)

atraccion(parqueDelaCosta,trenFanstasma,12,0).
atraccion(parqueDelaCosta,montaniaRusa,0,130).
atraccion(parqueDelaCosta,maquinaTiquetera,0,0).
atraccion(parqueAcuatico,laOlaAzul,0,150).
atraccion(parqueAcuatico,corrienteSepenteante,0,0).
atraccion(parqueAcuatico,maremoto,5,0).

cumpleCondiciones(Persona,Atraccion):-
    persona(Persona,Edad,Altura,_),
    atraccion(_,Atraccion,EdadMinima,AlturaMinima),
    Edad > EdadMinima,
    Altura > AlturaMinima.

puedeSubir(Persona,Atraccion):-
    cumpleCondiciones(Persona,Atraccion).

esParaElle(Parque,Persona):-
    atraccion(Parque,_,_,_),
    persona(Persona,_,_,_),
    findall(Atraccion, atraccion(Parque,Atraccion,_,_),Atracciones),
    forall(member(Atraccion,Atracciones),puedeSubir(Persona,Atraccion)).

puedenSubirTodos(GrupoEtario,Parque):-
    member(Atraccion,Parque),
    forall(member(Persona,GrupoEtario),puedeSubir(Persona,Atraccion)).

malaIdea(GrupoEtario,Parque):-
    persona(_,_,_,GrupoEtario),
    atraccion(Parque,_,_,_),
    not(puedenSubirTodos(GrupoEtario,Parque)).

todosDistintos([]).
todosDistintos(X|Cola):- not(member(X,Cola)), todosDistintos(Cola).

programaLogico(Programa):-
    forall(member(Parque,Programa),atraccion(Parque,_,_,_)),
    todosDistintos(Programa).

atraccionCortante(Programa,Persona,AtraccionCortante):-
    persona(Persona,_,_,_),
    member(AtraccionCortante,Programa),
    not(puedeSubir(Persona,AtraccionCortante)).

hastaAca(P,[],S).
hastaAca(P,(Cabeza|Cola),S):-
    not(atraccionCortante(P,Persona,Cabeza)),
    hastaAca(P,Cola,S).


    
