[org 0x0100]
jmp main

Section .data 

msg  db  'Enter a number: $'
msg1 db  'Output: $'
msg2 db  'This is an odd number',0x0a,'$'
msg3 db  'This is a even number' ,0x0a,'$'
msg4 db  'This is a prime number $'
msg5 db  'This isn t a prime number $'
num dd 0 ,'$'
newline db 0x0a , '$'


Section .code

even: 
    mov dx , msg3
    mov ah , 9
    int 21h
    jmp point 
odd:
    mov dx , msg2
    mov ah , 9
    int 21h
    jmp point
notprime:
    mov dx , msg5
    mov ah , 9
    int 21h
    jmp end
primenumber:
    mov dx , msg4
    mov ah , 9
    int 21h
    jmp end

fucntion: 
    mov dx , msg
    mov ah , 9
    int 21h

    mov ah, 7
    int 21h
    mov byte[num], al

    mov dx , num
    mov ah , 9
    int 21h

    mov dx , newline
    mov ah , 9
    int 21h 

    mov dx , msg1
    mov ah , 9
    int 21h

    mov dx , newline
    mov ah , 9
    int 21h

    push ax
    push ax  
    mov ax , [num]
    mov bl  , 0x2 
    div bl 

    cmp ah , 0 
    je even 
    jne odd 
    point:
        mov ax , [num]
        sub ax , 48 
        cmp ax , 2 
        je primenumber
        cmp ax , 1 
        je notprime
        
        mov bl , 2
        functionprimecheck:
        mov ax , [num]
        sub ax , 48
        div bl  
        cmp ah , 0 
        je notprime
        add bl , 1  
        mov ah , [num]
        sub ah , 48
        cmp bl , ah
        jne functionprimecheck  
        jmp primenumber 
    ret
main: 
    call fucntion
    end:
    mov ax , 0x4c00 
    int 21h 




