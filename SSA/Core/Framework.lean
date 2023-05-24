import Lean 
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Int.Basic

namespace SSA
abbrev Var := Nat
abbrev RegionVar := Nat

instance : DecidableEq Var := by
  infer_instance

/-- Us mucking around to avoid mutual inductives.  -/
inductive SSAIndex : Type
/-- LHS := RHS. LHS is a `Var` and RHS is an `SSA Op .EXPR` -/
| STMT
/-- Ways of making an RHS -/
| EXPR
/-- The final instruction in a region. Must be a return -/
| TERMINATOR
/-- a lambda -/
| REGION

-- NOTE: multiple regions can be converted into a single region by tagging the
-- input appropriately with inl/inr.
inductive SSA (Op : Type) : SSAIndex → Type where
/-- lhs := rhs; rest of the program -/
| assign (lhs : Var) (rhs : SSA Op .EXPR) (rest : SSA Op .STMT) : SSA Op .STMT
/-- no operation. -/
| nop : SSA Op .STMT
/-- above; ret v -/
| ret (above : SSA Op .STMT) (v : Var) : SSA Op .TERMINATOR
/-- () -/
| unit : SSA Op .EXPR
/-- (fst, snd) -/
| pair (fst snd : Var) : SSA Op .EXPR
/-- (fst, snd, third) -/
| triple (fst snd third : Var) : SSA Op .EXPR
/-- op (arg) { rgn } rgn is an argument to the operation -/
| op (o : Op) (arg : Var) (rgn : SSA Op .REGION) : SSA Op .EXPR
/- fun arg => body -/
| rgn (arg : Var) (body : SSA Op .TERMINATOR) : SSA Op .REGION
/- no function / non-existence of region. -/
| rgn0 : SSA Op .REGION
/- a region variable. --/
| rgnvar (v : RegionVar) : SSA Op .REGION
/-- a variable. -/
| var (v : Var) : SSA Op .EXPR

abbrev Expr (Op : Type) := SSA Op .EXPR
abbrev Stmt (Op : Type) := SSA Op .STMT


/-- Evaluation context. There is only one type in the semantics and that type is Val -/
abbrev Env (Val : Type) := Var → Val

@[simp]
def Env.empty {Val : Type} [Inhabited Val]: Env Val := fun _ => default

instance [Inhabited Val] : EmptyCollection (Env Val) := ⟨Env.empty⟩

@[simp]
def Env.set (e : Env Val) (var : Var) (val : Val) :=
  fun needle => if needle == var then val else e needle
notation e "[" var " := " val "]" => Env.set e var val

class UserSemantics (Op : Type) (Val : Type) [Inhabited Val] where
  /-- `Op` is semantically a function `Val → (Val → Val) → Val`
      for every operation, produce a result `Val` given the
      input variable value (⟦val⟧ : Val)
      and input region value (⟦rgn⟧ : Val → Val) -/
  eval : (o : Op) → (arg : Val) → (rgn : Val → Val) → Val
  /-- Okay Yuck -/
  valUnit : Val 
  valPair : Val → Val → Val
  valTriple : Val → Val → Val → Val

def SSAIndex.eval (Val : Type) : SSAIndex → Type
| .STMT => Env Val
| .TERMINATOR => Val
| .EXPR => Val
| .REGION => Val -> Val

def SSA.eval [Inhabited Val] [S : UserSemantics Op Val] (e: Env Val) (re: Env (Val → Val)) : SSA Op k → k.eval Val
| .assign lhs rhs rest =>
  rest.eval (e.set lhs (rhs.eval e re)) re
| .nop => e
| .unit => S.valUnit 
| .ret above v => (above.eval e re) v
| .pair fst snd => S.valPair (e fst) (e snd)
| .triple fst snd third => S.valTriple (e fst) (e snd) (e third)
| .op o arg r => S.eval o (e arg) (r.eval Env.empty re)
| .var v => e v
| .rgnvar v => re v
| .rgn0 => id
| .rgn arg body => fun val => body.eval (e.set arg val) re

inductive Tree (Op : Type) (Val : Type) where
| pair (e1 e2 : Tree Op Val)
| op (op : Op) (t : Tree Op Val)
| oprgn (op : Op) (t : Tree Op Val) (r : Val → Tree Op Val)

def Tree.eval [Inhabited Val] [S: UserSemantics Op Val] : Tree Op Val → Val
| .pair e1 e2 => S.valPair e1.eval e2.eval
| .op o t => S.eval o (t.eval) (fun _ => default)
| .oprgn o t r => S.eval o t.eval (fun v => (r v).eval)

end SSA
