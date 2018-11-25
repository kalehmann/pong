%define BLUE 1
%define RED 4

set_video_mode:
        ; This function sets the video mode
        mov ah, 00h		; Interrupt, set video mode
	mov al, 013h		; 320 x 200 pixels, 256 colors
	int 010h
        ret
	
print_score:
	; THIS FUNCTION PRINTS AN UNSIGNED INTEGER FROM THE AX REGISTER WITH THE
	; COLOR FROM THE BL REGISTER.

	add ax, 61h			; Get ascii code of int
	mov ah, 09h
	mov bh, 0			; Page 0
	mov cx, 1			; Times to print : 1
	int 10h

	ret

draw_rect:
	; This function draws a rectangle.
	;
	; It takes five args:
	;  - the x-position of the left-top corner on the stack
	;  - the y-position of the left-top corner on the stack
	;  - the width of the rectangle on the stack
	;  - the height of the rectangle on the stack
	;  - the color of the rectangle in ah

	mov cx, 0A000h
	mov es, cx

	pop di			; return address
	pop dx
	pop cx
	pop bx
	pop si
	push di

	mov bp, sp		; setup stack frame
        sub sp, 11		; allocate 11 bytes on stack
	mov [bp-11], ah		; save all args on stack
	
	mov [bp-2], si
	mov [bp-4], bx
	mov [bp-6], cx
	inc dx			; Increment the height by 1. This makes the loop
	mov [bp-8], dx		; shorter.

	inc cx			; Here we are initializing a helper variable for
	mov [bp-10], cx		; a loop over the width of the rectangle.

	; MEMORYMAP:
	; |---------------------| <- [bp]
	; | x-top-left		|
	; |---------------------| <- [bp-2]
	; | y-top-left		|
	; |---------------------| <- [bp-4]
	; | width		|
	; |---------------------| <- [bp-6]
	; | height		|
	; |---------------------| <- [bp-8]
	; | loop-var for width	|
	; |---------------------| <- [bp-10]
	; | color		|
	; |---------------------| <- [bp-11] ; [sp]


	; LOOP OVER heigth
.height_loop:
	cmp word [bp-8], 0
	je .draw_rect_done
	
	; DECREMENT HEIGHT STORED IN STACK
	mov ax, [bp-8]
	dec ax
	mov [bp-8], ax

	; RESTORE WIDTH-HELPER-VAR
	mov ax, [bp-6]
	mov [bp-10], ax

	; LOOP OVER width	
.width_loop:			
		cmp word [bp-10], 0
		je .height_loop
                mov cx, [bp-2]	; Calculate the coordinates of the pixel, we
                add cx, [bp-10]	; draw to. The x-value is x-top-left + width and
		mov dx, [bp-4]	; the y-value is y-top-left + height.
                add dx, [bp-8]	; x-value is stored in cx and y-value in dx
		
		; SET PIXEL ON SCREEN
		mov ax, dx
		mov bx, 320
		mul bx
		add ax, cx
		mov bx, ax
		mov cl, [bp-11]
		mov [es:bx], cl

		; DECREMENT WIDTH-HELPER-VAR
		mov ax, [bp-10]
		dec ax
		mov [bp-10], ax

		jmp .width_loop
		
.draw_rect_done:
	add sp, 11		; free 11 bytes on stack
	ret
