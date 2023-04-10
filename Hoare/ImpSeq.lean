-- A sequential version of Imp, without while loops
--
import Lean
import Aesop

namespace ImpSeq

inductive Expr where
  | Var : Lean.Name → Expr
  | NatLit : Nat → Expr
  | Add : Expr → Expr → Expr
  | Sub : Expr → Expr → Expr
  | Mul : Expr → Expr → Expr

-- Should probably be a typeclass with the laws of state updates (= lens laws)
structure State where
  values : List (Lean.Name × Nat)
  deriving DecidableEq

def State.lookup (s : State) (n : Lean.Name) : Nat :=
  match s.values.lookup n with
    | some v => v
    | none => default

def State.update (s : State) (n : Lean.Name) (v : Nat) : State :=
  match s.values.lookup n with
    | none => { values := s.values.cons (n, v) }
    | some _ => { values := s.values.map (fun (n', v') => if n' = n then (n, v) else (n', v')) }

@[simp]
theorem State.update_lookup_eq (s : State) (n : Lean.Name) (v : Nat) : (s.update n v).lookup n = v := by
  simp [State.lookup, State.update]
  induction s.values with
    | nil => simp [List.lookup]
    | cons head tail ih => aesop

@[simp]
theorem State.update_lookup_neq (s : State) (n n' : Lean.Name) (v: Nat) : (n' != n) → (s.update n v).lookup n' = s.lookup n' := by
  intro hne
  simp [State.lookup, State.update]
  sorry

-- This is the wrong definition for States, as it is not invariant to permutations of the list
-- Should fix this using typeclasses and a Quotient type for this concrete definition.
-- This theorem is actually wrong for this definition.
@[simp]
theorem State.update_update (s : State) (n : Lean.Name) (v v' : Nat) : (s.update n v).update n v' = s.update n v' := by
  simp [State.update]
  induction s.values with
    | nil => simp [List.lookup]
    | cons head tail ih => sorry

@[simp]
theorem State.update_noop (s : State) (n : Lean.Name) : s.update n (s.lookup n) = s := by
  sorry

instance : Inhabited State where
  default := { values := [] }

instance : ToString State where
  toString s := s.values.foldl (fun s (n, v) => s ++ s!"{n} = {v}; ") ""

instance : Repr State where
  reprPrec s _ := repr $ toString s


namespace Examples

def ex1 := State.update default `x 3
def ex2 := ex1.update `x 4
#eval ex1.lookup `x -- some 3
#eval ex2.lookup `x -- some 4
#eval ex2.lookup `y -- none

end Examples

def Expr.eval (e : Expr) (s : State) : Nat :=
  match e with
  | Expr.Var n => s.lookup n
  | Expr.NatLit n => n
  | Expr.Add e1 e2 => e1.eval s + e2.eval s
  | Expr.Sub e1 e2 => e1.eval s - e2.eval s
  | Expr.Mul e1 e2 => e1.eval s * e2.eval s

declare_syntax_cat imp_expr
syntax ident : imp_expr
syntax num : imp_expr
syntax imp_expr "+" imp_expr : imp_expr
syntax imp_expr "-" imp_expr : imp_expr
syntax imp_expr "*" imp_expr : imp_expr
syntax "(" imp_expr ")" : imp_expr
syntax "[expr|" imp_expr "]" : term
macro_rules
  | `( [expr|$id:ident]) => `(Expr.Var $(Lean.quote id.getId))
  | `( [expr|$n:num]) => `(Expr.NatLit $(Lean.quote n.getNat))
  | `( [expr|$e1 + $e2]) => `(Expr.Add [expr|$e1] [expr|$e2])
  | `( [expr|$e1 - $e2]) => `(Expr.Sub [expr|$e1] [expr|$e2])
  | `( [expr|$e1 * $e2]) => `(Expr.Mul [expr|$e1] [expr|$e2])


namespace Examples

def x_plus_two := [expr| x + 2]
#eval x_plus_two.eval ex1 -- some 5
#eval x_plus_two.eval ex2 -- some 6
#eval x_plus_two.eval default -- none

end Examples

inductive Statement where
    | Skip : Statement
    | Assign : Lean.Name → Expr → Statement
    | Seq : Statement → Statement → Statement
    | IfZero : Expr → Statement → Statement → Statement

def Statement.eval (p : Statement) (st : State) : State := match p with
  | Statement.Skip => st
  | Statement.Assign n e => st.update n (e.eval st)
  | Statement.Seq s1 s2 =>
    let st' := s1.eval st
    s2.eval st'
  | Statement.IfZero c t f => match c.eval st with
    | 0 => t.eval st
    | Nat.succ _n => f.eval st

def StatementEval (p : Statement) (st st' : State) : Prop :=
  p.eval st = st'

-- Alternative inductive definition
/-
inductive StatementEval : Statement → State → State → Prop where
    | Skip : ∀ st, StatementEval Statement.Skip st st
    | Assign : ∀ st n e v, e.eval s = v → StatementEval (Statement.Assign n e) st (st.update n v)
    | Seq : ∀ s1 s2 st st' st'', StatementEval s1 st st' → StatementEval s2 st' st'' → StatementEval (Statement.Seq s1 s2) st st''
    | IfZeroTrue : ∀ c t f st st', c.eval st = 0 → StatementEval t st st' → StatementEval (Statement.IfZero c t f) st st'
    | IfZeroFalse : ∀ c t f st st', c.eval st ≠ 0 → StatementEval f st st' → StatementEval (Statement.IfZero c t f) st st'
-/

instance (p : Statement) (st st' : State) : Decidable (StatementEval p st st') :=
  if h : p.eval st = st'
    then isTrue <| by
      simp only [StatementEval, h]
    else isFalse <| by
      simp only [StatementEval, h]

declare_syntax_cat statement
syntax "skip" : statement
syntax ident ":=" imp_expr : statement
syntax statement ";" statement : statement
syntax "if0" imp_expr "then"  statement "else" statement : statement
syntax  "[stmt|" statement "]" : term
macro_rules
  | `( [stmt|skip]) => `(Statement.Skip)
  | `( [stmt|$id:ident := $e]) => `(Statement.Assign $(Lean.quote id.getId) [expr|$e])
  | `( [stmt|$s1; $s2]) => `(Statement.Seq [stmt|$s1] [stmt|$s2])
  | `( [stmt|if0 $e then $t else $f]) => `(Statement.IfZero [expr|$e] [stmt|$t] [stmt|$f])

syntax term "=[" statement "]=> " term : term
syntax term "=[" ident "]=> " term : term
macro_rules
  | `( $st =[ $p:statement ]=> $st') => `(StatementEval [stmt|$p] $st $st')
  | `( $st =[ $p:ident ]=> $st') => `(StatementEval $p $st $st')

namespace Examples

#eval [stmt| x := 2; x := x + 2].eval default -- some "x = 4; "
#eval default =[  x := 2; x := x + 2 ]=> ex2 -- true
#eval default =[  x := 2; x := x + 2 ]=> ex1 -- false

end Examples
