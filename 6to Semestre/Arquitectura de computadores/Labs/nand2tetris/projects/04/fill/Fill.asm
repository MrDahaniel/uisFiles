// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(START)
    @8192 // este es el tamaño de la pantalla (512x256 pixeles, que se llena con 32*256 filas de 16bits)
    D=A  // Tomamos la dirección inicio para la pantalla 
    @PLACE
    M=D // Y la pasamos a place que es nuestro punto de inicio

(KBDLOOP)
    @PLACE // Trae el índice de la pantalla
    M=M-1 // Y lo empieza a recorrer hacia atrás
    D=M // Y asignamos el valor a D
    @START // En el caso de que el índice pase a ser negativo,
    D;JLT  // le decimos que salte a start para reiniciar el índice
    @KBD
    D=M // Pasamos el valor de KBD a D
    @BLACK
    D;JGT // si hay una tecla presionada, salte a negro
    @WHITE
    D;JEQ // si no hay nada, salta a blanco

(BLACK)
    @SCREEN // Traemos la dirección de la pantalla
    D=A // Y la pasamos a D
    @PLACE 
    A=D+M // Le pasamos el índice para ir llenando la pantalla de atrás hacia adelante
    M=-1 // Y le hacemos set a -1 (1111111111111111) para llenar la fila de 16 bits a 1
    @KBDLOOP 
    0;JMP // Y saltamos otra vez al loop del teclado
    
(WHITE)
    @SCREEN
    D=A
    @PLACE
    A=D+M              
    M=0 // Se realiza lo mismo que en BLACK pero ponemos el bit en 0 para "limpiarlo"
    @KBDLOOP
    0;JMP 

