[org 0x0100]
jmp mainfunction
Section .data
msg db  'Enter the number you want to find factorial for: $'
msg2 db 'Output $' ,0x0a ,
nextline db 0x0a ,'$'

num dd 0 , '$'
num1 dd 0 , '$'
num2 dd 0 , '$'
num3 dd 0 , '$'
 

Section .code
mainfunction
    mov dx , msg 
    mov ah , 9 
    int 21h 
    
    mov ah, 7
    int 21h
    mov byte[num], al

    mov dx , num 
    mov ah , 9 
    int 21h 
    mov ax , [num] 
    sub ax , 30h 
    push ax 
    call factorialfunction
    ;cmp ax , 99 
    ;jg doubledigit1
    cmp ax , 9 
    jg doubledigit
    add ax, 30h
    mov [num1] , ax 
    mov dx , num1 
    mov ah , 9 
    int 21h 
    end:
	mov ax , 0x4c00 
	int 21h 
factorialfunction:
    push bp 
    mov bp ,sp 
    mov ax , [bp + 4]
    cmp ax , 0
    ja l1
    mov ax , 1 
    jmp l2
    l1:
    sub ax , 1 
    push ax 
    call factorialfunction
    returnfact:
        mov bx , [bp +4]
        mul bx 
    l2:
        mov [num2] , ax 
        pop bp
        ret 2  
doubledigit:
    mov ax , [num2]
    mov bl , 10 
    div bl
    push ax 
    cmp al , 9 
    add al , 30h 
    mov [num3] , al
    
    mov dx , num3
    mov ah , 9 
    int 21h 
    point:

    pop ax 

    add ah , 30h
    mov [num3] , ah

    mov dx , num3
    mov ah , 9 
    int 21h 
    jmp end 

doubledigit1:
    mov ax , [num2]
    mov bl , 100
    div bl 
    mov [num3] , ah
    mov dx , num3
    mov ah , 9 
    int 21h
 
    mov [num3] , al
    mov ax , [num3]

    mov ax , [num3]
    mov bl , 10 
    div bl
    push ax 
    cmp al , 9 
    add al , 30h 
    mov [num3] , al
    
    mov dx , num3
    mov ah , 9 
    int 21h 
    pop ax 
    add ah , 30h
    mov [num3] , ah

    mov dx , num3
    mov ah , 9 
    int 21h 




    jmp end



    
    




    