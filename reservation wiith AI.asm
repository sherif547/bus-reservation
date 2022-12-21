.model LARGE
.data
    nm Dw 7
    info DB 10,"enter your name :","$"
    start DB 10,"1-Tanta to Elmansoura","$"
    back DB 10,"2-Elmansoura to tanta","$"
    erro DB 10,"error","$"
    can DB 10 ,"canceled","$"
    sttime1 db 10,"1- 7am","$"     
    sttime2 db 10,"2- 8am","$" 
    sttime3 db 10,"3- 9am","$" 
    
    btime1 db 10,"1- 3pm","$"
    btime2 db 10,"2- 4pm","$"
    btime3 db 10,"3- 5pm","$"
    
    
    bit1 db 10,"Elmansoura to tanta : 3 pm ==> price 13.5 LE ","$"
    bit2 db 10,"Elmansoura to tanta : 4 pm ==> price 13.5 LE ","$"
    bit3 db 10,"Elmansoura to tanta : 5 pm ==> price 13.5 LE ","$"
    
    stt1 db 10,"Tanta to Elmansoura : 7 am ==> price 14.25 LE ","$"
    stt2 db 10,"Tanta to Elmansoura : 8 am ==> price 14.25 LE ","$"
    stt3 db 10,"Tanta to Elmansoura : 9 am ==> price 14.25 LE ","$"
    
    check1 db 10,"1-pay","$"
    check2 db 10,"2-cancel","$"
    
    
    VISA_NUM DB 10,"ENTER VISA NUMBER","$"
    visalen dw 3
    
    PASSname DB "salah","$" 
    Passlen Dw 5
    
    ENTERPASS DB 10,"ENTER PASSWORD","$"
    sucssed db 10,"mission complete","$"
    INVALID DB  10,"Invalid Input" ,"$"
        
.code
    main proc far
        .startup
        ;MAIN 
        CALL NEW_INTERFACE 
        LEA DX,info
        CALL PRINT_STRING
        MOV CX,NM
         nam:
                mov ah,01h
                int 21h
                loop nam
        
        ;main interface
        CALL NEW_INTERFACE 
        LEA DX,start
        CALL PRINT_STRING
        
        LEA DX,back
        CALL PRINT_STRING
           
        CALL READ_CHAR
        CMP AL,49
        JE OP1
        CMP AL,50
        JE OP2
        jmp error   
            
        ;opptions one  
        OP1:
            CALL NEW_INTERFACE 
            LEA DX,sttime1
            CALL PRINT_STRING
            LEA DX,sttime2
            CALL PRINT_STRING
            LEA DX,sttime3
            CALL PRINT_STRING
           
            ;read and check char
            CALL READ_CHAR
            CMP AL,49
            JE A
            CMP AL,50
            JE B 
            CMP AL,51
            JE C
            
             ;check 7 am and price
             A:
             CALL NEW_INTERFACE 
             LEA DX,stt1
             CALL PRINT_STRING
             LEA DX,CHECK1
             CALL PRINT_STRING
             LEA DX,CHECK2
             CALL PRINT_STRING            
         ;00000000000000000000000000000000000000
             call sherif
             B:
             CALL NEW_INTERFACE 
             LEA DX,stt2
             CALL PRINT_STRING
             LEA DX,CHECK1
             CALL PRINT_STRING
             LEA DX,CHECK2
             CALL PRINT_STRING
             ;000000000000000000000000000000000000000
             call sherif
             
             c:
             CALL NEW_INTERFACE   
             LEA DX,stt3
             CALL PRINT_STRING               
             LEA DX,CHECK1
             CALL PRINT_STRING               
             LEA DX,CHECK2
             CALL PRINT_STRING
             ;00000000000000000000000000000000000
             call sherif
         ;opptions two
         OP2:
            CALL NEW_INTERFACE 
            LEA DX,btime1
            CALL PRINT_STRING
            LEA DX,btime2
            CALL PRINT_STRING
            LEA DX,btime3
            CALL PRINT_STRING   
            CALL READ_CHAR
            CMP AL,49
            JE A2
            CMP AL,50
            JE B2 
            CMP AL,51
            JE C2 
             A2:
             CALL NEW_INTERFACE 
             LEA DX,bit1
             CALL PRINT_STRING
             LEA DX,CHECK1
             CALL PRINT_STRING
             LEA DX,CHECK2
             CALL PRINT_STRING
             call sherif
             B2:
             CALL NEW_INTERFACE 
             LEA DX,bit2
             CALL PRINT_STRING
             LEA DX,CHECK1
             CALL PRINT_STRING
             LEA DX,CHECK2
             CALL PRINT_STRING
             call sherif
             c2:
             CALL NEW_INTERFACE   
             LEA DX,bit3
             CALL PRINT_STRING               
             LEA DX,CHECK1
             CALL PRINT_STRING               
             LEA DX,CHECK2
             CALL PRINT_STRING
             CALL sherif        
          
            p:
                CALL NEW_INTERFACE
                LEA DX,VISA_NUM
                CALL PRINT_STRING               
                
                 mov cx,visalen
            EZZ:
                mov ah,01h
                int 21h
                loop EZZ
        
                LEA DX,ENTERPASS
                CALL PRINT_STRING
                
                ;check -----------------              
                mov cx,passlen
                LEA bx,PASSNAME
 
                cheekpass:
                mov ah,01
                int 21h
                
                cmp al,[bx] 
                jne ERROR
                inc bx
                loop cheekpass
                jmp suc
               
         error:
                CALL NEW_INTERFACE 
                LEA DX,erro
                CALL PRINT_STRING
                jmp stop              
           ca:
                CALL NEW_INTERFACE 
                LEA DX,can          
                CALL PRINT_STRING
                jmp stop           
           suc:
                 CALL NEW_INTERFACE 
                lea DX,sucssed
                call print_string     
          stop:      
        .exit
    main endp
 ;print string-----------------------------------       
    PRINT_STRING proc near ;READ FROM DX
        MOV AH,09H
        INT 21H
        RET
    PRINT_STRING ENDP
  ;new interface---------------------------------   
   NEW_INTERFACE proc near
        MOV AH,00H
        MOV AL,03H
        INT 10H
        RET
    NEW_INTERFACE ENDP
    ;read char-------------------------------------
    READ_CHAR proc near;STORE IN AL
        MOV ah,01H
        INT 21H
        RET
    READ_CHAR ENDP
    ;the end fixed in any interface--------------------
    sherif proc near
        CALL READ_CHAR
        CMP AL,49
        JE p
        CMP AL,50
        JE ca 
    sherif endp
end main    