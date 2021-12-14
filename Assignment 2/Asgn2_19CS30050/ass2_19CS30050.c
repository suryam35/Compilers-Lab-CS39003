// Name : Suryam Arnav Kalra
// Roll No. : 19CS30050

#include "myl.h"

int printStr(char *input) {
	int length_of_input = 0;    // initialize length to 0
	char current = input[length_of_input];  // current character we are looking at
	while(current != '\0') {    // iterate till the character is not null
		length_of_input++;
		current = input[length_of_input];
	}

	__asm__ __volatile__ (              //inline assembly code to print string to stdout
        "movl $1, %%eax \n\t"      
        "movq $1, %%rdi \n\t"
        "syscall        \n\t"
        :
        :"S"(input), "d"(length_of_input)  // pass the array and length as inputs    
    );

    return length_of_input;   // return the length of the string
}

int printInt(int n) {
	char input[20];   // max size of input integer array
	int i = 0;
	int length;
	int is_zero = 0;
	int is_least = 0;
	if(n == 0) {     // checking if the input number is 0
		input[i++] = '0';
		length = 1;
		is_zero = 1;
		if(is_zero) {
			length = 1;
		}
	}
	else {
		int is_negative = 0;   // to see if the input number is negative
		if(n < 0) {
			if(n == -(1ll << 31)) {
				n++;
				is_least = 1;
			}
			input[i++] = '-';    // if it was negative make it positive and store - sign
			n = -n;
			is_negative = 1;
		}
		while(n) {   // iterate till the number does not become zero
			int last = n%10;    // get the last digit of the number
			input[i++] = (char)(last+'0');
			n/= 10;    // divide by 10
		}
		length = i;
		int start = 0;    // tells the start from where to reverse the array 
		if(is_negative) {
			start = 1;
		}
		else {
			start = 0;
		}
		int end = i-1;
		// we need to reverse the array since digits are entered in reverse order
		while(start < end) {
			// swap the start and end characters
			char temp;
			temp = input[start];
			input[start++] = input[end];
			input[end--] = temp; 
		}
	}

	if(is_least == 1) {
		input[length-1]++;
	}
	input[length++] = '\n';   // add new line character to the end of the input number

	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(input), "d"(length)         //print the number stored in input
    );
    return length;    // return the length of the input number
}

int readInt(int *num) {
	int MAX_SIZE = 20;    // maximum size of input array
	char input[MAX_SIZE];
	int i = 0;
	int length = 0;
	__asm__ __volatile__ (          //inline assembly
        "movl $0, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(input), "d"(MAX_SIZE)           //take the number into input character array
	);

	char current;   // current character we are looking at
	current = input[i];
	while(current != '\n' && current != '.' && current != 'E' && current != 'e') {   // iterate till we get the end of the integer
		i++;
		current = input[i];
		length = i;
	}

	input[i] = '\0';   // add null character to the end for easy retrieval of integer
	length = i;
	i = 0;
	int is_positive = 1;
	// block to check whether the input integer is invalid or not
	int is_invalid = 0;
	int have_negative_sign = 0 , have_positive_sign = 0;
	if(input[0] == '-') {
		// if only negative sign is entered without any value, it is invalid
		have_negative_sign = 1;
		have_positive_sign = 0;
		if(input[1] == '\0') {
			*num= 0;
			is_invalid = 1;
			if(is_invalid) {
				return ERR;
			}
		}
		else {    // here we set i to 1 to ignore the sign
			i = 1;
			is_invalid = 0;
		}
	}
	if(input[0] == '+') {
		// if only positive sign is entered without any value, it is invalid
		have_positive_sign = 1;
		have_negative_sign = 0;
		if(input[1] == '\0') {
			*num= 0;
			is_invalid = 1;
			return ERR;
		}
		else {    // here we set i to 1 to ignore the sign
			i = 1;
			is_invalid = 0;
		}
	}

	int has_sign = 0;
	if(have_positive_sign || have_negative_sign || is_positive == 0) {
		has_sign = 1;    // if the given input has any sign we check for it here
	}

	if(has_sign || length == 0) {
		length = 1;
	}

	*num = 0;
	current = input[i];   // we iterate over the digits to build the number
	while(current != '\0') {
		if(current >= '0' && current <= '9') {    // if it is a  valid digit
			(*num) = (*num)*10;
			(*num) = (*num) + (int)(current - '0');
			i++;
			current = input[i];
			length = i;
		}
		else {
			is_invalid = 1;   // if the character is anything other than digit, the input number is invalid
			(*num) = 0;
			length = 1;
			return ERR;
		}
	}

	if(input[0] == '-') {    // if the input number is negative, we need to make our calculated number negative as well
		(*num) = (*num)*-1;
	}

	return OK;  // return ok if everything went well
}

int readFlt(float *f) {
	int MAX_FLOAT_SIZE = 70;   // limit on float size to be read as input
	char input[MAX_FLOAT_SIZE];

	__asm__ __volatile__ (
        "movl $0, %%eax \n\t" 
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(input), "d"(MAX_FLOAT_SIZE)             //take floating point number in input array
    );

	// block to find the length of the input array
    int i = 0;
    int length = 0;
    char current = input[i];
    while(current != '\n') {   // iterate till the character is not a new line character
    	i++;
    	current = input[i];
    	length = i;
    }

    input[i] = '\0';    // set the end of the input array to null character
    length = i;
    i = 0;

    int have_negative_sign = 0 , have_positive_sign = 0;
    int is_invalid = 0;
    int has_sign = 0;

    // block to check if the number is invalid or has sign with it
    if(input[0] == '-') {
    	// if only - sign is given as input then the number is invalid
    	have_negative_sign = 1;
    	have_positive_sign = 0;
    	if(input[1] == '\0') {
    		*f = 0;
    		is_invalid = 1;
    		return ERR;
    	}
    	else {
    		i = 1;
    		is_invalid = 0;
    	}
    }
    if(input[0] == '+') {
    	// if only positive sign is given as input then the number is invalid
    	have_positive_sign = 1;
    	have_negative_sign = 0;
    	if(input[1] == '\0') {
    		*f = 0;
    		is_invalid = 1;
    		return ERR;
    	}
    	else {
    		i = 1;
    		is_invalid = 0;
    	}
    }

    if(have_positive_sign || have_negative_sign) {  // if the given input has sign we check it here
    	has_sign = 1;
    }
    else {
    	has_sign = 0;
    }

    *f = 0;
    // in this block we form the integer part of the floating number
    while(input[i] != '\0' && input[i] != '.' && input[i] != 'E' && input[i] != 'e') {
    	if(input[i] >= '0' && input[i] <= '9') {   // if it is a valid digit we add it to the result
    		(*f) = (*f)*10;
    		(*f) = (*f) + (int)(input[i] - '0');
    		i++;
    		length = i;
    	}
    	else {
    		is_invalid = 1;   // if the character was anything other than digit then the number is invalid
    		(*f) = 0;
    		if(is_invalid || has_sign || length == 0) {
    			length = 1;
    		}
    		return ERR;
    	}

    }
    // block to check if we only had integer part given to the float
    int have_reached_end = 0;
    if(input[i] == '\0') {
    	have_reached_end = 1;
    	if(input[0] == '-') {   // if the input number was negative we need to make our calculated number negative as well
    		(*f) = - (*f);
    	}
    	return OK;   // return OK as everything is fine if the code reached here
    }

    int has_decimal = 0;
    if(have_reached_end == 0) {   // if we have not reached the end of input then there is decimal part as well
    	has_decimal = 1;
    }

    if(input[i] == 'E' || input[i] == 'e') {
    	i++;
    	if(input[i] == '\0') {
    		// (*f) = 0;
    		return OK;
    	}
    	int is_E_negative = 0;    // checking if E value is negative
	    if(input[i] == '+' || input[i] == '-') {
	    	if(input[i] == '-') {
	    		is_E_negative = 1;
	    	}
	    	i++;
	    }
	    if(input[i] == '\0') {
	    	(*f) = 0;
	    	return ERR;
	    }
    	int E_part = 0;    // forming the E value
	    while(input[i] != '\0' && input[i] != '.') {
	    	if(input[i] >= '0' && input[i] <= '9') {
	    		E_part = E_part*10 + (int)(input[i] - '0');
	    		i++;
	    	}
	    	else {
	    		(*f) = 0;
	    		return ERR;
	    	}
	    }
	    float E_p = 1;    // forming 10 power E_value
	    for(int i = 0 ; i < E_part ; i++) {
	    	E_p *= 10;
	    }
	    if(is_E_negative == 1) {   // if positive E_value multiply
	    	(*f) /= E_p;
	    }
	    else {    // else divide
	    	(*f) *= E_p;
	    }
	    if(input[0] == '-') {
	    	(*f) *= -1;
	    }
	    return OK;
    }

    i++;   // increment the iterator past the decimal point

    int point = i;
    float dec_length = 1;
    int length_of_decimal = -1;
    if(has_decimal) {
    	length_of_decimal++;
    }
    while(input[i] != '\0' && input[i] != 'E' && input[i] != 'e') {
    	dec_length *= 0.1;   // this helps us to get the length of the decimal part
    	length_of_decimal++;
    	i++;
    }

    float dec_value = 0;
    i = point;

    while(input[i] != '\0' && input[i] != 'E' && input[i] != 'e') {
    	if(input[i] >= '0' && input[i] <= '9') {   // if it is a digit use it to make the decimal part
    		dec_value *= 10;
    		dec_value += (int)(input[i] - '0');
    		i++;
    		length = i;
    	}
    	else {
    		is_invalid = 1;   // if the character is anything other than digit, then the number is invalid
    		(*f) = 0;
    		length = 1;
    		return ERR;
    	}
    }

    dec_value *= dec_length;  // get the decimal value of the floating point number
    (*f) += dec_value;

    if(input[i] == '\0') {
	    if(input[0] == '-') {   // if the input was negative, we make our calculated number negative as well
	    	(*f) *= -1;
	    }
    	return OK;   // return OK 
    }
    i++;
    if(input[i] == '\0') {
    	return OK;
    }
    int is_E_negative = 0;   // checking if after E there is sign
    if(input[i] == '+' || input[i] == '-') {
    	if(input[i] == '-') {
    		is_E_negative = 1;
    	}
    	i++;
    }
    if(input[i] == '\0') {
    	(*f) = 0;
    	return ERR;
    }
    int E_part = 0;   // calculate the value after E
    while(input[i] != '\0' && input[i] != '.') {
    	if(input[i] >= '0' && input[i] <= '9') {
    		E_part = E_part*10 + (int)(input[i] - '0');
    		i++;
    	}
    	else {
    		(*f) = 0;
    		return ERR;
    	}
    }
    float E_p = 1;   // make the power of 10
    for(int i = 0 ; i < E_part ; i++) {
    	E_p *= 10;
    }
    if(is_E_negative == 1) {   // if E was negative we need to divide
    	(*f) /= E_p;
    }
    else {     // else we need to multiply
    	(*f) *= E_p;
    }
    if(input[0] == '-') {
    	(*f) *= -1;
    }
    return OK;
}

int printFlt(float f) {
	int MAX_FLOAT_SIZE = 70;   // limit on the maximum size of float that is taken as input
	char input[MAX_FLOAT_SIZE];

	int int_part = f;   // get the integer part of the floating number

	int i = 0;
	int digit;
	int length = 0;
	int is_int_part_zero = 0;   // to check if the integer part is zero or not.

	if(int_part == 0) {
		input[0] = '0';   // add 0 to the input array
		i++;
		is_int_part_zero = 1;
		if(is_int_part_zero) {
			length = i;
		}
	}
	
	int is_negative = 0 , is_positive = 1;
	if(f < 0) {   // if the input was negative, we need to make the integer part positive for proper retreival of digits
		input[i] = '-';
		int_part = -int_part;
		i++;
		length = i;
		is_negative = 1;
		if(is_negative) {
			is_positive = 0;
		}
	}

	while(int_part) {   // make the integer part of the number
		digit = int_part % 10;
		input[i] = (char)(digit + '0');
		i++;
		int_part /= 10;
		length = i;
	}
	// start denotes the starting point in the array from where we need to reverse the digits
	int start = 0;

	if(input[0] == '-') {
		start = 1;
	}

	int end = i-1;
	// we need to reverse the digits of the array since we formed the number in reverse order
	while(start < end) {
		// swap the start and end digits
		char temp = input[start];
		input[start++] = input[end];
		input[end--] = temp;
	}

	int start_of_decimal = i;   // this denotes the starting point for decimal
	input[i] = '.';   // add decimal point to the input array
	i++;
	length = i;
	start_of_decimal++;
	float dec_part = f - (int)f;  // get the decimal part of the floating point number

	int is_decimal_part_negative = 0;
	if(dec_part < 0) {    // if the decimal part is negative, make it positive
		dec_part *= -1;
		is_decimal_part_negative = 1;
	}

	if(is_positive == 0 && is_decimal_part_negative) {
		is_negative = 1;
	}

	for(int j = 0 ; j < 6 ; j++) {  // we need to build the floating number upto 6 digits of precision
		dec_part *= 10;
		digit = (int)dec_part % 10;
		input[i] = (char)(digit + '0');
		i++;
		length = i;
	}

	int end_of_decimal = i;   // this denotes the end of decimal
	input[end_of_decimal] = '\n';                // add newline character at end

    i++;
    length = i;
    __asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(input), "d"(i)           // call the inline assembler to print to stdout
    );

    return length;   // return the length of the floating point number
}