import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation
import Blase.Fast.FiniteStateMachine
import Blase.Vars
import SexprPBV
-- import Lean

import Std.Tactic.BVDecide


namespace MultiWidth

inductive WidthExpr where
| const : Nat → WidthExpr
| var : Nat → WidthExpr
| add : WidthExpr → WidthExpr → WidthExpr
deriving Inhabited, Repr, Hashable, DecidableEq, Lean.ToExpr

inductive TermKind : Type
| bool
| bv (w : WidthExpr) : TermKind
| prop
| nat
| int
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

inductive Term
| ofNat (w : WidthExpr) (n : Nat) : Term
| var (v : Nat) (w : TermKind) : Term
| add (w : WidthExpr) (a b : Term) : Term
| zext (a : Term) (wnew : WidthExpr) : Term
| bveq (w : WidthExpr) (a : Term) (b : Term) : Term
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Term.band (w : WidthExpr) (a b : Term) : Term := sorry
def Term.vshl (w : WidthExpr) (a b : Term) : Term := sorry
def Term.sub (w : WidthExpr) (a b : Term) : Term := sorry

inductive Value
  | bad
  | nat (w : Nat)
  | bv {w : Nat} (bv : BitVec w)
  | prop (p : Prop)
  deriving Inhabited

def Value.toBitVec (w : Nat) : Value → BitVec w
  | .bv v => v.zeroExtend _
  | _ => default

def Value.toNat : Value → Nat
  | .nat n => n
  | _ => default

def Value.isBitVec : Value → Option Nat
  | .bv (w := w) _ => some w
  | _ => none

@[reducible]
def Value.denote : Value → Σ α, α
| .nat n => ⟨Nat, n⟩
| .bv (w := w) n => ⟨BitVec w, n⟩
| .prop p => ⟨Prop, p⟩
| .bad => ⟨Unit, ()⟩

variable (env : Nat → Value) in
def WidthExpr.denote : WidthExpr → Nat
  | .const n => n
  | .var n => (env n).toNat
  | .add a b => a.denote + b.denote

@[reducible]
def TermKind.denote (env : Nat → Value) : TermKind → Type
| .bool => Bool
| .bv w => BitVec (w.denote env)
| .prop => Prop
| .nat => Nat
| .int => Int

@[reducible]
def Value.mk {env} : ∀ {k : TermKind}, k.denote env → Value
  | .nat, n => .nat n
  | .bv _, n => .bv n
  | .prop, p => .prop p
  | _, _ => .bad

def Term.width (t : Term) : WidthExpr :=
  match t with
  | .ofNat w _n => w
  | .var _v (.bv w) => w
  | .var _v _ => .const 0
  | .add w _a _b => w
  | .zext _a wnew => wnew
  | bveq w _a _b => w

variable (env : Nat → Value) in
def Value.WF (k : TermKind) : Value → Prop
  | .nat _ => k = .nat
  | .bv (w := w) _ => ∃ w', k = .bv w' ∧ w'.denote env = w
  | .prop _ => k = .prop
  | .bad => False

theorem Value.WF.denote_eq {env} : ∀ {k} {v : Value}, v.WF env k → v.denote.1 = k.denote env
  | _, .nat _, rfl => rfl
  | _, .bv _, ⟨_, rfl, rfl⟩ => rfl
  | _, .prop _, rfl => rfl

theorem Value.WF.eta {env} :
    ∀ {k} {v : Value} (wf : v.WF env k), v = .mk (cast wf.denote_eq v.denote.2)
  | _, .nat _, rfl => rfl
  | _, .bv _, ⟨_, rfl, rfl⟩ => rfl
  | _, .prop _, rfl => rfl

variable (env : Nat → Value) in
def Term.WF : Term → TermKind → Prop
  | .ofNat w _, k => k = .bv w
  | .var v k', k => k = k' ∧ (env v).WF env k'
  | .add w a b, k => k = .bv w ∧ a.WF (.bv w) ∧ b.WF (.bv w)
  | .bveq w a b, k => k = .prop ∧ a.WF (.bv w) ∧ b.WF (.bv w)
  | .zext x wnew, k => k = .bv wnew ∧ x.WF (.bv x.width)

theorem Term.WF.width_eq {t : Term} (wf : t.WF env (.bv w)) : t.width = w := by
  cases t with simp [WF] at wf <;> simp [wf, width]
  | var => simp [← wf.1]

variable (env : Nat → Value) in
def Term.denote : Term → Value
  | .var v _ => env v
  | .ofNat w n => .bv (BitVec.ofNat (w.denote env) n)
  | .add (w := w) a b => .bv <| a.denote.toBitVec (w.denote env) + b.denote.toBitVec _
  | .zext a wnew => .bv (a.denote.toBitVec (wnew.denote env))
  | .bveq w a b => .prop <| a.denote.toBitVec (w.denote env) = b.denote.toBitVec _

variable (env : Nat → Value) in
def Term.denoteWF : ∀ (t : Term) {k}, t.WF env k → k.denote env
  | .var v _, _, wf => cast (wf.1 ▸ wf.2.denote_eq) (env v).denote.2
  | .ofNat w n, _, wf => cast (wf ▸ rfl) <| BitVec.ofNat (w.denote env) n
  | .add _ a b, _, wf => cast (wf.1 ▸ rfl) <| a.denoteWF wf.2.1 + b.denoteWF wf.2.2
  | .zext a wnew, _, ⟨eq, ha⟩ => cast (eq ▸ rfl) <| (a.denoteWF ha).zeroExtend (wnew.denote env)
  | .bveq _ a b, _, wf => cast (wf.1 ▸ rfl) <| a.denoteWF wf.2.1 = b.denoteWF wf.2.2

variable (env : Nat → Value) in
theorem Term.denote_eq {t : Term} {k} (wf : t.WF env k) :
    t.denote env = .mk (t.denoteWF env wf) := by
  induction t generalizing k with
  | ofNat => cases wf; rfl
  | var v => obtain ⟨rfl, wf⟩ := wf; simp [denote, denoteWF, wf.eta]
  | add v _ _ ih1 ih2
  | bveq v _ _ ih1 ih2 =>
    obtain ⟨rfl, wf1, wf2⟩ := wf
    simp [denote, denoteWF, ih1 wf1, ih2 wf2, Value.mk, Value.toBitVec]
  | zext v _ ih1 =>
    obtain ⟨rfl, wf1⟩ := wf
    simp [denote, denoteWF, ih1 wf1, Value.mk, Value.toBitVec]

def Env.ofList : List Value → Nat → Value
  | [] => default
  | x :: xs => (Nat.casesOn · x (Env.ofList xs))

def TermWF (env : Nat → Value) (k : TermKind) := { t : Term // t.WF env k }
def TermWF.ofNat {env : Nat → Value} (w : WidthExpr) (n : Nat) :
    TermWF env (.bv w) := ⟨.ofNat w n, rfl⟩
def TermWF.bvvar {env : Nat → Value} (v : Nat) (w : WidthExpr)
  (h : (env v).isBitVec = some (w.denote env) := by rfl) : TermWF env (.bv w) := by
  refine ⟨.var v (.bv w), rfl, ?_⟩
  revert h; cases env v <;> simp [Value.isBitVec, Value.WF, eq_comm]
def TermWF.add {env : Nat → Value} {w : WidthExpr} (a b : TermWF env (.bv w)) :
    TermWF env (.bv w) := ⟨.add w a.1 b.1, rfl, a.2, b.2⟩
def TermWF.bveq {env : Nat → Value} {w : WidthExpr} (a b : TermWF env (.bv w)) :
    TermWF env .prop := ⟨.bveq w a.1 b.1, rfl, a.2, b.2⟩
def TermWF.zext {env : Nat → Value} {w : WidthExpr} (a : TermWF env (.bv w)) (wnew : WidthExpr) :
    TermWF env (.bv wnew) := ⟨.zext a.1 wnew, rfl, by rw [a.2.width_eq]; exact a.2⟩

def TermWF.denote {env : Nat → Value} {k : TermKind} (t : TermWF env k) : k.denote env :=
  t.1.denoteWF env t.2

example (n : Nat) (x y : BitVec n) : TermWF.denote (env := Env.ofList [.nat n, .bv x, .bv y])
    (.add (.bvvar 1 (.var 0)) (.bvvar 2 (.var 0))) = x + y := rfl

section ToSingleWidth

/--
Convert a width variable into a bitvector,
which encodes it into a bitvector whose '.toNat' value is the width.
-/
def WidthExpr.toTwosComplement (w : WidthExpr) (wo : WidthExpr) : Term :=
  match w with
  | .const c => .ofNat wo c
  | .var v => .var v (.bv wo)
  | .add a b => .add wo (a.toTwosComplement wo) (b.toTwosComplement wo)

@[simp]
def Term.constOne (w : WidthExpr) : Term :=
  .ofNat w 1

/--
Convert a width variable into a bitvector,
which encodes a mask of the form (1 << w) - 1, where w is the width variable.
-/
def WidthExpr.toSingleWidthMask (w : WidthExpr) (wo : WidthExpr)
    : Term :=
  let wval := w.toTwosComplement wo
  let one := Term.constOne wo
  let pot := Term.vshl wo one wval  -- 1 << widthVar = 2^widthVar
  Term.sub wo pot one -- 2^widthVar - 1 = mask

mutual
def Term.toSingleWidthUnmasked (wo : WidthExpr) (t : Term) : Term × Bool :=
  match t with
  | .var v (.bv _) => (.var v (.bv wo), false)
  | .var v k => (.var v k, true)
  | .ofNat _ n => (.ofNat wo n, false)
  | .zext x _ => (x.toSingleWidthMasked wo, false)
  | .add _ a b => (.add wo (a.toSingleWidthUnmasked wo).1 (b.toSingleWidthUnmasked wo).1, false)
  | .bveq _ a b => (.bveq wo (a.toSingleWidthMasked wo) (b.toSingleWidthMasked wo), true)

def Term.toSingleWidthMasked (wo : WidthExpr) (t : Term) : Term :=
  match t.toSingleWidthUnmasked wo with
  | (t', true) => t'
  | (t', false) => .band wo t' (t.width.toSingleWidthMask wo)
end

def Value.toSingleWidth (wo : Nat) : Value → Value
  | .bv w => .bv (w.zeroExtend wo)
  | v => v

def TermKind.toSingleWidth (wo : WidthExpr) : TermKind → TermKind
  | .bv _ => .bv wo
  | v => v

def Env.toSingleWidth (wo : WidthExpr) (env : Nat → Value) : Nat → Value :=
  Value.toSingleWidth (wo.denote env) ∘ env

variable (env : Nat → Value) in
mutual
def Term.toSingleWidthUnmasked.WF (wo : WidthExpr) {t : Term} {k} (h : t.WF env k) :
    let t' := t.toSingleWidthUnmasked wo
    let k' := k.toSingleWidth wo
    let env' := Env.toSingleWidth wo env
    t'.1.WF env' k' ∧
    if t'.2 then ∀ n, k = .bv n →
      t'.1.denote env' = (t'.1.band wo (n.toSingleWidthMask wo)).denote env'
    else ∃ n, k = .bv n :=
  sorry

def Term.toSingleWidthMasked.WF (wo : WidthExpr) {t : Term} {k} (h : t.WF env k) :
    let t' := t.toSingleWidthMasked wo
    let k' := k.toSingleWidth wo
    let env' := Env.toSingleWidth wo env
    t'.WF env' k' ∧ ∀ n, k = .bv n →
      t'.denote env' = (t'.band wo (n.toSingleWidthMask wo)).denote env' := by
  have := toSingleWidthUnmasked.WF wo h; revert this
  simp [toSingleWidthMasked]; obtain ⟨t', _|_⟩ := toSingleWidthUnmasked .. <;> simp
  · intro wf n rfl; constructor
    · simp [TermKind.toSingleWidth]
      sorry
    · simp [denote]
      sorry
  · exact .intro
end

end ToSingleWidth

end MultiWidth
