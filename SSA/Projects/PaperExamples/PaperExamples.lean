/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import Lean
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Ring

import SSA.Core

open BitVec
open Ctxt(Var)

@[simp]
theorem BitVec.ofInt_zero (w : ℕ) :
    BitVec.ofInt w 0 = 0 :=
  rfl

namespace ToyNoRegion

inductive Ty
  | int
  deriving DecidableEq, Repr, Lean.ToExpr

@[reducible]
instance : TyDenote Ty where
  toType
    | .int => BitVec 32

inductive Op : Type
  | add : Op
  | const : (val : ℤ) → Op
  deriving DecidableEq, Repr, Lean.ToExpr

/-- `Simple` is a very basic example dialect -/
abbrev Simple : Dialect where
  Op := Op
  Ty := Ty

instance : ToString Ty where
  toString t := repr t |>.pretty

instance : DialectToExpr Simple where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``Simple []

def_signature for Simple
  | .add      => (.int, .int) → .int
  | .const _  => () → .int

def_denote for Simple
  | .const n => BitVec.ofInt 32 n ::ₕ .nil
  | .add     => fun a b => a + b ::ₕ .nil

def cst {Γ : Ctxt _} (n : ℤ) : Expr Simple Γ .pure [.int]  :=
  Expr.mk
    (op := .const n)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .int) : Expr Simple Γ .pure [.int] :=
  Expr.mk
    (op := .add)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

attribute [local simp] Ctxt.snoc

namespace MLIR2Simple

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Simple Ty
  | MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless _ => do
    return .int
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Simple 0 where
  mkTy := mkTy

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM Simple (Σ eff ty, Expr Simple Γ eff ty) := do
  match opStx.name with
  | "const" =>
    match opStx.attrs.find_int "value" with
    | .some (v, _ty) => return ⟨.pure, [.int], cst v⟩
    | .none => throw <| .generic s!"expected 'const' to have int attr 'value', found: {repr opStx}"
  | "add" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨.int, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨.int, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      return ⟨.pure, [.int], add v₁ v₂⟩
    | _ => throw <| .generic (
        s!"expected two operands for `add`, found #'{opStx.args.length}' in '{repr opStx.args}'")
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr Simple 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM Simple (Σ eff ty, Com Simple Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, [ty], Com.ret v⟩
  | _ => throw <| .generic (
      s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})")
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn Simple 0 where
  mkReturn := mkReturn

open Qq in
elab "[simple_com| " reg:mlir_region "]" : term => SSA.elabIntoCom' reg (Simple)

end MLIR2Simple

open MLIR AST MLIR2Simple in
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

open MLIR AST MLIR2Simple in
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
  ^entry(%0 : ToyNoRegion.Ty.int):
    %1 = ToyNoRegion.Op.const 0 : () → (ToyNoRegion.Ty.int)
    %2 = ToyNoRegion.Op.add(%0, %1) : (ToyNoRegion.Ty.int, ToyNoRegion.Ty.int) → (ToyNoRegion.Ty.int)
    return %2 : (ToyNoRegion.Ty.int) → ()
}
-/
#guard_msgs in #eval lhs

open MLIR AST MLIR2Simple in
/-- x -/
def rhs : Com Simple (Ctxt.ofList [.int]) .pure [.int] :=
  [simple_com| {
    ^bb0(%x : i32):
      "return" (%x) : (i32) -> (i32)
  }]


/--
info: {
  ^entry(%0 : ToyNoRegion.Ty.int):
    return %0 : (ToyNoRegion.Ty.int) → ()
}
-/
#guard_msgs in #eval rhs

open MLIR AST MLIR2Simple in
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
  ^entry(%0 : ToyNoRegion.Ty.int):
    %1 = ToyNoRegion.Op.const 0 : () → (ToyNoRegion.Ty.int)
    %2 = ToyNoRegion.Op.add(%0, %1) : (ToyNoRegion.Ty.int, ToyNoRegion.Ty.int) → (ToyNoRegion.Ty.int)
    return %0 : (ToyNoRegion.Ty.int) → ()
}
-/
#guard_msgs (whitespace := lax) in #eval rewritePeepholeAt p1 1 lhs
example : rewritePeephole (fuel := 100) p1 lhs = rewritePeepholeAt p1 1 lhs := by
  native_decide

end ToyNoRegion

namespace ToyRegion

inductive Ty
  | int
  deriving DecidableEq, Repr

@[reducible]
instance : TyDenote Ty where
  toType
    | .int => BitVec 32

instance : Inhabited (TyDenote.toType (t : Ty)) where
  default := by
    cases t
    exact (0#32)

inductive Op :  Type
  | add : Op
  | const : (val : ℤ) → Op
  | iterate (k : ℕ) : Op
  deriving DecidableEq, Repr

instance : Repr Op where
  reprPrec
    | .add, _ => "ToyRegion.Op.add"
    | .const n , _ => f!"ToyRegion.Op.const {n}"
    | .iterate n , _ => f!"ToyRegion.Op.iterate {n} "

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
      let f' (v :  BitVec 32) : BitVec 32 := f (Ctxt.Valuation.nil.snoc v)
      let y := k.iterate f' x
      [y]ₕ

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

attribute [local simp] Ctxt.snoc

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

attribute [local simp] Ctxt.snoc
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
  ^entry(%0 : ToyRegion.Ty.int):
    %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
    %2 = ToyRegion.Op.add(%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    %3 = ToyRegion.Op.iterate 0 (%2) ({
      ^entry(%0 : ToyRegion.Ty.int):
        %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
        %2 = ToyRegion.Op.add(%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
        return %2 : (ToyRegion.Ty.int) → ()
    }) : (ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    return %3 : (ToyRegion.Ty.int) → ()
}
-/
#guard_msgs in #eval egLhs

def runRewriteOnLhs : Com SimpleReg ⟨[int]⟩ .pure [int] :=
  (rewritePeepholeRecursively (fuel := 100) p2 egLhs).val

/--
info: {
  ^entry(%0 : ToyRegion.Ty.int):
    %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
    %2 = ToyRegion.Op.add(%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    %3 = ToyRegion.Op.iterate 0 (%0) ({
      ^entry(%0 : ToyRegion.Ty.int):
        %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
        %2 = ToyRegion.Op.add(%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
        return %0 : (ToyRegion.Ty.int) → ()
    }) : (ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    return %3 : (ToyRegion.Ty.int) → ()
}
-/
#guard_msgs in #eval runRewriteOnLhs

theorem rewriteDidSomething : runRewriteOnLhs ≠ lhs := by
  native_decide

end P2

end ToyRegion
