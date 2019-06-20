%{
    #include <stdio.h>

    int words = 0, lines = 0;
    char* tmpString;
    
    char *removeSpaces(char *str) { 
        int i = 0, j = 0; 
        while (str[i]) 
        { 
            if (str[i] != ' ') 
            str[j++] = str[i]; 
            i++; 
        } 
        str[j] = '\0'; 
        return str; 
    } 

%}

ws      [ \t]+

%%
^{ws}*[^ \t\n\r]+   {   
                        lines++;
                        words++;
                        tmpString = yytext;
                        printf("%s", removeSpaces(tmpString));
                    }
^{ws}*\n{0,1}       '\0';
{ws}$               '\0';
{ws}                {printf(" ");}
[^ \t\n\r]+         {printf("%s", yytext);
                      words++;}
%%


main()
{
  yylex();
  printf("\n\nWords: %i\nLines: %i\n\n", words, lines);
}