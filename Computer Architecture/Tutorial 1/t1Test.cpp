// t1Test.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
#include "t1.h"

//
//Array sum through inline assembly
//
int array_proc_inline(int array[], int n)
{
	_asm {
		mov esi, array	// address of input_array
		mov ecx, n		// input_array size
		mov eax, 0		// clearing the accumulator
		L1 : add eax, [esi]
			 add esi, 4
			 loop L1
	}
}

//
// Multiple_k
//
void multiple_k(uint16_t N, uint16_t K, uint16_t* array)
{
	for (uint16_t i = 0; i < N; ++i)
	{
		if ((i + 1) % K == 0)
		{
			array[i] = 1;
		}
		else
		{
			array[i] = 0;
		}
	}
}

//
// check
//
void check(const char *s, int v, int expected) {
	std::cout << s << " = " << v;
	if (v == expected) {
		std::cout << " OK";
	}
	else {
		std::cout << " ERROR: should be " << expected;
	}
	std::cout << "\n";
}

int main() {

	// Evaluating the procedures
	//
	// t1
	//
	// Polynomial evaluation
	check("poly(2)", poly(2), 7);
	check("poly(3)", poly(3), 13);
	check("poly(-1)", poly(-1), 1);
	check("poly(-2)", poly(-2), 3);

	// Factorial evaluation
	check("factorial(5)", factorial(5), 120);
	check("factorial(4)", factorial(4), 24);
	check("factorial(10)", factorial(7), 5040);
	check("factorial(6)", factorial(6), 720);

	// Multiple_k evluation
	uint16_t K1 = 3;
	const uint16_t N1 = 10;
	uint16_t array_N1[N1];
	uint16_t array_N2[N1];
	std::cout << "Array of multiples by Assembly: \n";
	multiple_k_asm(N1, K1, array_N1);
	for (uint16_t i = 0; i < N1; ++i)
		std::cout << array_N1[i] << " ";

	std::cout << "\n";

	std::cout << "Array of multiples by C++: \n";
	multiple_k(N1, K1, array_N2);
	for (uint16_t i = 0; i < N1; ++i)
		std::cout << array_N2[i] << " ";

	std::cout << "\n";

	uint16_t K2 = 7;
	const uint16_t N2 = 50;
	uint16_t array_N3[N2];
	uint16_t array_N4[N2];
	std::cout << "Array of multiples by Assembly: \n";
	multiple_k_asm(N2, K2, array_N3);
	for (uint16_t i = 0; i < N2; ++i)
		std::cout << array_N3[i] << " ";

	std::cout << "\n";

	std::cout << "Array of multiples by C++: \n";
	multiple_k(N2, K2, array_N4);
	for (uint16_t i = 0; i < N2; ++i)
		std::cout << array_N4[i] << " ";

	std::cout << "\n";

	getchar();

	return 0;
}