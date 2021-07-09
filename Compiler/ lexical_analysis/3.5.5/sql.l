%{
    SELECT, FROM, WHILE
    %}

letter [a-zA-Z]
digit [0-9]
id {letter}({letter}|{digit})*
select {?i:select}
from {?i:from}
while {?i:while}

%%
{select} {return SELECT}
{from} {return FROM}
{while} {return WHILE}
%%

