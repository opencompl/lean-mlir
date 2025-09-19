/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import Lean
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Ring

import SSA.Core

open LeanMLIR
open BitVec
open Ctxt(Var)

@[simp]
theorem BitVec.ofInt_zero (w : ℕ) :
    BitVec.ofInt w 0 = 0 :=
  rfl

namespace ToyNoRegion

inductive Ty
  | int
  deriving DecidableEq, Lean.ToExpr

@[reducible]
instance : TyDenote Ty where
  toType
    | .int => BitVec 32

inductive Op : Type
  | add : Op
  | const : (val : ℤ) → Op
  deriving DecidableEq, Lean.ToExpr

/-- `Simple` is a very basic example dialect -/
abbrev Simple : Dialect where
  Op := Op
  Ty := Ty

instance : DialectToExpr Simple where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``Simple []


def_signature for Simple
  | .add      => (.int, .int) → .int
  | .const _  => () → .int

def_denote for Simple
  | .const n => BitVec.ofInt 32 n ::ₕ .nil
  | .add     => fun a b => a + b ::ₕ .nil

/-! ### Printing -/

instance instPrint : DialectPrint Simple where
  printOpName
  | .add => "add"
  | .const _ => "const"
  printTy
  | .int => "i32"
  printAttributes
  | .const val => s!"\{value = {val} : i32}"
  | _ => ""
  dialectName := "simple"
  printReturn _ := "return"

/-! ### Parsing -/

@[instance] def instToStringTy := instPrint.instToStringTy
@[instance] def instReprTy := instPrint.instReprTy

instance : DialectParse Simple 0 where
  mkTy
  | .int .Signless 32 => return .int
  | _ => throw .unsupportedType

  isValidReturn _Γ opStx := return opStx.name == "return"

  mkExpr Γ opStx := do opStx.mkExprOf Γ <|← match opStx.name with
    | "add"   => return .add
    | "const" => do
        let ⟨val, _type⟩ ← opStx.getIntAttr "value"
        return .const val
    | opName => throw <| .unsupportedOp opName

elab "[simple_com| " reg:mlir_region "]" : term => SSA.elabIntoCom' reg (Simple)

/-! ### Examples -/

def eg₀ : Com Simple (Ctxt.ofList []) .pure [.int] :=
  [simple_com| {
    %c2 = "const"() {value = 2} : () -> i32
    %c4 = "const"() {value = 4} : () -> i32
    %c6 = "add"(%c2, %c4) : (i32, i32) -> i32
    %c8 = "add"(%c6, %c2) : (i32, i32) -> i32
    "return"(%c8) : (i32) -> ()
  }]

def eg₀val := Com.denote eg₀ Ctxt.Valuation.nil
/-- info: [0x00000008#32] -/
#guard_msgs in #eval eg₀val

/-- x + 0 -/
def lhs : Com Simple (Ctxt.ofList [.int]) .pure [.int] :=
  [simple_com| {
    ^bb0(%x : i32):
      %c0 = "const" () { value = 0 : i32 } : () -> i32
      %out = "add" (%x, %c0) : (i32, i32) -> i32
      "return" (%out) : (i32) -> (i32)
  }]

/--
info: {
  ^entry(%0 : i32):
    %1 = "const"(){value = 0 : i32} : () -> (i32)
    %2 = "add"(%0, %1) : (i32, i32) -> (i32)
    "return"(%2) : (i32) -> ()
}
-/
#guard_msgs in #eval lhs


/-- x -/
def rhs : Com Simple (Ctxt.ofList [.int]) .pure [.int] :=
  [simple_com| {
    ^bb0(%x : i32):
      "return" (%x) : (i32) -> (i32)
  }]


/--
info: {
  ^entry(%0 : i32):
    "return"(%0) : (i32) -> ()
}
-/
#guard_msgs in #eval rhs


def p1 : PeepholeRewrite Simple [.int] [.int] :=
  { lhs := lhs, rhs := rhs, correct :=
    by
      rw [lhs, rhs]
      /-:
      Com.denote
        (Com.var (cst 0)
        (Com.var (add { val := 1, property := _ } { val := 0, property := _ })
        (Com.rets { val := 0, property := ex1.proof_3 }))) =
      Com.denote (Com.rets { val := 0, property := _ })
      -/
      simp_peephole
      /- ⊢ ∀ (a : BitVec 32), a + BitVec.ofInt 32 0 = a -/
      intros a
      simp only [ofInt_zero, ofNat_eq_ofNat, BitVec.add_zero]
      /- goals accomplished 🎉 -/
    }

/--
info: {
  ^entry(%0 : i32):
    %1 = "const"(){value = 0 : i32} : () -> (i32)
    %2 = "add"(%0, %1) : (i32, i32) -> (i32)
    "return"(%0) : (i32) -> ()
}
-/
#guard_msgs (whitespace := lax) in #eval rewritePeepholeAt p1 1 lhs
example : rewritePeephole (fuel := 100) p1 lhs = rewritePeepholeAt p1 1 lhs := by
  native_decide

end ToyNoRegion

namespace ToyRegion

inductive Ty
  | int
  deriving DecidableEq

instance : TyDenote Ty where toType
  | .int => BitVec 32

instance : Inhabited (TyDenote.toType (t : Ty)) where
  default := by
    cases t
    exact (0#32)

inductive Op :  Type
  | add : Op
  | const : (val : ℤ) → Op
  | iterate (k : ℕ) : Op
  deriving DecidableEq

/-- A simple example dialect with regions -/
abbrev SimpleReg : Dialect where
  Op := Op
  Ty := Ty

abbrev SimpleReg.int : SimpleReg.Ty := .int
open SimpleReg (int)

def_signature for SimpleReg
  | .const _    => () → .int
  | .add        => (.int, .int) → .int
  | .iterate _  => { (.int) → [.int] } → (.int) -[.pure]-> .int

def_denote for SimpleReg
  | .const n    => [BitVec.ofInt 32 n]ₕ
  | .add        => fun a b => [a + b]ₕ
  | .iterate k  => fun x f =>
      let f := fun y => (f y).getN 0
      [f^[k] x]ₕ

/-
TODO: the current `denote` function puts the regular arguments *before* the regions,
      which is then preserved by `def_denote` prettification,
      but the `def_signature` syntax suggests the other order.
      Some solutions:
      * Flip the signature syntax (but that'd look ugly!)
      * Flip the order in `hvectorFun(…)` elab (but that's inelegant)
      * Flip the order in `denote`s definition (the "elegant" solution,
          but that's a pretty big refactor!)
-/

@[reducible]
instance : DialectDenote SimpleReg where
  denote
    | .const n, _, _ => BitVec.ofInt 32 n ::ₕ .nil
    | .add, [(a : BitVec 32), (b : BitVec 32)]ₕ , _ => a + b ::ₕ .nil
    | .iterate k, [(x : BitVec 32)]ₕ, [(f : _ → _)]ₕ =>
      let f := fun y => (f y).getN 0
      let f' (v :  BitVec 32) : BitVec 32 := f (Ctxt.Valuation.nil.cons v)
      let y := k.iterate f' x
      [y]ₕ

/-! ### Printing -/

instance instPrint : DialectPrint SimpleReg where
  printOpName
  | .add => "add"
  | .const _ => "const"
  | .iterate _ => "iterate"
  printTy
  | .int => "i32"
  printAttributes
  | .const val => s!"\{value = {val} : i32}"
  | .iterate k => s!"\{iterations = {k}}"
  | _ => ""
  dialectName := "simple"
  printReturn _ := "return"

/-! ### Helpers -/

@[simp_denote]
def cst {Γ : Ctxt _} (n : ℤ) : Expr SimpleReg Γ .pure [int] :=
  Expr.mk
    (op := .const n)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

@[simp_denote]
def add {Γ : Ctxt _} (e₁ e₂ : Var Γ int) : Expr SimpleReg Γ .pure [int] :=
  Expr.mk
    (op := .add)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

@[simp_denote]
def iterate {Γ : Ctxt _} (k : Nat) (input : Var Γ int) (body : Com SimpleReg ⟨[int]⟩ .impure [int]) :
    Expr SimpleReg Γ .pure [int] :=
  Expr.mk
    (op := Op.iterate k)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons input .nil)
    (regArgs := HVector.cons body HVector.nil)

attribute [local simp] Ctxt.cons

namespace P1
/-- running `f(x) = x + x` 0 times is the identity. -/
def lhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  Com.var (iterate (k := 0) (⟨0, by simp⟩) (
      Com.letPure (add ⟨0, by simp⟩ ⟨0, by simp⟩) -- fun x => (x + x)
      <| Com.rets [⟨0, rfl⟩]ₕ
  )) <|
  Com.rets [⟨0, by rfl⟩]ₕ

def rhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  Com.rets [⟨0, by rfl⟩]ₕ

attribute [local simp] Ctxt.cons
--
-- set_option trace.Meta.Tactic.simp true in
open Ctxt (Var Valuation DerivedCtxt) in

def p1 : PeepholeRewrite SimpleReg [int] [int] :=
  { lhs := lhs, rhs := rhs, correct := by
      rw [lhs, rhs]
      simp_peephole
      -- ∀ (a : BitVec 32), (fun v => v + v)^[0] a = a
      simp [Function.iterate_zero]
  }

/-
def ex1' : Com Simple  (Ctxt.ofList [.int]) .int := rewritePeepholeAt p1 1 lhs

theorem EX1' : ex1' = (
  -- %c0 = 0
  Com.var (cst 0) <|
  -- %out_dead = %x + %c0
  Com.var (add ⟨1, rfl⟩ ⟨0, rfl⟩ ) <| -- %out = %x + %c0
  -- ret %c0
  Com.rets [⟨2, rfl⟩]ₕ)
  := by rfl
-/

end P1

namespace P2

/-- running `f(x) = x + 0` 0 times is the identity. -/
def lhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  Com.var (cst 0) <| -- %c0
  Com.var (add ⟨0, rfl⟩ ⟨1, rfl⟩) <| -- %out = %x + %c0
  Com.rets [⟨0, rfl⟩]ₕ

def rhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  Com.rets [⟨0, rfl⟩]ₕ

def p2 : PeepholeRewrite SimpleReg [int] [int] :=
  { lhs := lhs, rhs := rhs, correct := by
      rw [lhs, rhs]
      simp_peephole
      --  ∀ (a : BitVec 32), a + BitVec.ofInt 32 0 = a
      simp
  }

/--
example program that has the pattern 'x + 0' both at the top level,
and inside a region in an iterate. -/
def egLhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  Com.var (cst 0) <|
  Com.var (add ⟨0, rfl⟩ ⟨1, rfl⟩) <| -- %out = %x + %c0
  Com.var (iterate (k := 0) (⟨0, rfl⟩) (
      Com.letPure (cst 0) <|
      Com.letPure (add ⟨0, rfl⟩ ⟨1, rfl⟩) -- fun x => (x + x)
      <| Com.rets [⟨0, rfl⟩]ₕ
  )) <|
  Com.rets [⟨0, rfl⟩]ₕ

/--
info: {
  ^entry(%0 : i32):
    %1 = "const"(){value = 0 : i32} : () -> (i32)
    %2 = "add"(%1, %0) : (i32, i32) -> (i32)
    %3 = "iterate"(%2){iterations = 0} ({
      ^entry(%0 : i32):
        %1 = "const"(){value = 0 : i32} : () -> (i32)
        %2 = "add"(%1, %0) : (i32, i32) -> (i32)
        "return"(%2) : (i32) -> ()
    }) : (i32) -> (i32)
    "return"(%3) : (i32) -> ()
}
-/
#guard_msgs in #eval egLhs

def runRewriteOnLhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  (rewritePeepholeRecursively (fuel := 100) p2 egLhs).val

/--
info: {
  ^entry(%0 : i32):
    %1 = "const"(){value = 0 : i32} : () -> (i32)
    %2 = "add"(%1, %0) : (i32, i32) -> (i32)
    %3 = "iterate"(%0){iterations = 0} ({
      ^entry(%0 : i32):
        %1 = "const"(){value = 0 : i32} : () -> (i32)
        %2 = "add"(%1, %0) : (i32, i32) -> (i32)
        "return"(%0) : (i32) -> ()
    }) : (i32) -> (i32)
    "return"(%3) : (i32) -> ()
}
-/
#guard_msgs in #eval runRewriteOnLhs

theorem rewriteDidSomething : runRewriteOnLhs ≠ lhs := by
  native_decide

end P2

end ToyRegion
