package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}


LineTerminator 		= \r|\n|\r\n
Identation 			=  [ \t\f]
WhiteSpace 			= {LineTerminator} | {Identation}

PARENTESIS_ABRE 	= "("
PARENTESIS_CIERRA 	= ")"

%%


/* keywords */

<YYINITIAL> {
	{PARENTESIS_ABRE}		{ return symbol(ParserSym.PARENTESIS_ABRE, yytext()); }
	{PARENTESIS_CIERRA}		{ return symbol(ParserSym.PARENTESIS_CIERRA, yytext()); }
  	/* whitespace */
  	{WhiteSpace}			{ /* ignore */ }
}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
