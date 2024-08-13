
desarollo(ana,herreria).
desarollo(ana,forja).
desarollo(ana,fundicion).

desarollo(beto,herreria).
desarollo(beto,forja).
desarollo(beto,fundicion).

desarollo(carola,herreria).

desarollo(dimitri,herreria).
desarollo(dimitri,fundicion).

juegacon(ana,romanos).

juegacon(beto,incas).

juegacon(carola,romanos).

juegacon(dimitri,romanos).

expertoEnMetales(Jugador):-
    desarollo(Jugador,herreria),
    desarollo(Jugador,forja).
desarolloFundicion(Jugador):-
    desarollo(Jugador,fundicion).
juegaConRomanos(Jugador):-
    juegacon(Jugador,romanos).

esPopular(Civilizacion):-
    juegacon(Jugador1,Civilizacion),
    juegacon(Jugador2,Civilizacion),
    Jugador1 \= Jugador2.

tieneAlcanceGlobal(Tecnologia):-
    forall(juegacon(Jugador,_), desarollo(Jugador,Tecnologia)).

alcanzoTeconlogia(Tecnologia,Civilizacion):-
    juegacon(Jugador,Civilizacion),
    desarollo(Jugador,Tecnologia).
    







