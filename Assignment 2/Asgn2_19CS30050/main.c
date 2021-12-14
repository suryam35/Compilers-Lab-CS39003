// Name : Suryam Arnav Kalra
// Roll No. : 19CS30050


#include "myl.h"

int main() {

	printStr("**** Welcome *****\n");
	printStr("INFO : ALL INVALID VALUES ARE DEFAULT TO 0\n");
	printStr("INFO : FOR INTEGER, ANYTHING AFTER THE FIRST (e) or (.) IS IGNORED\n");
	printStr("INFO : E or e both can be used\n");

	int i = 0, key;
	float f = 0;

	while(1) {
		printStr("1 : printInt() , 2 : readInt() , 3 : printFlt() , 4 : readFlt() , 5 : exit\n");
		readInt(&key);
		if(key == 5) {
			break;
		}
		if(key < 1 || key > 5) {
			printStr("Invalid input\n");
			continue;
		}
		if(key == 1) {
			printStr("The integer is : ");
			printInt(i);
		}
		if(key == 2) {
			printStr("Enter the integer : ");
			readInt(&i);
		}
		if(key == 3) {
			printStr("The float in 6 precision is : ");
			printFlt(f);
		}
		if(key == 4) {
			printStr("Enter the float : ");
			readFlt(&f);
		}
	}

	return 0;
}