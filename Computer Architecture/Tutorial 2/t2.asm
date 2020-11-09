includelib legacy_stdio_definitions.lib
extrn printf:near
extrn scanf:near

;; Data segment
.data
public inp_int
	inp_int BYTE "%lld", 00h
	prompt_message BYTE "Enter an integer: ", 0
	scan_format BYTE "%lld", 0
	print_message BYTE "The sum of proc. and user inputs (%lld, %lld, %lld, %lld): %lld", 0Ah, 00h

;; Code segment
.code

public fibX64

fibX64:
			push rbp
			mov rbp, rsp
			cmp rcx, 0							; fin < 0
			jl isless
			cmp rcx, 0							; fin = 0
			jz iszero
			cmp rcx, 1							; fin = 1
			jz isone

			sub rsp, 32							; to make space for local variables

			mov [rbp-8], rcx					; save initial value (fin)

			sub rcx, 1							; fin-1
			call fibX64							; fibX64(fin-1)

			mov [rbp-16], rax					; save fibX64(fin-1)
			mov rcx, [rbp-8]					; restore fin

			sub rcx, 2							; fin-2
			call fibX64							; fibX64(fin-2)

			mov rcx, [rbp-16]					; fib64(fin-1) moved to rcx
			add rax, rcx						; fibX64(fin-2) + fibX64(fin-1)

			leave
			ret

isless:
			pop rbp
			ret

iszero:
			mov rax, 0
			pop rbp
			ret

isone:
			mov rax, 1
			pop rbp
			ret


public use_scanf

use_scanf:
			xor rax, rax
			add rax, rcx
			add rax, rdx
			add rax, r8							; rax = sum

			mov [rsp+32], rax							; preserving sum
			mov [rsp+24], rcx							; preserving a
			mov [rsp+16], rdx							; preserving b
			mov [rsp+8], r8								; preserving c

			sub rsp, 56									; subtracting shadow space
			lea rcx, prompt_message						; load message to print
			call printf									

			lea rcx, scan_format						; load the format to scan a number
			lea rdx, inp_int							; load the address for inp_int
			call scanf

			lea rsi, inp_int							; address where number is stored
			mov rdx, [rsi]								; rdx = inp_int
			mov rax, [rsp+88]							; retrieving sum value
			add rax, rdx								; sum = sum + inp_int
			mov [rsp+96], rax							; preserve sum
			mov [rsp+40], rax							; 6th argument = sum
			mov [rsp+32], rdx							; 5th argument = inp_int
			mov r9, [rsp+64]							; 4th argument = c
			mov r8, [rsp+72]							; 3rd argument = b
			mov rdx, [rsp+80]							; 2nd argument = a
			lea rcx, print_message						; 1st argument = string to print
			call printf

			add rsp, 56									; restore shadow space

			mov rax, [rsp+40]							; restore sum to return
			ret
			
public max

max:
			xor rax, rax								
			mov rax, rcx								; v = a
			cmp rdx, rax								; if b > v
			jg bgreater
			cmp r8, rax									; if c > v
			jg cgreater
			ret

bgreater:
			mov rax, rdx								; v = b
			cmp r8, rax									; if c > v
			jg cgreater
			ret

cgreater:
			mov rax, r8									; v = c
			ret

public max5

max5:
			mov [rsp+32], r8							; preserving k
			mov [rsp+24], r9							; preserving l
			lea rsi, inp_int							; address of inp_int
			mov r8, [rsi]								; r8 = inp_int 
			call max									; call max for rcx = i, rdx = j, r8 = inp_int
			mov rcx, rax								; rcx = max(i,j,inp_int)
			mov rdx, [rsp+32]							; rdx = k
			mov r8, [rsp+24]							; r8 = l
			call max									; max(max(i,j,inp_int),k,l)
			ret
			


end