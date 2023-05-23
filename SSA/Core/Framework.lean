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

namespace EDSL

declare_syntax_cat dsl_region
declare_syntax_cat dsl_bb
declare_syntax_cat dsl_op
declare_syntax_cat dsl_expr
declare_syntax_cat dsl_stmt
declare_syntax_cat dsl_terminator
declare_syntax_cat dsl_var
declare_syntax_cat dsl_val
declare_syntax_cat dsl_rgnvar

-- ops are defined by someone else
syntax "[dsl_op|" dsl_op "]" : term

-- DSL variables
syntax "%v" num : dsl_var

syntax "[dsl_var|" dsl_var "]" : term
open Lean Macro in
macro_rules
| `([dsl_var| %v $n]) =>
  `($(Lean.quote n.getNat))

example : [dsl_var| %v0] =  0 := by
  simp

-- DSL Region variables
syntax "%r" num : dsl_rgnvar

syntax "[dsl_rgnvar|" dsl_rgnvar "]" : term
open Lean Macro in
macro_rules
| `([dsl_rgnvar| %r $n]) => `(SSA.rgnvar ($(Lean.quote n.getNat)))

example : [dsl_rgnvar| %r0] = SSA.rgnvar (Op := Unit) 0 := by
  simp

syntax "const:" dsl_val : dsl_expr
syntax "op:" dsl_op dsl_var ("{" dsl_region "}")? : dsl_expr
syntax "unit:"  : dsl_expr
syntax "pair:"  dsl_var dsl_var : dsl_expr
syntax "triple:"  dsl_var dsl_var dsl_var : dsl_expr
syntax dsl_var : dsl_expr

syntax "[dsl_bb|" dsl_bb "]" : term
syntax "[dsl_expr|" dsl_expr "]" : term
syntax "[dsl_region|" dsl_region "]" : term
syntax "[dsl_stmt|" dsl_stmt "]" : term
syntax "[dsl_terminator|" dsl_terminator "]" : term
syntax "[dsl_val|" dsl_val "]" : term

syntax term : dsl_val
macro_rules
| `([dsl_val| $t:term]) => return t

macro_rules
| `([dsl_expr| unit: ]) => `(SSA.unit)
| `([dsl_expr| pair: $a $b]) =>
    `(SSA.pair [dsl_var| $a] [dsl_var| $b])
| `([dsl_expr| triple: $a $b $c]) =>
    `(SSA.triple [dsl_var| $a] [dsl_var| $b] [dsl_var| $c])
| `([dsl_expr| $v:dsl_var]) =>
    `(SSA.var [dsl_var| $v])
| `([dsl_expr| op: $o:dsl_op $arg:dsl_var $[{ $r? }]?]) =>
    match r? with
    | .none => `(SSA.op [dsl_op| $o] [dsl_var| $arg ] SSA.rgn0)
    | .some r => `(SSA.op [dsl_op| $o] [dsl_var| $arg ] [dsl_region| $r])


declare_syntax_cat dsl_assign
syntax dsl_var " := " dsl_expr : dsl_assign
syntax "[dsl_assign| " dsl_assign "]" : term
macro_rules
| `([dsl_assign| $v:dsl_var := $e:dsl_expr ]) =>
    `(fun rest => SSA.assign [dsl_var| $v] [dsl_expr| $e] rest)

example : [dsl_assign| %v0 := %v42 ] =
  (fun rest => SSA.assign (Op := Unit) 0 (SSA.var 42) rest) := by {
    funext rest
    dsimp
}

syntax sepBy(dsl_assign, ";") : dsl_stmt
macro_rules
| `([dsl_stmt|  $[ $ss:dsl_assign ];*  ]) => do
  let mut out ← `(id)
  for s in ss do
    out ← `($out ∘ [dsl_assign| $s ])
  return out

example : [dsl_stmt| %v0 := %v42 ; %v1 := %v44  ] =
  (fun rest =>
    SSA.assign (Op := Unit) 0 (SSA.var 42)
    (SSA.assign 1 (SSA.var 44) rest)) := by {
    funext rest
    simp
}

-- | this sucks, it becomes super global.
syntax "dsl_ret " dsl_var : dsl_terminator

macro_rules
| `([dsl_terminator| dsl_ret $v:dsl_var]) =>
    `(fun stmt => SSA.ret stmt [dsl_var| $v])

syntax (dsl_stmt)?  "dsl_ret " dsl_var : dsl_bb
macro_rules
| `([dsl_bb| $[ $s?: dsl_stmt ]? dsl_ret $retv:dsl_var]) => do
    let s : Lean.Syntax ← do
          match s? with
          | .none => `(fun x => x)
          | .some s => `([dsl_stmt| $s])
    `(([dsl_terminator| dsl_ret $retv] <| ($s SSA.nop)))

syntax "dsl_rgn" dsl_var "=>" dsl_bb : dsl_region
macro_rules
| `([dsl_region| dsl_rgn $v:dsl_var => $bb:dsl_bb ]) => do
    let s : Lean.Syntax ← do
    `(SSA.rgn ([dsl_var| $v]) ([dsl_bb| $bb]))

example : [dsl_region| dsl_rgn %v0 =>
  dsl_ret %v0
] = SSA.rgn 0 (SSA.ret (SSA.nop (Op := Unit)) 0) := by {
  rfl
}


syntax "dsl_bb"  (dsl_stmt)?  "dsl_ret " dsl_var : dsl_bb

-- example : [dsl_region| dsl_rgn %v0 =>
--   %v0 := const:42
--   dsl_ret %v0
-- ] = SSA.rgn 0 (SSA.assign 0 (SSA.const 42 <| SSA.ret (SSA.nop (Op := Unit)) 0)) := by {
--   rfl
-- }

syntax dsl_rgnvar : dsl_region
macro_rules
| `([dsl_region| $v:dsl_rgnvar]) => `([dsl_rgnvar| $v ])

end EDSL

end SSA
