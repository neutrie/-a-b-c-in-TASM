.model small
.stack 100h
.data
	promptA db 13, 10, 'Enter A: $'
	promptB db 13, 10, 'Enter B: $'
	promptC db 13, 10, 'Enter C: $'
	promptResult db 13, 10, 'Result: $'
	
	numA db ?
	numB db ?
	numC db ?
.code
start:
	mov ax, @data
	mov ds, ax

	mov ah, 09h ; prompt
	mov dx, offset promptA
	int 21h
	
	mov ah, 01h ; enter A
	int 21h
	sub al, '0'
	mov numA, al
	
	mov ah, 09h ; prompt
	mov dx, offset promptB
	int 21h

	mov ah, 01h ; enter B
	int 21h
	sub al, '0'
	mov numB, al

	mov ah, 09h ; prompt
	mov dx, offset promptC
	int 21h

	mov ah, 01h ; enter C
	int 21h
	sub al, '0'
	mov numC, al


	mov al, numA ; al = A
	add al, numB ; al = A + B
	mul numC ; ax = al * numC = (A + B) * C
	push ax ; store result
	
	mov ah, 09h ; prompt
	mov dx, offset promptResult
	int 21h
	
	pop ax ; restore result
	
	call OutInt ; print multidigit number
	
	mov ah, 4ch ; terminate
	int 21h
	
	OutInt proc

		xor cx, cx
		mov bx, 10 ; notation
		split:
			xor dx, dx
			div bx ; ax = ax/bx, dx = ost (digit)
			push dx ; store most right digit
			inc cx ; digit_count++
			test ax, ax ; number == 0?
			jnz split

			mov ah, 02h
		show:
			pop dx ; restore most left digit
			add dl, '0'
			int 21h
		loop show
	ret
	OutInt endp
end start
	