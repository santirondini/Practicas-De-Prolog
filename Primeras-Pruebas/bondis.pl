

% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152, gba(norte), olivos).
recorrido(7,gba(norte),olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(55, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

puedenCombinarse(Linea1,Linea2):-
    recorrido(Linea1,Zona,Calle),
    recorrido(Linea2,Zona,Calle),
    Linea1 \= Linea2.

esNacional(Linea1):-
    recorrido(Linea1,caba,_),
    recorrido(Linea1,gba(_),_).

esProvincial(Linea,Juridiccion):-
    recorrido(Linea,Juridiccion,_),
    not(esNacional(Linea)). 


cuantasLineasPasan(Calle, Zona, Cantidad):-
    recorrido(_, Zona, Calle),
    findall(Calle, recorrido(_, Zona, Calle), Calles),
    length(Calles, Cantidad).
    
calleMasTransitada(Calle, Zona):-
    cuantasLineasPasan(Calle, Zona, Cantidad),
    forall((recorrido(_, Zona, OtraCalle), Calle = OtraCalle), (cuantasLineasPasan(OtraCalle, Zona, CantidadMenor), Cantidad > CantidadMenor)).    
    





% findall(Atributo de la BC, Condiciones, Nombre de la lista)




