
% persona ( Nombre , lista de dias ,Horario de Entrada , Horario de Salida)

persona(dodain,lunes,9,15).
persona(dodain,miercoles,9,15).
persona(dodain,viernes,9,15).

persona(lucas,martes,10,20).

persona(juanC,sabados,18,22).
persona(juanC,domingos,18,22).

persona(juanFds,jueves,10,20).
persona(juanFds,viernes,12,20).

persona(leoC,lunes,14,18).
persona(leoC,miercoles,14,18).

persona(martu,miercoles,23,24).

persona(vale,Dia,Inicio,Fin):- 
    persona(dodain,Dia,Inicio,Fin).
persona(vale,Dia,Inicio,Fin):-
    persona(juanC,Dia,Inicio,Fin).

atiende(Persona,Dia,Horario):-
    persona(Persona,Dia,Inicio,Fin),
    between(Inicio,Fin,Horario). 

foreverAlone(Persona,Dia,Horario):-
    atiende(Persona,Dia,Horario),
    not((atiende(Persona2,Dia,Horario), Persona2 \= Persona)). 

atiendeElDia(Persona,Dia):-
    findall(Persona, atiende(Persona,Dia,_),people).     

% 5) 



