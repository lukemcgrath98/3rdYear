#include <iostream>			// cout
#include <time.h>			// _getch
#include <chrono>			// _getch

using namespace std;		// cout
using namespace chrono;

int nruns = 1000;



int compute_pascal(int row, int position) {
	if (position == 1) {
		return 1;
	}
	else if (position == row) {
		return 1;
	}
	else {
		return compute_pascal(row-1, position) + compute_pascal(row-1, position-1);
	}
}




int main(int argc, char* argv[]) {

	volatile int x = 30;
	int i = 0;
	auto start = high_resolution_clock::now();
	while (i < nruns) {
		compute_pascal(x, 20);
		i++;
	}
	auto end = high_resolution_clock::now();

	long double dur = duration_cast<seconds>(end - start).count();

	cout << "Took " << dur << " seconds\n";

	double time = dur / (double)nruns;

	cout << "Average " << time << " seconds\n";


	return 0;
}
