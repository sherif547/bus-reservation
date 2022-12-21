.model large
; Declare data segments
.data
    maxNameLength dw 7              ; Maximum length of user's name
    userName db ? ;--------
    inputPrompt db 10, "Enter your name: ", "$"
    startPrompt db 10, "1-Tanta to Elmansoura", "$"
    backPrompt db 10, "2-Elmansoura to tanta", "$"
    errorMessage db 10, "Error", "$"
    cancelMessage db 10, "Cancelled", "$"
    startTime1 db 10, "1- 7am", "$"     
    startTime2 db 10, "2- 8am", "$" 
    startTime3 db 10, "3- 9am", "$" 
    
    backTime1 db 10, "1- 3pm", "$"
    backTime2 db 10, "2- 4pm", "$"
    backTime3 db 10, "3- 5pm", "$"
    
    backTicket1 db 10, "Elmansoura to tanta: 3 pm ==> price 13.5 LE ", "$"
    backTicket2 db 10, "Elmansoura to tanta: 4 pm ==> price 13.5 LE ", "$"
    backTicket3 db 10, "Elmansoura to tanta: 5 pm ==> price 13.5 LE ", "$"
    
    startTicket1 db 10, "Tanta to Elmansoura: 7 am ==> price 14.25 LE ", "$"
    startTicket2 db 10, "Tanta to Elmansoura: 8 am ==> price 14.25 LE ", "$"
    startTicket3 db 10, "Tanta to Elmansoura: 9 am ==> price 14.25 LE ", "$"
    
    payPrompt db 10, "1-Pay", "$"
    cancelPrompt db 10, "2-Cancel", "$"
    
    visaPrompt db 10, "Enter Visa number:", "$"
    visaLength dw 3
    visaNumber db ?   ;-------
    
    correctName db "sherif", "$" 
    correctNameLength dw 6
    
    passwordPrompt db 10, "Enter password:", "$"
    password db ? ;------
    successMessage db 10, "Transaction complete", "$"
    
    invalidInputMessage db 10, "Invalid input", "$"

; Declare code segment
.code
    main proc far
        .startup
        ; Display name input prompt
        call newInterface
        lea dx, inputPrompt
        call printString
        
        ; Read and store user's name
        mov cx, maxNameLength
        mov si, offset userName ;define variable we do not need------
        readName:
            mov ah, 01h
            int 21h
            loop readName
        
        ; Display main menu
        call newInterface
        lea dx, startPrompt
        call printString
        
        lea dx, backPrompt
        call printString
        
        ; Read and process user's choice
        call readChar
        cmp al, 49
        je option1
        cmp al, 50
        je option2
        jmp error   
        
        ; Option 1: Tanta to Elmansoura
option1:
    ; Display start time options
    call newInterface
    lea dx, startTime1
    call printString
    lea dx, startTime2
    call printString
    lea dx, startTime3
    call printString
    
    ; Read and process user's choice
    call readChar
    cmp al, 49
    je startTime1Selected
    cmp al, 50
    je startTime2Selected
    cmp al, 51
    je startTime3Selected
    jmp invalidInput

; Start time 1 selected
startTime1Selected:
    ; Display ticket info and payment options
    call newInterface
    lea dx, startTicket1
    call printString
    lea dx, payPrompt
    call printString
    lea dx, cancelPrompt
    call printString
    
    ; Process payment
    call processPayment
    jmp exit

; Start time 2 selected
startTime2Selected:
    ; Display ticket info and payment options
    call newInterface
    lea dx, startTicket2
    call printString
    lea dx, payPrompt
    call printString
    lea dx, cancelPrompt
    call printString
    
    ; Process payment
    call processPayment
    jmp exit

; Start time 3 selected
startTime3Selected:
    ; Display ticket info and payment options
    call newInterface
    lea dx, startTicket3
    call printString
    lea dx, payPrompt
    call printString
    lea dx, cancelPrompt
    call printString
    
    ; Process payment
    call processPayment
    jmp exit

; Option 2: Elmansoura to Tanta
option2:
    ; Display back time options
    call newInterface
    lea dx, backTime1
    call printString
    lea dx, backTime2
    call printString
    lea dx, backTime3
    call printString
    
    ; Read and process user's choice
    call readChar
    cmp al, 49
    je backTime1Selected
    cmp al, 50
    je backTime2Selected
    cmp al, 51
    je backTime3Selected
    jmp invalidInput

; Back time 1 selected
backTime1Selected:
    ; Display ticket info and payment options
    call newInterface
    lea dx, backTicket1
    call printString
    lea dx, payPrompt
    call printString
    lea dx, cancelPrompt
    call printString
    
    ; Process payment
    call processPayment
    jmp exit

; Back time 2 selected
backTime2Selected:
    ; Display ticket info and payment options
    call newInterface
    lea dx, backTicket2
    call printString
    lea dx, payPrompt
    call printString
    lea dx, cancelPrompt
    call printString
    
    ; Process payment
    call processPayment
    jmp exit

; Back time 3 selected
backTime3Selected:
    ; Display ticket info and payment options
    call newInterface
    lea dx, backTicket3
    call printString
    lea dx, payPrompt
    call printString
    lea dx, cancelPrompt
    call printString
    
    ; Process payment
    call processPayment
    jmp exit

; Invalid input
invalidInput:
    call newInterface
    lea dx, invalidInputMessage
    call printString
    jmp exit

; Error
error:
    call newInterface
    lea dx, errorMessage
    call printString
    jmp exit

; Exit program
exit:
    mov ah, 4ch
    int 21h

main endp
; Process payment
processPayment proc near
    ; Read and process user's choice
    call readChar
    cmp al, 49
    je pay
    cmp al, 50
    je cancel
    jmp invalidInput
    
    ; Pay
    pay:
        ; Prompt for Visa number
        call newInterface
        lea dx, visaPrompt
        call printString
        
        ; Read and store Visa number
        mov cx, visaLength
        mov si, offset visaNumber ;define variable we do not need------
        readVisa:
            mov ah, 01h
            int 21h
            loop readVisa
        
        ; Prompt for password
        call newInterface
        lea dx, passwordPrompt
        call printString
        
        ; Read and store password
        mov cx, correctNameLength
        mov si, offset password ;define variable we do not need------
        readPassword:
            mov ah, 01h
            int 21h
            loop readPassword
        
        ; Validate password
        mov cx, correctNameLength
        mov si, offset correctName ;define variable we do not need---
        mov di, offset password ;define variable we do not need----
        cmpPassword:
            mov al, [si]
            cmp al, [di]
            jne invalidPassword
            inc si
            inc di
            loop cmpPassword
        
        ; Payment successful
        call newInterface
        lea dx, successMessage
        call printString
        jmp exit
    
    ; Cancel
    cancel:
        call newInterface
        lea dx, cancelMessage
        call printString
        jmp exit
    
    ; Invalid password
    invalidPassword:
        call newInterface
        lea dx, invalidInputMessage
        call printString
        jmp exit
processPayment endp


        PRINTSTRING proc near ;READ FROM DX
        MOV AH,09H
        INT 21H
        RET
        PRINTSTRING ENDP
    
        NEWINTERFACE proc near
        MOV AH,00H
        MOV AL,03H
        INT 10H
        RET
        NEWINTERFACE ENDP
   
        READCHAR proc near;STORE IN AL
        MOV ah,01H
        INT 21H
        RET
        READCHAR ENDP
    
        ;sherif proc near
        ;CALL READCHAR
        ;CMP AL,49
        ;JE pay
        ;CMP AL,50
        ;JE cancel 
        ;sherif endp
        
end main

