import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Int.Basic

namespace LC

-- pure simply typed lambda calculus
structure Tensor1d (α : Type) where
  size : Nat
  val :  Nat → α

def Tensor1d.empty [Inhabited α] : Tensor1d α where
  size := 0
  val := fun _ => default

def Tensor1d.extract (t: Tensor1d α) (l: Nat) (len: Nat) : Tensor1d α where
  size := len
  val := fun ix => t.val (l + ix)

def Tensor1d.map (f : α → α) (t : Tensor1d α) : Tensor1d α where
  size := t.size
  val := fun ix => f (t.val ix)

def Tensor1d.fill (t: Tensor1d α) (v: α) : Tensor1d α where
  size := t.size
  val := fun _ix => v

-- insert a slice into a tensor.
def Tensor1d.insertslice (t: Tensor1d α) (ix: Nat) (slice : Tensor1d α) : Tensor1d α where
  size := t.size + slice.size
  val := fun i =>
    if i < ix then t.val i
    else if i < ix + slice.size then slice.val (i - ix)
    else t.val (i - slice.size)


-- | TODO: implement fold
def Tensor1d.fold_rec (n: Nat) (arr: Nat → α) (f: β → α → β) (seed: β): β :=
  match n with
  | 0 => seed
  | n + 1 => f (Tensor1d.fold_rec n arr f seed) (arr n)

def Tensor1d.fold (f : β → α → β)  (seed : β) (t : Tensor1d α) : β :=
  Tensor1d.fold_rec t.size t.val f seed

structure Tensor2d (α : Type) where
  size : Nat × Nat
  val :  Nat × Nat → α

def Tensor2d.transpose (t: Tensor2d α) : Tensor2d α where
  size := (t.size.2, t.size.1)
  val := fun ix => t.val (ix.2, ix.1)


-- theorem 1: extract (map) = map extract

theorem Tensor1d.extract_map (t: Tensor1d α):
  (t.extract left len).map f = (t.map f).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.map]
}

-- theorem 2: extract (fill v) = fill (extract v)

theorem Tensor1d.extract_fill (t: Tensor1d α):
  (t.extract left len).fill v = (t.fill v).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.fill]
}

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

theorem scf.for.zero_n (f: Nat → β → β) (seed : β) :
  scf.for 0 f seed = seed := by {
    simp[scf.for, loop]
  }

  def scf.for.one_n (f: Nat → β → β) (seed : β) :
  scf.for 1 f seed = f 0 seed := by {
    simp[scf.for, loop]
  }

-- theorem 3 : arbitrary for peeling
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