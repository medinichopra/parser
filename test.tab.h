/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     NAME = 259,
     CHAR = 260,
     ELSE = 261,
     FOR = 262,
     IF = 263,
     INT = 264,
     RET = 265,
     VOID = 266,
     ID = 267,
     CHAR_CONST = 268,
     STR_LIT = 269,
     PUNC = 270,
     MULTI_COMM = 271,
     SINGLE_COMM = 272,
     WS = 273,
     EQ_OPT = 274,
     LE_OPT = 275,
     GE_OPT = 276,
     NE_OPT = 277,
     AND_OPT = 278,
     PTR_OPT = 279,
     OR_OPT = 280,
     UMINUS = 281
   };
#endif
/* Tokens.  */
#define NUMBER 258
#define NAME 259
#define CHAR 260
#define ELSE 261
#define FOR 262
#define IF 263
#define INT 264
#define RET 265
#define VOID 266
#define ID 267
#define CHAR_CONST 268
#define STR_LIT 269
#define PUNC 270
#define MULTI_COMM 271
#define SINGLE_COMM 272
#define WS 273
#define EQ_OPT 274
#define LE_OPT 275
#define GE_OPT 276
#define NE_OPT 277
#define AND_OPT 278
#define PTR_OPT 279
#define OR_OPT 280
#define UMINUS 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 37 "test.y"
{ // Placeholder for a value
	int intval;
	symboltable *symp;
}
/* Line 1529 of yacc.c.  */
#line 106 "test.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

