@2	// Inicializamos R2 en 0
M = 0	

@0 // Si R0 es 0, GOTO end
D=M
@END
D;JEQ

@1 // Si R1 es 0, GOTO end
D=M
@END
D;JEQ

(LOOP)

@0 // Toma R0 y pasa su valor a D
D=M

@2 // Toma R2 y le suma D (Que sería R0)
M=M+D

@1 //Le restamos 1 a R1
M=M-1

@6 //Que salte a la instrucción 6
0;JMP 

(END_LOOP)

@END  // Se queda saltando a si mismo  
0;JMP // Para no recorrer el código una y otra vez




