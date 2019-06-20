%{
    #include <stdio.h>
    bool eraseDoc = true;
%}

%x comment
%x string1
%x string2

%%
"//"(.*(\\\n)*)* '\0';
"/**/"                  '\0';

"/**"[^/]                {
                            if (eraseDoc) BEGIN(comment);
                            else printf("%s", yytext);
                          }
"/*"[^*]                BEGIN(comment);
<comment>[^*]*          '\0'; //Eat everything that's not a *
<comment>"*"[^*/]*      '\0'; //Eat all * that are no followed by another * or /
<comment>"*"+"/"        BEGIN(INITIAL);
[\"]                    ECHO;BEGIN(string1);
<string1>([^"]|(\\\"))*\"       ECHO;BEGIN(INITIAL); 
[\']                    ECHO;BEGIN(string2);
<string2>([^']|(\\\'))*\'       ECHO;BEGIN(INITIAL);

%%

main(int argc, char *argv[])
{
  if (argc > 1 && !strcmp(argv[1], "false")){
    eraseDoc = false;
  }
  yylex();
  printf("\n\n");
}