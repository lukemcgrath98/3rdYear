.686 ;; identifies this as a 32 bit assembly
.model flat, C;; define the memory model and calling convention

;; Two sections

.data

.code

public pow;; makes the function visible to the C++ compiler

pow:

	push ebp							;; push base pointer onto stack 
	mov ebp, esp						;; establishing the stack frame

	mov ecx, [ebp+12]					;; arg1
	mov ebx, [ebp+8]					;; arg0
	mov eax, 1							;; result = 1
	mov edx, 1							;; i = 1
 
L1: cmp edx, ecx						;; while i < arg1 
	jg retpow
	imul eax, ebx						;; result = result * arg0
	add edx, 1							;; i++
	jmp L1

retpow:
	
	mov esp, ebp						;; moving the value of the base pointer back to the stack
	pop ebp								;; restore base pointer
	ret 

public poly

poly:
	push ebp							;; push base pointer onto stack
	mov ebp, esp						;; establishing stack frame

	mov ebx, [ebp+8]					;; arg
	mov edx, 2							;; because 2 will be the parameter to pass into pow function to square the other parameter

	push edx							;; argument for pow function pushed onto stack
	push ebx							;; argument for pow function pushed onto stack
	call pow
	add esp, 8							;; clear parameters

	add eax, ebx						;; add x to result
	add eax, 1							;; add 1 to result

	mov esp, ebp						;; moving the value of the base pointer back to the stack
	pop ebp								;; restore base pointer
	ret

public ismultiple

ismultiple:

	push ebp							;; push base pointer onto stack
	mov ebp, esp						;; establishing stack frame
	push ebx							;; saving volatile register
	push edx							;; saving volatile register
	xor edx, edx						;; clearing edx
	mov ebx, [ebp+12]					;; first parameter
	mov eax, [ebp+8]					;; second parameter

	idiv ebx							;; divide two numbers
	cmp edx, 0							;; jump if remainder is not zero
	jne notzero
	mov eax, 1							;; 1 indicates that the number is a multiple
	jmp fin

notzero: 
	mov eax, 0							;; 0 indicates that the number is not a multiple

fin:
	pop edx								;; restore this register
	pop ebx								;; restore this register
	mov esp, ebp						;; moving the value of the base pointer back to the stack
	pop ebp								;; restore base pointer
	ret

public multiple_k_asm

multiple_k_asm:
	push ebp							;; push base pointer onto stack
	mov ebp, esp						;; establishing stack frame
	push esi							;; saving return address

	mov esi, [ebp+16]					;; first parameter = array address
	mov ebx, [ebp+12]					;; second parameter = K
	mov ecx, [ebp+8]					;; third parameter = N
	mov edx, 0							;; i = 0

X1:
	cmp edx, ecx						;; while i < N
	jge retmul							
	add edx, 1							;; i++
	push ebx							;; push parameter onto stack
	push edx							;; push parameter onto stack
	call ismultiple					
	mov [esi], eax						;; replace value with 0 or 1 depending on result of function division
	add esi, 2							;; move to next value in the array
	add esp, 8							;; clear these parameters from the stack
	jmp X1

retmul:
	mov esp, ebp						;; moving the value of the base pointer back to the stack
	pop ebp								;; restore base pointer
	ret

public factorial

factorial:
	push ebp							;; push base pointer onto stack
	mov ebp, esp						;; establishing stack frame

	mov eax, [ebp+8]					;; get parameter from the stack
	dec eax								;; decrement parameter

	cmp eax, 0							;; check if zero
	je F1

	push eax							;; push parameter onto stack
	call factorial
	add esp, 4							;; update stack pointer

	imul eax, [ebp+8]					;; multiply parameter by result
	jmp retfac

F1:
	mov eax, 1

retfac:
	mov esp, ebp						;; moving the value of the base pointer back to the stack
	pop ebp								;; restore base pointer
	ret

end