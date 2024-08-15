
aprobo(santino,pdp,6).
aprobo(santino,paradigmas,7).
aprobo(santino,algoritmos,8).
aprobo(santino,matematica,9).
aprobo(santino,algebra,10).


notaMasBaja(Persona,Nota):-
    aprobo(Persona,_,Nota),
    forall(aprobo(Persona,_,Nota2),Nota =< Nota2).

promociono(Persona,Materia):-
    aprobo(Persona,Materia,Nota),
    Nota >= 8.

promocionoTodas(Persona):-
    aprobo(Persona,_,_),
    forall(aprobo(Persona,Materia,_),promociono(Persona,Materia)).

