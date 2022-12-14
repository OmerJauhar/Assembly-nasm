[org 0x0100]
jmp start
Section .data
msg db  'Enter Table No:    $'
msg1 db 'Enter Table Limit: $'
msg2 db 'Output: $' ,0x0a ,
msg3 db 'Error! Try Again [0 - 9] $'
newline db 0x0a ,'$'
sterik db '*  $'
isequal db '=   $'

num dd 0 , '$'
num1 dd 0 , '$'
num2 dd 49 , '$'
num3 dd 0 , '$'
 

Section .code


printtable:
    mov dx , msg 
    mov ah , 9 
    int 21h 
    
    mov ah, 7
    int 21h
    mov byte[num], al
    
    ;mov al , [num]
    ;cmp al , 0x0A
    ;jnl error


    mov dx , num
    mov ah , 9
    int 21h 
    
    mov dx , newline
    mov ah , 9 
    int 21h 

    mov dx , msg1 
    mov ah , 9 
    int 21h 
    
    mov ah , 7 
    int 21h 
    mov byte[num1] , al 
    
    ;mov ax , [num]
    ;cmp ax , 0x0A
    ;jnl error

    mov dx , num1
    mov ah , 9
    int 21h 

    mov dx , newline 
    mov ah , 9 
    int 21h 
    
    
    mov dx , msg2
    mov ah , 9 
    int 21h 
    
    mov dx , newline 
    mov ah , 9 
    int 21h 

    mov cx , [num1]

     sub cx , 30h
    
    outputfunc:
        
        mov dx , num
        mov ah , 9 
        int 21h 
        
        mov dx , sterik
        mov ah , 9 
        int 21h 

        mov dx , num2
        mov ah , 9 
        int 21h

        
        mov dx , isequal
        mov ah , 9 
        int 21h 


        mov ax , [num]
        mov bx , [num2]
        sub ax , 30h 
        sub bx , 30h 
        mul bx 

        cmp ax , 9 
        jg doubledigit

        add ax , 30h
        mov [num3] , ax
        
        
        mov dx , num3
        mov ah , 9 
        int 21h 
        point:
        mov dx , newline 
        mov ah , 9 
        int 21h 

        mov ax , [num2]
        sub ax , 30h 
        add ax , 1 
        add ax, 30h 
        mov [num2] , ax 

        loop outputfunc

    ret 

start:
    call printtable
    mov ah, 4ch
    int 21h

doubledigit:
    mov bl , 10 
    div bl
    push ax 
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

    jmp point

printchr:
    mov  cx, 1       ; ReplicationCount
    mov  bx, 0007h    ; BH is DisplayPage (0) , BL is Attribute (BrightWhiteOnGreen)
    mov  ah, 09h    ; BIOS.WriteCharacterAndAttribute, AL is ASCII ("*")
    mov  al, 2ah
    int  10h
ret 


error:
    mov dx , msg1 
    mov ah , 9 
    int 21h 
    jmp printtable