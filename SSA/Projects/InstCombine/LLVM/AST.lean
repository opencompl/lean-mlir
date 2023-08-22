import Partax

namespace LLVM

inductive Ty
  | void
  | i1
  | i8
  | i32
  | i64
  | tuple : List Ty → Ty

-- %N
abbrev LocalIdent := String
-- @N
abbrev GlobalIdent := String

abbrev OpName := String

inductive Expr
  | op : OpName → Option Ty → List LocalIdent → Expr
  | const : Int → Expr

inductive BasicBlock
  | val : LocalIdent → Expr → BasicBlock
  | ret : Option Ty → Ident → BasicBlock

structure Definition where
  (type : Ty)
  (name : GlobalIdent)
  (args : List (LocalIdent × Ty))
  (blocks : List BasicBlock)

abbrev AST := List Definition

end LLVM
