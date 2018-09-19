TITLE final(1A2B.asm)
INCLUDE Irvine32.inc
main EQU start@0
.data
	head 		BYTE "Welcome to Guess Number!", 0
	question 	BYTE "Choose the Level You Want:", 0
	opt			BYTE "1. Easy(3 numbers)   2. Medium(4 numbers)   3. Hard(5 numbers)", 0
	more		BYTE "<All Numbers Are DIFFERENT, There Will be NO Same Numbers>",0
	idiot		BYTE "Come on! Don't be a fool", 0
	ask			BYTE "Enter number: ", 0
	win			BYTE "You Win!", 0
	lose		BYTE "You Lose!", 0
	inputagain	BYTE "Press Any Key to continue...",0
	continue	BYTE "Press Enter to Continue...", 0
	ans			BYTE "Answer: ", 0
	A			BYTE "A", 0
	B			BYTE "B", 0
	arrayeasy	BYTE 3 DUP(?)
	arraymedium	BYTE 4 DUP(?)
	arrayhard	BYTE 5 DUP(?)
	arrayinput	BYTE 5 DUP(?)
	
.code

main PROC
begin:	
	call Clrscr
	mov edx, OFFSET head
	call WriteString
	call Crlf
	mov edx, OFFSET question
	call WriteString
	call Crlf
	mov edx, OFFSET opt
	call WriteString
	call Crlf
	mov edx, OFFSET more
	call WriteString
	call Crlf
	;title
	call ReadInt
	cmp eax, 1
	je easy
	cmp eax, 2
	je med
	cmp eax, 3
	je hard
	mov edx, OFFSET idiot
	call WriteString
	call Crlf
	mov edx, OFFSET inputagain
	call WriteString
	call ReadChar
	jmp begin					; not1 2 3, go back to begin
easy:
	call Clrscr
	call Randomize 
	mov ecx, 6					; easy guess 6 times
	mov esi, OFFSET arrayeasy
easy1:
	mov eax, 10
	call RandomRange			; 0~9 random
	mov [esi], eax
	add esi, 1
easy2:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp eax, ebx
	je easy2
	mov [esi], eax
	add esi, 1
easy3:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp eax, ebx
	je easy3
	mov edx, [esi-2]
	movzx ebx, dl
	cmp	eax, ebx
	je easy3
	mov [esi], eax
	sub esi, 2
	mov edx, 3
	jmp gameloop
med:
	call Clrscr
	call Randomize 
	mov ecx, 8					; medium guess 8 times
	mov esi, OFFSET arraymedium
	mov eax, 10
	call RandomRange			; 0~9 random
	mov [esi], eax
	add esi, 1
med2:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je med2
	mov [esi], eax
	add esi, 1
med3:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je med3
	mov edx, [esi-2]
	movzx ebx, dl
	cmp	eax, ebx
	je med3
	mov [esi], eax
	add esi, 1
med4:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je med4
	mov edx, [esi-2]
	movzx ebx, dl
	cmp	eax, ebx
	je med4
	mov edx, [esi-3]
	movzx ebx, dl
	cmp	eax, ebx
	je med4
	mov [esi], eax
	sub esi, 3
	mov edx, 4
	jmp gameloop
hard:
	call Clrscr
	call Randomize 
	mov ecx, 10					; hard guess 10 times
	mov esi, OFFSET arrayhard
	mov eax, 10
	call RandomRange			; 0~9 random
	mov [esi], eax
	add esi, 1
hard2:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je hard2
	mov [esi], eax
	add esi, 1
hard3:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je hard3
	mov edx, [esi-2]
	movzx ebx, dl
	cmp	eax, ebx
	je hard3
	mov [esi], eax
	add esi, 1
hard4:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je hard4
	mov edx, [esi-2]
	movzx ebx, dl
	cmp	eax, ebx
	je hard4
	mov edx, [esi-3]
	movzx ebx, dl
	cmp	eax, ebx
	je hard4
	mov [esi], eax
	add esi, 1
hard5:
	mov eax, 10
	call RandomRange
	mov edx, [esi-1]
	movzx ebx, dl
	cmp	eax, ebx
	je hard5
	mov edx, [esi-2]
	movzx ebx, dl
	cmp	eax, ebx
	je hard5
	mov edx, [esi-3]
	movzx ebx, dl
	cmp	eax, ebx
	je hard5
	mov edx, [esi-4]
	movzx ebx, dl
	cmp	eax, ebx
	je hard5
	mov [esi], eax
	sub esi, 4
	mov edx, 5
	jmp gameloop
gameloop:
	push edx
	push ecx					; large loop counter(6,8,or 10)
	mov ecx, edx				; how many numbers to guess(3,4,or 5)
	mov edx, OFFSET ask
	call WriteString
	call ReadInt
	mov edx, 0
	mov edi, OFFSET arrayinput
	mov ebx, 10
	cmp ecx, 3
	je three
	cmp ecx, 4
	je four
	div ebx
	mov [edi+4], dl
	mov edx, 0
four:
	div bx
	mov [edi+3], dl
	mov dx, 0
three:
	div bl
	mov [edi+2], ah
	mov ah, 0
	div bl
	mov [edi+1], ah
	mov ah, 0
	div bl
	mov [edi], ah
	mov eax, 0
	mov ebx, 0					; how many same
digit:
	push ecx					; ecx = 3,4,or 5 for compare digits
	push esi					; outer beginning
	push edi					; outer brginning
	push ecx					; push to count A
sameposition:
	cmpsb
	je As
	loop sameposition
	jmp doneA
As:
	inc al						; al = number of A
	loop sameposition
doneA:
	pop ecx						; pop to count B
	cmp al, cl
	je finish1
	pop edi
	pop esi
	mov ebx, 0					; ebx = digit for input
countB:	
	mov edx, 0					; edx = digit for random
	push esi
compare:
	push edx
	mov dl, [edi]
	cmp dl, [esi]
	je	check
	add esi, 1
	pop edx
	inc edx						; next digit for random
	loop compare
	jmp nextdigit
check:
	pop edx
	cmp edx, ebx
	jne Bs
	loop compare
	jmp nextdigit
Bs: 
	inc ah						; ah = number of B
	inc edx
	add esi, 1
	loop compare
nextdigit:
	pop esi
	pop ecx						; pop to check if all compared
	inc ebx						; next digit for input counter
	cmp ebx, ecx				; all digits compared
	je done
	add edi, 1					; next digit for input
	push ecx
	jmp countB
done:
	mov ebx, eax
	movzx eax, bl
	call WriteDec
	mov edx, OFFSET A
	call WriteString
	movzx eax, bh
	call WriteDec
	mov edx, OFFSET B
	call WriteString
	call Crlf
	pop ecx
	pop edx
	dec ecx
	cmp ecx, 0
	je finish2
	jmp gameloop
finish1:
	pop edi
	pop esi 
	pop ecx
	pop ecx
	pop edx
	mov ebx, eax
	movzx eax, bl
	mov ecx, edx
	call WriteDec
	mov edx, OFFSET A
	call WriteString
	movzx eax, bh
	call WriteDec
	mov edx, OFFSET B
	call WriteString
	call Crlf
	mov edx, OFFSET win
	call WriteString
	call Crlf
	mov edx, OFFSET ans
	call WriteString
	cmp ecx, 3
	je print3
	cmp ecx, 4
	je print4
	add esi, 4
	mov ebx, [esi-4]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-3]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-2]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-1]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi]
	movzx eax, bl
	call WriteDec
	sub esi, 4
	call Crlf
	mov edx, OFFSET continue
	call WriteString
	jmp wait1
print4:
	add esi, 3
	mov ebx, [esi-3]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-2]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-1]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi]
	movzx eax, bl
	call WriteDec
	sub esi, 3
	call Crlf
	mov edx, OFFSET continue
	call WriteString
	jmp wait1
print3:
	add esi, 2
	mov ebx, [esi-2]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-1]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi]
	movzx eax, bl
	call WriteDec
	sub esi, 4
	call Crlf
	mov edx, OFFSET continue
	call WriteString
	jmp wait1
wait1:
	call ReadChar
	cmp ax, 1C0Dh
	je begin
	jmp wait1
finish2:
	mov ecx, edx
	mov edx, OFFSET lose
	call WriteString
	call Crlf	
	mov edx, OFFSET ans
	call WriteString
	cmp ecx, 3
	je print3two
	cmp ecx, 4
	je print4two
	add esi, 4
	mov ebx, [esi-4]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-3]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-2]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-1]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi]
	movzx eax, bl
	call WriteDec
	sub esi, 4
	call Crlf
	mov edx, OFFSET continue
	call WriteString
	jmp wait2
print4two:
	add esi, 3
	mov ebx, [esi-3]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-2]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-1]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi]
	movzx eax, bl
	call WriteDec
	sub esi, 3
	call Crlf
	mov edx, OFFSET continue
	call WriteString
	jmp wait2
print3two:
	add esi, 2
	mov ebx, [esi-2]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi-1]
	movzx eax, bl
	call WriteDec
	mov ebx, [esi]
	movzx eax, bl
	call WriteDec
	sub esi, 4
	call Crlf
	mov edx, OFFSET continue
	call WriteString
	jmp wait2
wait2:
	call ReadChar
	cmp ax, 1C0Dh
	je begin
	jmp wait2
	
	

main ENDP
END main
	
	
	
