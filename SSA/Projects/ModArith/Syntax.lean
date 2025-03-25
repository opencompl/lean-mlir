/-
Syntax definitions for `ModArith`, providing a custom `[mod_arith q, hq | ...]` with syntax sugar
analogous to FHE's `[poly| ...]`.

Authors: Jaeho Choi<zerozerozero0216@gmail.com>
-/
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.ModArith.Basic

open MLIR AST Ctxt
open ZMod

section MkFuns

/-
We assume `q : Nat` and `[Fact (q > 1)]` so that `ZMod q` is nontrivial.
-/
variable {q : Nat} [Fact (q > 1)]

/--
This function maps from an MLIR type to our `ModArith` dialect’s type.
We support:
  - `R` (a textual marker) → `.modLike`
  - `int` → `.integer`
  - `index` → `.index`
You can rename or expand these patterns as needed.
-/
def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (ModArith q) (ModArith q).Ty
  | MLIR.AST.MLIRType.undefined "R" =>
    return .modLike
  | MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless _ =>
    return .integer
  | MLIR.AST.MLIRType.index =>
    return .index
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy (ModArith q) 0 where
  mkTy := mkTy

/--
A helper to construct a constant integer expression (in Lean’s sense of “plain Int”).
-/
def cstInt {Γ : Ctxt _} (z : Int) : Expr (ModArith q) Γ .pure .integer :=
  Expr.mk
    (op      := .const_int z)
    (ty_eq   := rfl)
    (eff_le  := by constructor)
    (args    := .nil)
    (regArgs := .nil)

/--
A helper to construct a constant index expression (Lean’s `Nat`).
-/
def cstIdx {Γ : Ctxt _} (i : Nat) : Expr (ModArith q) Γ .pure .index :=
  Expr.mk
    (op      := .const_idx i)
    (ty_eq   := rfl)
    (eff_le  := by constructor)
    (args    := .nil)
    (regArgs := .nil)

/--
A helper to construct a ring element in `ZMod q` from an `Int`.
-/
def cstMod {Γ : Ctxt _} (z : Int) : Expr (ModArith q) Γ .pure .modLike :=
  -- If you want a “computable cast” approach, do similarly to FHE's `cstComputable`.
  -- For now, we can just do a raw `.const` to embed `↑z : ZMod q`.
  let zmod : ZMod q := z
  Expr.mk
    (op      := .const zmod)
    (ty_eq   := rfl)
    (eff_le  := by constructor)
    (args    := .nil)
    (regArgs := .nil)

/--
Build an “add” operation in `ZMod q`.
-/
def add {Γ : Ctxt (Ty q)} (x y : Var Γ .modLike)
    : Expr (ModArith q) Γ .pure .modLike :=
  Expr.mk
    (op      := .add)
    (ty_eq   := rfl)
    (eff_le  := by constructor)
    (args    := .cons x (.cons y .nil))
    (regArgs := .nil)

/--
Build a “sub” operation in `ZMod q`.
-/
def sub {Γ : Ctxt (Ty q)} (x y : Var Γ .modLike)
    : Expr (ModArith q) Γ .pure .modLike :=
  Expr.mk
    (op      := .sub)
    (ty_eq   := rfl)
    (eff_le  := by constructor)
    (args    := .cons x (.cons y .nil))
    (regArgs := .nil)

/--
Build a “mul” operation in `ZMod q`.
-/
def mul {Γ : Ctxt (Ty q)} (x y : Var Γ .modLike)
    : Expr (ModArith q) Γ .pure .modLike :=
  Expr.mk
    (op      := .mul)
    (ty_eq   := rfl)
    (eff_le  := by constructor)
    (args    := .cons x (.cons y .nil))
    (regArgs := .nil)

/--
Given a single MLIR operation, produce a Lean expression in the `ModArith` dialect.

We match on `opStx.name` to see if it is `"mod_arith.add"`, `"mod_arith.sub"`,
`"arith.const"`, etc. Then we decode the arguments, attribute `value`,
and produce the corresponding expression builder (add, sub, cstInt, etc.).
-/
def mkExpr (Γ : Ctxt (ModArith q).Ty) (opStx : MLIR.AST.Op 0)
  : MLIR.AST.ReaderM (ModArith q) (Σ eff ty, Expr (ModArith q) Γ eff ty) := do
  match opStx.name with

  | "mod_arith.add" =>
    match opStx.args with
    | [xStx, yStx] => do
      let ⟨tyX, x⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ xStx
      let ⟨tyY, y⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ yStx
      match tyX, tyY with
      | .modLike, .modLike =>
         return ⟨.pure, .modLike, add x y⟩
      | _, _ =>
         throw <| .generic s!"expected both operands to be of type 'modLike'"
    | _ =>
      throw <| .generic s!"mod_arith.add expects exactly 2 args, got {opStx.args.length}"

  | "mod_arith.sub" =>
    match opStx.args with
    | [xStx, yStx] => do
      let ⟨tyX, x⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ xStx
      let ⟨tyY, y⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ yStx
      match tyX, tyY with
      | .modLike, .modLike =>
         return ⟨.pure, .modLike, sub x y⟩
      | _, _ =>
         throw <| .generic s!"expected both operands to be of type 'modLike'"
    | _ =>
      throw <| .generic s!"mod_arith.sub expects exactly 2 args, got {opStx.args.length}"

  | "mod_arith.mul" =>
    match opStx.args with
    | [xStx, yStx] => do
      let ⟨tyX, x⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ xStx
      let ⟨tyY, y⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ yStx
      match tyX, tyY with
      | .modLike, .modLike =>
         return ⟨.pure, .modLike, mul x y⟩
      | _, _ =>
         throw <| .generic s!"expected both operands to be of type 'modLike'"
    | _ =>
      throw <| .generic s!"mod_arith.mul expects exactly 2 args, got {opStx.args.length}"

  | "arith.constant" =>
    -- We let the `arith.constant` produce either a plain integer or an index, etc.
    match opStx.attrs.find_int "value" with
    | .some (val, valTy) =>
      match valTy with
      | .int _sz _sign =>
        -- check result type from `opStx.res`
        match opStx.res with
        | [(_, MLIR.AST.MLIRType.int .Signless _sz2)] =>
          -- ok, produce cstInt
          return ⟨.pure, .integer, cstInt val⟩
        | [(_, MLIR.AST.MLIRType.index)] =>
          return ⟨.pure, .index, cstIdx val.toNat⟩
        | other =>
          throw <| .generic s!"arith.constant: unsupported result type {repr other}"
      | tyOther =>
        throw <| .generic s!"arith.constant with unsupported type {repr tyOther}"
    | .none =>
      throw <| .generic s!"arith.constant expects int-attr 'value', got {repr opStx.attrs}"

  | "mod_arith.constant" =>
    -- A direct constant in `ZMod q`.
    match opStx.attrs.find_int "value" with
    | .some (val, _valTy) =>
      return ⟨.pure, .modLike, cstMod val⟩
    | .none =>
      throw <| .generic s!"mod_arith.constant expects int-attr 'value', got {repr opStx.attrs}"

  | other =>
    throw <| .unsupportedOp s!"[mod_arith] mkExpr: operation name {other} not recognized"

/--
Given a return statement, produce a `Com (ModArith q)` that returns the given value.
We check that the op is named "return" and has exactly one argument.
-/
def mkReturn (Γ : Ctxt (ModArith q).Ty) (opStx : MLIR.AST.Op 0)
  : MLIR.AST.ReaderM (ModArith q) (Σ eff ty, Com (ModArith q) Γ eff ty) :=
  if opStx.name == "return" then
    match opStx.args with
    | [argStx] => do
      let ⟨tyArg, x⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ argStx
      return ⟨.pure, tyArg, Com.ret x⟩
    | _ =>
      throw <| .generic s!"[mod_arith] return expects exactly 1 argument"
  else
      throw <| .generic s!"[mod_arith] mkReturn called on non-return op {opStx.name}"


instance : MLIR.AST.TransformExpr (ModArith q) 0 where
  mkExpr := mkExpr

instance : MLIR.AST.TransformReturn (ModArith q) 0 where
  mkReturn := mkReturn

end MkFuns

open Qq MLIR AST Lean Elab Term Meta in
elab "[mod_arith " qi:term "," hq:term " | " reg:mlir_region "]" : term => do
  -- 1) elaborate `q : Nat`
  let q_   : Q(Nat)             ← elabTermEnsuringTypeQ qi   q(Nat)
  -- 2) elaborate `hq : Fact (q > 1)`
  let hq_  : Q(Fact ($q_ > 1))  ← elabTermEnsuringTypeQ hq   q(Fact ($q_ > 1))
  -- 3) call the EDSL machinery
  SSA.elabIntoCom reg q(ModArith $q_)

/-!
Usage example might look like:

```lean
def myTest : Com (ModArith 17) [] .pure .modLike :=
  [mod_arith 17, fact17 |
    %x = arith.constant 42 : !i32 { value = 42 : i32 }
    %y = mod_arith.const { value = 9 : i64 } : !R
    %z = mod_arith.add %x, %y : !R
    return %z
  ]
```
-/
