import Mathlib.Data.Fin.Basic
import Mathlib.Init.Data.Int.Bitwise
import SSA.WellTypedFramework

abbrev Width := Nat -- bit width

-- machine integers. What about overflow? or negative numbers for that matter?
abbrev MachineInt := Nat

def DepTypedBaseVal (_w : Width) : Type := MachineInt

instance (_w : Width ): DecidableEq (DepTypedBaseVal _w) := instDecidableEqNat

def DepTypedBaseVal.toNat (w : Width) : DepTypedBaseVal w → Nat
  | n => n
def DepTypedBaseVal.fromNat (w : Width) : Nat → DepTypedBaseVal w
  | n => n

instance (w : Width) : Add (DepTypedBaseVal w) where
  add x y := x.toNat + y.toNat

instance (w : Width) : HMod (DepTypedBaseVal w) Width (DepTypedBaseVal w) where
  hMod x y :=
    let xNat : Nat := x.toNat
    let yNat : Nat := y
    DepTypedBaseVal.fromNat w (xNat % yNat)

structure BaseVal  where
 (val : MachineInt)
 (width : Width)
 deriving DecidableEq


variable (w : Width)
abbrev val := TypeSemanticsInstance BaseVal

instance : DecidableEq val := sorry -- should be derivable, can't get Lean to accept it

inductive op (w : Width)
| add
| and
| negate
| or
| sub
| xor
| const (val : MachineInt)

instance : OpArity (op w) where
  arity := fun o => match o with
    | .add => (.pair (.base ()) (.base ()) , .base ())
    | .and => (.pair (.base ()) (.base ()) , .base ())
    | .negate => ((.base ()) , (.base ()))
    | .or => (.pair (.base ()) (.base ()) , .base ())
    | .sub => (.pair (.base ()) (.base ()) , .base ())
    | .xor => (.pair (.base ()) (.base ()) , .base ())
    | .const _ => (.unit, (.base ()))

-- @Chris: these are DUMMY DEFINITIONS! They need to be modified.

def val.add (x y : DepTypedBaseVal w) : DepTypedBaseVal w :=
  (x + y) % w


def val.add_untyped (input : TypeSemanticsInstance BaseVal) : TypeSemanticsInstance BaseVal :=
-- This would be a WellTypedAt as inductive proposition with a Decidable instance
match (typeCheck input) with
  | .typed (.pair (.base ()) (.base ()))  (.pair (.base v₁) (.base v₂)) => .base { width := w, val := val.add v₁.width v₁.val v₂.val}
  | _ => .unit

def val.and (w : Width) (x y : val) : val :=
  match x with
  | .int _w1 v1 =>
    match y with
    | .int _w2 v2 => .int 0 <| (Int.land v1 v2) % w
    | _ => default
  | _ => default
def val.negate (w : Width) (x : val) : val :=
  match x with
  | .int _w1 v1 => .int 0 <| (- v1) % w
  | _ => default
def val.or (w : Width) (x y : val) : val :=
  match x with
  | .int _w1 v1 =>
    match y with
    | .int _w2 v2 => .int 0 <| (Int.lor v1 v2) % w
    | _ => default
  | _ => default
def val.sub (w : Width) (x y : val) : val :=
  match x with
  | .int _w1 v1 =>
    match y with
    | .int _w2 v2 => .int 0 <| (Int.sub v1 v2) % w
    | _ => default
  | _ => default
def val.xor (w : Width) (x y : val) : val :=
  match x with
  | .int _w1 v1 =>
    match y with
    | .int _w2 v2 => .int 0 <| (Int.lxor' v1 v2) % w
    | _ => default
  | _ => default


@[simp]
def op.eval (o : op) (v : val) (_rgn : val → val) : val :=
 match o with
 | .const w i => val.int w i
 | .add w => match v with | .pair x y => val.add w x y | _ => default
 | .and w => match v with | .pair x y => val.and w x y | _ => default
 | .negate w => val.negate w v
 | .or w => match v with | .pair x y => val.or w x y | _ => default
 | .sub w => match v with | .pair x y => val.sub w x y | _ => default
 | .xor w => match v with | .pair x y => val.xor w x y | _ => default

@[simp]
instance S : UserSemantics op val where
  eval := op.eval
  valPair := val.pair
  valTriple := val.triple


syntax "add(" term ")" : dsl_op
syntax "and(" term ")" : dsl_op
syntax "or(" term ")" : dsl_op
syntax "negate(" term ")" : dsl_op
syntax "sub(" term ")" : dsl_op
syntax "xor(" term ")" : dsl_op
syntax "const(" term "," term ")" : dsl_op

macro_rules
| `([dsl_op| add($w)]) => `(op.add $w)
| `([dsl_op| and($w)]) => `(op.and $w)
| `([dsl_op| negate($w)]) => `(op.negate $w)
| `([dsl_op| or($w)]) => `(op.or $w)
| `([dsl_op| sub($w)]) => `(op.sub $w)
| `([dsl_op| xor($w)]) => `(op.xor $w)
| `([dsl_op| const($w, $i)]) => `(op.const $w $i)


namespace Example
-- Name: AddSub:1043
-- Pre: None
/-
%Y = and %Z, C1
%X = xor %Y, C1
%LHS = add %X, 1
%r = add %LHS, %RHS
  =>
%or = or %Z, ~C1
%r = sub %RHS, %or
-/
def thm1  :
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
    %v3 := op:const(w,C1) %v42;
    %v4 := pair:%v1 %v3; -- (%Z, C1)
    %v5 := op:and(w) %v4; -- %Y = and %z, C1
    %v6 := pair: %v5 %v3 -- %X = xor %Y, C1
    dsl_ret %v6
  ] = SSA.eval (Op := op) (Val := val) e re [dsl_bb|
    dsl_ret %v6
  ] := by {
    simp[SSA.eval]
    sorry
  }


-- Name: AddSub:1152
-- Pre : None
-- Name: AddSub:1152
-- %r = add i1 %x, %y
--   =>
-- %r = xor %x, %y
--  def thm2 (w : Width) :
--   SSA.eval (Op := op) (Val := val) e re [dsl_bb|
--     %v1 = op:add
--   ]
end Example


inductive WellTypedOp : op → val → Prop
  | add : ∀ (w : Width) (x y : Int), WellTypedOp (op.add w) $ .pair (.int w x) (.int w y)
  | and : ∀ (w : Width) (x y : Int), WellTypedOp (op.and w) $ .pair (.int w x) (.int w y)
  | negate : ∀ (w : Width) (x : Int), WellTypedOp (op.negate w) $ .int w x
  | or : ∀ (w : Width) (x y : Int), WellTypedOp (op.or w) $ .pair (.int w x) (.int w y)
  | sub : ∀ (w : Width) (x y : Int), WellTypedOp (op.sub w) $ .pair (.int w x) (.int w y)
  | xor : ∀ (w : Width) (x y : Int), WellTypedOp (op.xor w) $ .pair (.int w x) (.int w y)

instance (o : op) (v : val) : Decidable (WellTypedOp o v) :=
  match o, v with
  | .add w, .pair (.int w₁ x) (.int w₂ y) =>
    if h₁ : w = w₁ then
      if h₂ : w = w₂ then
        isTrue (by
         rw [← h₁,← h₂]
         apply WellTypedOp.add
         )
      else
        isFalse (by
          intro h; cases h; contradiction)
    else
      isFalse (by
        intro h; cases h; contradiction)
  | .and w, .pair (.int w₁ x) (.int w₂ y) =>
    if h₁ : w = w₁ then
      if h₂ : w = w₂ then
        isTrue (by
         rw [← h₁,← h₂]
         apply WellTypedOp.and
         )
      else
        isFalse (by
          intro h; cases h; contradiction)
    else
      isFalse (by
        intro h; cases h; contradiction)
  | .negate w, .int w₁ x =>
    if h₁ : w = w₁ then
      isTrue (by
       rw [← h₁]
       apply WellTypedOp.negate
       )
    else
      isFalse (by
        intro h; cases h; contradiction)
  | .or w, .pair (.int w₁ x) (.int w₂ y) =>
    if h₁ : w = w₁ then
      if h₂ : w = w₂ then
        isTrue (by
         rw [← h₁,← h₂]
         apply WellTypedOp.or
         )
      else
        isFalse (by
          intro h; cases h; contradiction)
    else
      isFalse (by
        intro h; cases h; contradiction)
  | .sub w, .pair (.int w₁ x) (.int w₂ y) =>
    if h₁ : w = w₁ then
      if h₂ : w = w₂ then
        isTrue (by
         rw [← h₁,← h₂]
         apply WellTypedOp.sub
         )
      else
        isFalse (by
          intro h; cases h; contradiction)
    else
      isFalse (by
        intro h; cases h; contradiction)
  | .xor w, .pair (.int w₁ x) (.int w₂ y) =>
    if h₁ : w = w₁ then
      if h₂ : w = w₂ then
        isTrue (by
         rw [← h₁,← h₂]
         apply WellTypedOp.xor
         )
      else
        isFalse (by
          intro h; cases h; contradiction)
    else
      isFalse (by
        intro h; cases h; contradiction)
  | _, _ => isFalse (by sorry) -- TODO: there has to be a better way to automate this...
