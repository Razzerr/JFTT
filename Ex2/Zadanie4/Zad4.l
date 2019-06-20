%{
    #include <stdio.h>
    #include <math.h>
int MAXSIZE = 8;     
int stack[8];     
int top = -1;

bool zlyZnak = false; 
bool brakLiczb = false;
bool brakOper = false;
bool stosPelny = false;
bool errState = false;

int errorState(){
   if (zlyZnak) printf("\nZly operator!\n");
   else if (stosPelny) printf("Stos jest pelny.\n");
   else if (brakLiczb) printf("\nZbyt malo liczb na stosie.\n");
   else if (brakOper) printf("\nZa mala liczba operatorów!\n");
}

int isempty() {
   if(top == -1) return true;
   else return false;
}
   
int isfull() {
   if(top == MAXSIZE-1) return true;
   else return false;
}

int pop() {
   int data;
	
   if(!isempty()) {
      data = stack[top];
      top = top - 1;   
      return data;
   } else {
      brakLiczb = true;
      errState = true;
      return 0;
   }
}

int push(int data) {

   if(!isfull()) {
      top = top + 1;   
      stack[top] = data;
   } else {
      stosPelny = true;
      errState = true;
   }
}

%}

%%
-?[0-9]+ {printf("%s",yytext);
         push(atoi(yytext));}
" "     printf("%s",yytext);
"+"     {printf("%s",yytext);
        int x2 = pop();
         int x1 = pop();
         push(x1+x2);}
"-"     {printf("%s",yytext);
        int x2 = pop();
         int x1 = pop();
         push(x1-x2);}     
"*"     {printf("%s",yytext);
          int x2 = pop();
         int x1 = pop();
         push(x1*x2);}
"/"     {printf("%s",yytext);
        int x2 = pop();
         int x1 = pop();
         push(x1/x2);}
"^"     {printf("%s",yytext);
          int x2 = pop();
         int x1 = pop();
         push(pow(x1, x2));}
"%"     {printf("%s",yytext);
          int x2 = pop();
         int x1 = pop();
         push(x1%x2);}
"\n"    {
         int result = pop();
         if (!isempty()){
            brakOper = true;
            errState = true;
         }
         if(errState) errorState();
         else printf("\n= %i\n", result);

         while (!isempty()){ //in case there was an error
            pop();
         }

         zlyZnak = false; 
         brakLiczb = false;
         brakOper = false;
         stosPelny = false;
         errState = false;
        }
[^0123456789+\-*/^%\n\t ] {printf("%s", yytext);
                           zlyZnak = true;
                           errState = true;
                           }

%%

main(){
  yylex();
  printf("\n\n");
}