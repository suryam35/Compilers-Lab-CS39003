#include "myl.h"
#define BUFF 100

int printStr(char *arr)
{
   int i=0;
   for(i=0;arr[i]!='\0';i++); // This loop is to count the number of characters we are going to print
    
   __asm__ __volatile__ ("syscall"::"a"(1), "D"(1), "S"(arr), "d"(i)); // command to print the string to the terminal
   return(i);
}

int printInt(int n)
{
   char buff[BUFF];
   char zero='0';
   int i=0,j,k,bytes;
   int ret = 0;
   int lower_bound_input = 0; // variable to check the special case input if the input is lower bound of the 32 bit integer
   if(n==0){ 
      buff[i++]=zero; // checking if the number is zero
   }
   else
   {
      if(n<0)  // checking if the given integer is negative 
      {
         if(n == -(1ll << 31)){  // checking the special case if the number is lower bound of int 32 bit -> -2,147,483,648
            n++;
            lower_bound_input++;
         }
         buff[i++]='-';
         n=-n; // making the number positive
      }
      while(n) // extracting digit by digit from the number
      {
         int dig=n%10;
         buff[i++]=(char)(zero+dig);
         n/=10;
      }
      if(buff[0]=='-') j=1; // checking if the number is negative or not
      else j=0;
      k=i-1;
      while(j<k) // since it was read and stored from right -> left so we have to reverse the number
      {
         char temp=buff[j];
         buff[j++]=buff[k];
         buff[k--]=temp;
      }
   }
   if(lower_bound_input){
      buff[i-1]++; // handling the special case if the number was lower bound of 32 bit int to avoid overflow
   }
   // buff[i]='\n'; // adding newline character at the end
   bytes=i;
   __asm__ __volatile__ (
      "movl $1, %%eax \n\t"
      "movq $1, %%rdi \n\t"
      "syscall \n\t"
      : "=r"(ret)
      :"S"(buff),"d"(bytes)

   ); // commmand to print the integer to the terminal
   
   if(ret < 0) 
      return ERR; // reporting if any error occured
   else 
      return ret-1; // if no error then returning the length
} 

int readInt(int *n) 
{
   int temp = 0, i = 0, negative_number = 0; // variables to store the number and store the sign of the number 
   int size_n;
   char buff[BUFF]="";
   
   __asm__ __volatile(
      "movl $0,%%eax \n\t"
      "movq $0, %%rdi \n\t"
      "syscall \n\t"
      :"=a"(size_n)
      :"S"(buff),"d"(sizeof(buff))
   );                          // command to take the integer input from terminal
   size_n = size_n - 1;
   if(buff[0] == '-') // checking if the number is negative 
   {
      negative_number = 1;
      i++;
      if(size_n == 1 && buff[0] == '-'){ // checking for size if number starts with sign
         return ERR;
      }
   }
   else if(buff[0] < '0' || buff[0] > '9'){
      return ERR;
   }
   int num_of_dot = 0; // checking the number of dots
   int num_of_e = 0; // checking the number of 'e' || 'E' in number

   int checker = i;

   while(checker <= size_n - 1){ // loop to count num_of_dot and num_of_e
      if(buff[checker] == 'e' || buff[checker] == 'E'){
         num_of_e++;
         
      }
      else if(buff[checker] == '.'){
         num_of_dot++;
         
      }
      checker++;
   }

   while(i <= size_n - 1) // calculating the integer
   {  
      if(buff[i] == 'e' || buff[i] == 'E' || buff[i] == '.'){ // ignoring anything after 'e' or '.' in the integer number
         break;
      }
      if(buff[i] >= '0' && buff[i] <= '9') // checking for invalid chars
      {
         temp = temp*10 + (int)(buff[i] - '0');
         i++;
      }
      else 
      {
         size_n = -1;
         break; 
      }
   } 
   if(negative_number == 1){ // making the number negative if it was observed negative
      temp = -temp;
   }
   
   if(size_n < 0){
      return ERR; // reporting any error
   }
   else{
      *n = temp; // assigning the pointer passed to the function to the integer calculated
      return OK; // reporting input is taken successfully
   }

}


