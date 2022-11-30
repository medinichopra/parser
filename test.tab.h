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
     CHAR = 258,
     ELSE = 259,
     FOR = 260,
     IF = 261,
     INT = 262,
     RET = 263,
     VOID = 264,
     ID = 265,
     INT_CONST = 266,
     CHAR_CONST = 267,
     STR_LIT = 268,
     PUNC = 269,
     MULTI_COMM = 270,
     SINGLE_COMM = 271,
     WS = 272,
     EQ_OPT = 273,
     LE_OPT = 274,
     GE_OPT = 275,
     NE_OPT = 276,
     AND_OPT = 277,
     PTR_OPT = 278,
     OR_OPT = 279
   };
#endif
/* Tokens.  */
#define CHAR 258
#define ELSE 259
#define FOR 260
#define IF 261
#define INT 262
#define RET 263
#define VOID 264
#define ID 265
#define INT_CONST 266
#define CHAR_CONST 267
#define STR_LIT 268
#define PUNC 269
#define MULTI_COMM 270
#define SINGLE_COMM 271
#define WS 272
#define EQ_OPT 273
#define LE_OPT 274
#define GE_OPT 275
#define NE_OPT 276
#define AND_OPT 277
#define PTR_OPT 278
#define OR_OPT 279




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

