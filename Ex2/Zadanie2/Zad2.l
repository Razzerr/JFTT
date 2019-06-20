%{
    #include <stdio.h>
%}

%x comment
%x string1
%x string2
%x tag

%%
"<!--"                  BEGIN(comment);
<comment>[^-]*          '\0'; //Eat everything that's not a dash
<comment>"--"[^->]*     '\0'; //Eat all dashes that are no followed by another dash or >
<comment>"-"{2,}">"     BEGIN(INITIAL);

\<[^!]                  ECHO;BEGIN(tag);
<tag>[^>]*=[ \t]*[\"]     ECHO;BEGIN(string1);
<tag>[^>]*=[ \t]*[\']     ECHO;BEGIN(string2);
<string1>([^"]|(\\\"))*\"  ECHO;BEGIN(tag); 
<string2>([^']|(\\\'))*\'  ECHO;BEGIN(tag);
<tag>[^=\"\>]*          ECHO;BEGIN(INITIAL);
%%

main()
{
  yylex();
  printf("\n\n");
}