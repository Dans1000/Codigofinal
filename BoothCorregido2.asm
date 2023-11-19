Inicio:
           MOV ACC, CTE        ;Se mueve el acumulador a la posicio de tam
	   MOV DPTR, ACC       ;Se mueve el valor de acc al data pointer
	   MOV ACC, [DPTR]     ;Se mueve el valor que hay en el data pointer a el acumulador
Negar: 
           INV ACC
	   MOV A, ACC
	   MOV ACC, CTE
	   ADD ACC, A
	   MOV A, ACC
load_ite:  
           MOV ACC, i          ;Se hace la suma de el tamaño negado con el iterador 
           MOV DPTR, ACC
           MOV ACC, [DPTR]
           ADD ACC, A
Loop_test: 
           JN Q-1             ;Se evalua que si la suma dio un numero negativo se sigue haciendo el for
           JMP END
Case:      
           MOV ACC, Q          ;Se empiezan a evaluar los diferentes casos que existen en total son cuatro
           MOV DPTR, ACC
           MOV ACC, [DPTR]
	   MOV A, ACC
           MOV ACC, A 
           AND ACC, A
	   MOV A, ACC
	   MOV ACC, Q
	   MOV DPTR, ACC
           MOV ACC, [DPTR]
	   JZ IGUALES
DISTINTOS: 
           MOV ACC, A
           JZ DISTINTOS01
DISTINTOS10:
           MOV ACC, M         ;Segundo caso esn este se debe restar
           MOV DPTR, ACC
           MOV ACC, [DPTR]
           INV ACC
	   MOV A, ACC
	   MOV ACC, CTE
	   ADD ACC, A
	   MOV A, ACC
	   MOV ACC, A
	   MOV DPTR, ACC
	   MOV ACC, [DPTR]
	   ADD ACC, A                                        
           JMP INC_SHR
DISTINTOS01:
            MOV ACC, M
	    MOV DPTR, ACC
	    MOV ACC, [DPTR]
	    MOV A, ACC
            MOV ACC, A
            MOV DPTR, ACC
	    MOV ACC, [DPTR]
	    ADD ACC, A
            JMP INC_SHR
IGUALES:   
            MOV ACC, A
	    MOV DPTR, ACC
	    MOV ACC, [DPTR]		   
INC_SHR:
            MOV A, ACC             ;Se empiezan los shifts aritmeticos
            MOV ACC, 0b10000000 
            AND ACC, A             ;Primero se evalua si la cifra mas significativa de AS es 1 o 0 si es uno se hace el shift y se suma ese uno posteriormente
            JZ SHR0
SHR1:
            MOV ACC, i           ;Aqui esta el caso en el que la cifra mas significativa de A es una 
            AND ACC, A              ;Se evalua si la cifra menos significativa de A es 0 o 1 para asi hacer el shift en Q y si es uno sumarle este posteriormente
            JZ 1SHRQ0
1SHRQ1:
	    MOV ACC, A               ;Se hace el caso donde la cifra menos significativa de A es 1
            RSH ACC CTE 
            MOV A, ACC               ;Se realiza el shift de A sumandole 10000000 para que asi se conserve ese uno de la cifra mas significativa
	    MOV ACC, 0b10000000
	    ADD ACC, A                         
	    MOV [DPTR], ACC
            MOV ACC, Q
  	    MOV DPTR, ACC            ;Se toma Q para ver si su cifra menos significativa es 0 o 1
            MOV ACC, [DPTR]
	    MOV A, ACC
	    MOV ACC, i
            AND ACC, A
	    JZ 1SHRQS0  
1SHRQS1:
            MOV ACC, A
            RSH ACC
	    MOV A, ACC
	    MOV ACC, 0b10000000
            ADD ACC, A
	    MOV [DPTR], ACC
	    MOV ACC, Q-1
	    MOV DPTR, ACC
	    MOV ACC, [DPTR]
	    RSH ACC CTE
            MOV A, ACC
            MOV ACC, 0x01
	    ADD ACC, A
	    MOV [DPTR], ACC
            JMP INC_IT
1SHRQS0:
	    MOV ACC, A
            RSH ACC CTE
            MOV A, ACC
	    MOV ACC, 0b10000000
	    ADD ACC, A
	    MOV [DPTR], ACC
	    MOV ACC, Q-1
            MOV DPTR, ACC
	    MOV ACC, [DPTR]
            RSH ACC CTE
	    MOV [DPTR], ACC
	    JMP INC_IT
1SHRQ0:
            MOV ACC, A
            RSH ACC CTE
            MOV A, ACC
	    MOV ACC, 0b10000000
	    ADD ACC, A
	    MOV [DPTR], ACC
            MOV ACC, Q
  	    MOV DPTR, ACC
            MOV ACC, [DPTR]
	    MOV A, ACC
	    MOV ACC, 0x01
	    AND ACC, A
            JZ 2SHRQS0
2SHRQS1:
            MOV ACC, A
            RSH ACC CTE
	    MOV [DPTR], ACC
	    MOV ACC, Q-1
            MOV DPTR, ACC
	    MOV ACC, [DPTR]
       	    RSH ACC CTE
            MOV A, ACC
	    MOV ACC, 0x01
	    ADD ACC, A
	    MOV [DPTR], ACC
	    JMP INC_IT		 
2SHRQS0:
            MOV ACC, A
            RSH ACC CTE
	    MOV [DPTR], ACC
	    MOV ACC, Q-1
	    MOV DPTR, ACC
	    MOV ACC, [DPTR]
	    RSH ACC CTE
            MOV [DPTR], ACC
	    JMP INC_IT
SHR0:
            MOV ACC, 0x01
            AND ACC, A
 	    JZ 2SHRQ0
2SHRQ1:
 	    MOV ACC, A
            RSH ACC CTE
	    MOV [DPTR], ACC
            MOV ACC, Q
  	    MOV DPTR, ACC
	    MOV ACC, [DPTR]
	    MOV A, ACC
	    MOV ACC, 0x01
	    AND ACC, A
	    JZ 3SHRQS0
3SHRQS1:
            JMP 1SHRQS1
3SHRQS0:
	    JMP 1SHRQS0
2SHRQ0:
            MOV ACC, A
            RSH ACC CTE
	    MOV [DPTR], ACC
            MOV ACC, Q
  	    MOV DPTR, ACC
	    MOV ACC, [DPTR]
	    MOV A, ACC
            MOV ACC, 0x01
	    AND ACC, A
	    JZ 4SHRQS0
4SHRQS1:
            JMP 2SHRQS1		 
4SHRQS0:
            JMP 2SHRQS0
INC_IT:
            MOV ACC, i                ;Se toma el iterador para sumarle uno
	    MOV DPTR, ACC
	    MOV ACC, [DPTR]
            MOV A, ACC
	    MOV ACC, 0x01
            ADD ACC, A
	    MOV [DPTR], ACC 
	    JMP Inicio            ;Se salta al inicio del codigo para poder reiniciar y completar todos los casos
		    
END:
           MOV ACC, A
           MOV DPTR, ACC
           MOV ACC, [DPTR]
           MOV A, ACC
	   MOV ACC, M
	   MOV DPTR, ACC
           MOV ACC, [DPTR]
           HLT			     ;Finaliza el programa
Inicialización de las variables: 
i: 0x0
Count: 0x8
Q-1: 0b0
M: 0b00001000 ;Multiplicando
Q: 0b10000000 ;Multiplicador
Q0: 0b0
