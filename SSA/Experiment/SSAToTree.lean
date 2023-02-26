-- We create a verified conversion from SSA minus Regions (ie, a sequence
-- of let bindings) into an expression tree. We prove that this
-- conversion preserves program semantics.

inductive Kind where
| int
| pair : Kind → Kind → Kind

inductive OpKind
| O
| Os

inductive Op : OpKind → Type where
| assign (ret : Var) (kind: OpKind) (arg: Var) : Op .O
| tuple (ret : Var) (arg1 arg2 : Var) : Op .O
| ops: Op .O → Op .Os → Op .Os


inductive ExprTree where
| tuple: ExprTree → ExprTree → ExprTree
| compute: ExprTree → OpKind → ExprTree
