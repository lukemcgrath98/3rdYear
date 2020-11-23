#include <iostream>			// cout
#include <chrono>			// _getch
#include <time.h>			// _getch

using namespace std;		// cout
using namespace chrono;

int nwindows;

int calls = 0;
int depth = 0;
int maxDepth = 0;

int overflows = 0;
int underflows = 0;

int windowsInUse = 2;

void overflowCheck() {
	calls++;
	depth++;
	if (depth > maxDepth) {
		maxDepth = depth;
	}
	if (windowsInUse == nwindows) {
		overflows++;
	}
	else {
		windowsInUse++;
	}
}

void underflowCheck() {
	depth--;
	if (windowsInUse == 2) {
		underflows++;
	}
	else {
		windowsInUse--;
	}
}

int pascalwithchecks(int row, int position) {
	overflowCheck();
	int ret;
	if (position == 1) {
		ret = 1;
	}
	else if (position == row) {
		ret = 1;
	}
	else {
		ret = pascalwithchecks(row - 1, position) + pascalwithchecks(row - 1, position - 1);
	}
	underflowCheck();
	return ret;
}

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
	int windows[3] = { 6, 8, 16 };
	for (int i = 0; i < 3; i++) {
		nwindows = windows[i];
		pascalwithchecks(30, 20);
		printf("compute_pascal(30,20) -> number of windows: %d", nwindows);
		printf("\nNumber of Calls: %d\nMaximum Register Window Depth: %d\nOverflows: %d\nUnderflows: %d\n", calls, maxDepth, overflows, underflows);
		printf("\n");
		calls = 0;
		depth = 0;
		maxDepth = 0;
		overflows = 0;
		underflows = 0;
	}

}
