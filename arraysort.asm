org 100h

SECTION .TEXT
jmp start
Section .data
msg db 0x0a , 'Enter 10 integers: $'  
data1: db 'Sorted:'
msg1end:
num dd 0 , '$'
data db 11, 0
resb 11
swapflag: db 0  
Section .code
start:
    call setcursor
    mov dx , msg 
    mov ah , 9 
    int 21h
    call getArray
    mov cx , [data + 1]
    mov si , 2 
    
    mainloop:
    mov si , 2 
    mov byte[swapflag] , 0 
    innerloop:
    mov al , [data + si]
    
    sub al , 30h 
    mov bl ,[data+si+1]
    sub bl , 30h 
    cmp al , bl 
    jng noswap
    add al , 30h 
    mov [data + si + 1], al 
    add bl , 30h 
    mov [data + si] , bl 
    mov byte[swapflag] , 1
    noswap:
        add si , 1 
        cmp si , 11 
        jl innerloop
    cmp byte[swapflag] , 1 
    je mainloop

    mov cl , [num]
    sub cl , 30h 
    call printstr
    call printArray
    call exit
exit:
mov ax, 0x4c00 ; terminate program
int 0x21
printArray:
	xor cx  , cx 
    mov cl ,[data + 1]; calculate message size.
    ;mov  bx, 0001h    ; BH is DisplayPage (0) , BL is Attribute (BrightWhiteOnGreen)
    mov al, 1    
    mov bh, 0
    mov bl, 07  ; color the text and background
    mov dh, 23         ; Row number 12
    mov dl , 8        ; Column No 20
    push cs
    pop es
    mov bp,  data+2
    mov ah , 13h      ; To print string on screen we use 13h function
    int  10h
    mov  ah, 00h      ; BIOS.WaitKeyboardKey
    int  16h          ; -> AX
ret
setcursor:
    ;mov  dx, 0C23h    ; DH is Row (12), DL is Column (35)
    mov dh, 21         ; Row number 12
    mov dl , 0        ; Column No 35
    mov  bh, 0        ; DisplayPage
    mov  ah, 02h      ; BIOS.SetCursorPosition (set cursor position function)
    int  10h   ; interput to BIOS Display memory service to apply changes.
    
    mov  ah, 00h      ; BIOS.WaitKeyboardKey
    int  16h          ; -> AX
ret 
getArray:
    mov cx, 10
    mov  dx, data    ; a structured input buffer - see below
    mov  ah, 0x0a       ; DOS input-string function
    int  0x21           ; DOS services interrupt
    ret
printstr:

    mov cx, msg1end - data1 ; calculate message size.
    ;mov  bx, 0001h    ; BH is DisplayPage (0) , BL is Attribute (BrightWhiteOnGreen)
    mov al, 1    
    mov bh, 0
    mov bl, 07  ; fore and background color
    
    mov dh, 23         ; Row number 12
    mov dl , 0      ; Column No 15
    push cs
    pop es
    mov bp,  data1
    mov ah , 13h      ; To print string on screen we use 13h function
    int  10h

    mov  ah, 00h      ; BIOS.WaitKeyboardKey
    int  16h          ; -> AX
ret 
