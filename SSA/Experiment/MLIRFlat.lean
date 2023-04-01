import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Int.Basic

namespace LC

-- pure simply typed lambda calculus
structure Tensor1d (α : Type) where
  size : Nat
  val :  Fin size → α

-- TODO: create equivalence relation for tensors
-- that says tensors are equivalent if they have the same size and
-- the same values at each index upto the size.


def Tensor1d.empty [Inhabited α] : Tensor1d α where
  size := 0
  val := fun _ => default

def Tensor1d.extract [Inhabited α] (t: Tensor1d α) (l: Nat) (len: Nat) : Tensor1d α where
  size := len
  val := fun ix =>
    let ix' := l + ix
    if H : ix' < t.size then t.val ⟨ix', H⟩
    else default

def Tensor1d.map (f : α → α) (t : Tensor1d α) : Tensor1d α where
  size := t.size
  val := fun ix => f (t.val ix)

def Tensor1d.fill (t: Tensor1d α) (v: α) : Tensor1d α where
  size := t.size
  val := fun _ix => v

-- insert a slice into a tensor.
def Tensor1d.insertslice (t: Tensor1d α) (sliceix: Nat) (slice : Tensor1d α) : Tensor1d α where
  size := t.size + slice.size
  val := fun ix => sorry


-- | TODO: implement fold
-- def Tensor1d.fold_rec (n: Nat) (arr: Nat → α) (f: β → α → β) (seed: β): β :=
--   match n with
--   | 0 => seed
--   | n + 1 => f (Tensor1d.fold_rec n arr f seed) (arr n)

-- def Tensor1d.fold (f : β → α → β)  (seed : β) (t : Tensor1d α) : β :=
--   Tensor1d.fold_rec t.size t.val f seed

structure Tensor2d (α : Type) where
  size0 : Nat
  size1 : Nat
  val :  Fin size0 → Fin size1 → α

def Tensor2d.transpose (t: Tensor2d α) : Tensor2d α where
  size0 := t.size1
  size1 := t.size0
  val := fun ix0 => fun ix1 => t.val ix1 ix0


-- theorem 1: extract (map) = map extract
theorem Tensor1d.extract_map [Inhabited α] (t: Tensor1d α):
  (t.extract left len).map f = (t.map f).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.map]
    funext ix
     by_cases H : ix < t.size;
    sorry
}

-- theorem 2: extract (fill v) = fill (extract v)

-- theorem Tensor1d.extract_fill (t: Tensor1d α):
--   (t.extract left len).fill v = (t.fill v).extract left len := by {
--     simp[Tensor1d.extract, Tensor1d.fill]
-- }

-- theorem 3 : map fusion -- map (f ∘ g) = map f ∘ map g
theorem Tensor1d.map_fusion (t: Tensor1d α):
  (t.map (g ∘ f)) = (t.map f).map g := by {
    simp[Tensor1d.map]
}

-- for loop
def scf.for.loop (f : Nat → β → β) (n n_minus_i: Nat) (acc: β) : β :=
  let i := n - n_minus_i
  match n_minus_i with
    | 0 => acc
    | n_minus_i' + 1 =>
      scf.for.loop f n n_minus_i' (f i acc)

def scf.for (n: Nat) (f: Nat → β → β) (seed: β) : β :=
  let i := 0
  scf.for.loop f n (n - i) seed

-- theorem 1 : for peeling at beginning
theorem scf.for.peel_begin (n : Nat) (f : Nat → β → β) (seed : β) :
  scf.for.loop f (n + 1) n (f 0 seed) = scf.for.loop f (n + 1) (n + 1) seed := by {
    simp[scf.for.loop]
  }

-- theorem 2 : for peeling at ending
theorem scf.for.peel_end (n : Nat) (f : Nat → β → β) (seed : β) :
  scf.for.loop f (n + 1) 0 (f n seed) = f n (scf.for.loop f n 0 seed) := by {
    simp[scf.for.loop]
  }


-- theorem 3: for fusion: if computations commute, then they can be fused.
-- TODO:
/-
theorem scf.for.fusion (n : Nat) (f g : Nat → β → β)  (seed : β)
  (COMMUTE : ∀ (ix : ℕ)  (v : β),  f ix (g ix v) = g ix (f ix v)) :
  scf.for.loop f n n (scf.for.loop g n n seed) =
  scf.for.loop (fun i acc => f i (g i acc)) n n seed := by {
    induction n;
    case zero => {
      simp[loop];
    }
    case succ n' IH => {
      simp[loop];
      sorry
    }
  }
-/


theorem scf.for.zero_n (f: Nat → β → β) (seed : β) :
  scf.for 0 f seed = seed := by {
    simp[scf.for, loop]
  }

  def scf.for.one_n (f: Nat → β → β) (seed : β) :
  scf.for 1 f seed = f 0 seed := by {
    simp[scf.for, loop]
  }

-- theorem 3 : arbitrary for peeling
/-
theorem scf.for.peel_add (n m : Nat) (f : Nat → β → β) (seed : β)  :
  scf.for.loop f (n + m) ((n + m) - n) (scf.for.loop f n (n - 0) seed) = scf.for.loop f (n + m) (n + m - 0) seed := by {
    simp[scf.for.loop]
    revert m;
    induction n;
    case zero => {
      simp[loop]
    }
    case succ n' IH => {
      intros m;
      simp[loop];
      sorry
    }
  }
-/


-- theorem 4 : tiling
-- proof obligation for chris :)
theorem Tensor1d.tile [Inhabited α] (t : Tensor1d α) (SIZE :4 ∣ t.size) (f : α → α):
  t.map f = scf.for (t.size / 4) (fun i acc =>
    let tile := t.extract (i * 4) 4
    let mapped_tile := tile.map f
    let out := acc.insertslice (i * 4) mapped_tile
    out) (Tensor1d.empty) := by {
    cases t;
    case mk size val =>
    simp at SIZE ⊢;
    have : { n : Nat //  size = n * 4 } := by {
      norm_num at SIZE
      -- have ⟨x, y⟩ := SIZE
      sorry
    }
    have ⟨n, N⟩ := this
    rw[N];
    revert size
    induction n
    case zero => {
      simp[scf.for, scf.for.loop]
      sorry
    }
    case succ n IH => {
      sorry
    }
}

-- transpose is an involution

theorem Tensor2d.transpose_involutive (t: Tensor2d α):
  (t.transpose).transpose = t := by {
    simp[Tensor2d.transpose]
}



inductive Val where
| int : Int → Val
| unit : Val
| nat : Nat → Val
| bool : Bool → Val
| tensor1d : Tensor1d Int → Val
| tensor2d : Tensor2d Int → Val
| pair : Val → Val → Val
| triple : Val → Val → Val → Val
| inl : Val → Val
| inr : Val → Val
deriving Inhabited


def Val.int! : Val → Int
| .int i => i
| _ => default

def Val.nat! : Val → Nat
| .nat i => i
| _ => default

def Val.bool! : Val → Bool
| .bool i => i
| _ => default


abbrev Var := Int

abbrev Env (α: Type) := Var → α

def Env.empty {α : Type} [Inhabited α]: Env α := fun _ => default
notation "∅" =>  Env.empty

def Env.set (e: Env α) (var: Var) (val: α) :=
  fun needle => if needle == var then val else e needle
notation e "[" var " := " val "]" => Env.set e var val


-- RHS of an assignment
inductive SSAIndex : Type
| STMT
| EXPR
| TERMINATOR
| REGION

-- NOTE: multiple regions can be converted into a single region by tagging the
-- input appropriately with inl/inr.
inductive SSA (Op: Type): SSAIndex → Type where
| assign (lhs: Var) (rhs: SSA Op .EXPR) (rest: SSA Op .STMT) : SSA Op .STMT
| nop : SSA Op .STMT
| ret (above : SSA Op .STMT) (v: Var): SSA Op .TERMINATOR
| pair (fst snd : Var) : SSA Op .EXPR
| op (o : Op) (arg: Var) (rgn: SSA Op .REGION) : SSA Op .EXPR
| const (k: Val) : SSA Op .EXPR
| rgn (arg: Var) (body: SSA Op .TERMINATOR) : SSA Op .REGION
| rgn0 : SSA Op .REGION
| rgnvar (v: Var) : SSA Op .REGION
| var (v: Var) : SSA Op .EXPR

abbrev Expr (Op: Type) := SSA Op .EXPR
abbrev Stmt (Op: Type) := SSA Op .STMT

class UserSemantics (Op: Type) where
  eval: (o: Op) → (arg: Val) → (rgn: Val → Val) → Val

def SSAIndex.eval : SSAIndex → Type
| .STMT => Env Val
| .TERMINATOR => Val
| .EXPR => Val
| .REGION => Val -> Val

def SSA.eval [S : UserSemantics Op] (e: Env Val) (re: Env (Val → Val)) : SSA Op k → k.eval
| .assign lhs rhs rest =>
  rest.eval (e.set lhs (rhs.eval e re)) re
| .nop => e
| .ret above v => (above.eval e re) v
| .pair fst snd => (e fst).pair (e snd)
| .const v => v
| .op o arg r => S.eval o (e arg) (r.eval Env.empty re)
| .var v => e v
| .rgnvar v => re v
| .rgn0 => id
| .rgn arg body => fun val => body.eval (e.set arg val) re

section EDSL

declare_syntax_cat dsl_region
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
| `([dsl_var| %v $n]) => `(SSA.var (Int.ofNat $(Lean.quote n.getNat)))

example : [dsl_var| %v0] = SSA.var (Op := Unit) 0 := by
  simp

-- DSL Region variables
syntax "%r" num : dsl_rgnvar

syntax "[dsl_rgnvar|" dsl_rgnvar "]" : term
open Lean Macro in
macro_rules
| `([dsl_rgnvar| %r $n]) => `(SSA.rgnvar (Int.ofNat $(Lean.quote n.getNat)))

example : [dsl_rgnvar| %r0] = SSA.rgnvar (Op := Unit) 0 := by
  simp

syntax "pair: "  dsl_var ws dsl_var : dsl_expr
syntax "op:" dsl_op dsl_var (dsl_region)? : dsl_expr
syntax "const:" dsl_val : dsl_expr
syntax dsl_var : dsl_expr
syntax "[dsl_expr|" dsl_expr "]" : term
syntax "[dsl_val|" dsl_val "]" : term
syntax "[dsl_region|" dsl_region "]" : term
syntax "[dsl_stmt|" dsl_stmt "]" : term
syntax "[dsl_terminator|" dsl_terminator "]" : term

syntax term : dsl_val
macro_rules
| `([dsl_val| $t:term]) => return t

macro_rules
| `([dsl_expr| const: $v:dsl_val]) =>
    `(SSA.const [dsl_val| $v])
| `([dsl_expr| pair: $a $b]) =>
    `(SSA.pair [dsl_var| $a] [dsl_var| $b])
| `([dsl_expr| $v:dsl_var]) =>
    `(SSA.var [dsl_var| $v])
| `([dsl_expr| op: $o:dsl_op $arg:dsl_var $[ $r? ]?]) =>
    match r? with
    | .none => `(SSA.op [dsl_op| $o] [dsl_var| $arg ] SSA.rgn0)
    | .some r => `(SSA.op [dsl_op| $o] [dsl_var| $arg ] [dsl_region| $r])


declare_syntax_cat dsl_assign
syntax dsl_var " := " dsl_expr : dsl_assign
syntax "[dsl_assign| " dsl_assign "]" : term
macro_rules
| `([dsl_assign| $v:dsl_var := $e:dsl_expr ]) =>
    `(fun rest => SSA.assign [dsl_var| $v] [dsl_expr| $e] rest)

syntax sepBy(dsl_assign, ";") : dsl_stmt
syntax  "[dsl_stmt|" dsl_stmt "]" : term


syntax "ret " dsl_var : dsl_terminator
macro_rules
| `([dsl_terminator| ret $v:dsl_var]) =>
    `(fun stmt => SSA.ret stmt [dsl_var| $v])

syntax "rgn " dsl_var " => " dsl_stmt ";" dsl_terminator : dsl_region
macro_rules
| `([dsl_region| rgn $v:dsl_var => $s: dsl_stmt ; $term:dsl_terminator]) =>
    `(SSA.rgn [dsl_var| $v] ([dsl_terminator| $term] <| [dsl_stmt| $s] SSA.nop))

end EDSL

namespace ArithScfLinalg

inductive op
| add
| sub
| mul
| run
| for_
| if_
| fold1d -- fold
| map1d
| extract
| fill
| transpose
deriving DecidableEq



instance : UserSemantics op where
  eval
  | .add, .pair (.int x) (.int y), _ => .int (x + y)
  | .sub, .pair (.int x) (.int y), _ => .int (x - y)
  | .run, v, r => r v
  | .if_, (.bool cond), r => if cond then r (.inl .unit) else r (.inr .unit)
  | .for_, (.pair (.nat n) (.int seed)), r =>
      .int <| scf.for n (fun ix acc => (r (.pair (.int ix) (.int acc))).int!) seed
  | .map1d, (.tensor1d t), r => .tensor1d <| t.map fun v => (r (.int v)).int!
  | .fold1d, (.pair (.tensor1d t) (.int seed)), r =>
      .int <| t.fold (fun acc v => (r (.pair (.int acc) (.int v))).int!) seed
  | .extract, (.triple (.tensor1d t) (.nat l) (.nat len)), _ =>
      .tensor1d <| t.extract l len
  | _, _, _ => default

-- TODO: port Hacker's delight examples.

end ArithScfLinalg

end LC