%{
  #include <stdio.h>
  #include <math.h>
  #include <ctype.h>
  int yylex (void);
  void yyerror (char const *);

  int error = 0;

  int divide(int x1, int x2){
    if (x2 == 0){
      error = 1;
      return 0;
    }
    return ((int)floor((float)x1/x2));
  }

  int modulo(int x1, int x2){
    if (x2 < 1){
      error = 2;
      return 0;
    }
    return (x1%x2);
  }

  void printError(){
    if (error = 1){
      printf("\nCan't divide by 0\n");
    } else if (error = 2){
      printf("\nCan't get module of number smaller than 1\n");
    }
    error = 0;
  }
%}

%token NUM
%left '-' '+'
%left '*' '/' '%'
%precedence NEG  
%right '^'   

%%

input:
  %empty
| input line
;

line:
  '\n'
| exp '\n'      { if(error==0){printf("\n%i\n", $1);}else{printError();};}
;

exp:
  NUM               { printf("%i ", $1); if(error==0)$$ = $1;        }
| exp '+' exp       { printf("+ "); if(error==0)$$ = $1 + $3;        }
| exp '-' exp       { printf("- "); if(error==0)$$ = $1 - $3;        }
| exp '*' exp       { printf("* "); if(error==0)$$ = $1 * $3;        }
| exp '/' exp       { printf("/ "); if(error==0)$$ = divide($1, $3); }
| exp '%' exp       { printf("%% "); if(error==0)$$ = modulo($1, $3);}
| exp '^' exp       { printf("^ "); if(error==0)$$ = pow ($1, $3);   } 
| '-' exp %prec NEG { printf("~ "); if(error==0)$$ = -$2;            }
| '(' exp ')'       { if(error==0)$$ = $2;                          }
;

%%

int main (){
    return yyparse ();
}

int yylex (void){
  int c;

  while ((c = getchar ()) == ' ' || c == '\t')
    continue;

  if (c == '\\'){
    if ((c = getchar ()) != '\n'){
      yyerror("Error! Break line character without following new line character!");
      return 0;
    } else {
      while ((c = getchar ()) == ' ' || c == '\t')
        continue;
    }
  }

  if (isdigit (c)){
      ungetc (c, stdin);
      scanf ("%i", &yylval);
      return NUM;
    }

  bool lineBreak = true;
  if (c == '#'){
    while (lineBreak = true){
      lineBreak = false;
      while ((c = getchar ()) != '\\' && c != '\n')
        continue;
      if (c == '\\'){
        if((c = getchar ()) != '\n'){
          yyerror("Invalid syntax");
          return 0;
        }
        lineBreak=true;
        continue;
      }
      if (c == '\n')
        break;
    }
  }

  if (c == EOF)
    return 0;
  return c;
}

void yyerror (char const *s){
  fprintf (stderr, "%s\n", s);
}