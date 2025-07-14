/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.MLIRSyntax.Transform.Utils

import SSA.Projects.SLLVM.Dialect.Base

namespace LeanMLIR.SLLVM

-- open Qq Lean Meta Elab.Term Elab Command
open MLIR
open MLIR.AST

private abbrev ReaderM := MLIR.AST.ReaderM SLLVM

def mkTy : MLIRType 0 → ExceptM SLLVM SLLVM.Ty
  | .int .Signless w => return Ty.bitvec w.toConcrete
  | _ => throw .unsupportedType

instance : TransformTy SLLVM 0 where
  mkTy := mkTy


def getOutputWidth (opStx : MLIR.AST.Op φ) (op : String) :
    Except TransformError (Width φ) := do
  match opStx.res with
  | res::[] =>
    match res.2 with
    | .int _ w => pure w
    | _ => throw <| .generic s!"The operation {op} must output an integer type"
  | _ => throw <| .generic s!"The operation {op} must have a single output"

/-- Given a variable of arbitrary type, return its width.

This relies on the fact that `bitvec _` is the only type currently modelled.
In future, this might start throwing errors, if the type is not a bitvec.
-/
def getVarWidth {Γ : Ctxt SLLVM.Ty} : (Σ t, Γ.Var t) → Nat
  | ⟨Ty.bitvec w, _⟩ => w

def parseOverflowFlags (op : AST.Op 0) : ReaderM LLVM.NoWrapFlags :=
  match op.getAttr? "overflowFlags" with
  | .none => return {}
  | .some y => match y with
    | .opaque_ "llvm.overflow" "nsw" => return ⟨true, false⟩
    | .opaque_ "llvm.overflow" "nuw" => return ⟨false, true⟩
    | .list [.opaque_ "llvm.overflow" "nuw", .opaque_ "llvm.overflow" "nsw"]
    | .list [.opaque_ "llvm.overflow" "nsw", .opaque_ "llvm.overflow" "nuw"] =>
        return ⟨true, true⟩
    | .opaque_ "llvm.overflow" s => throw <| .generic s!"The overflow flag {s} not allowed. \
        We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
    | _ => throw <| .generic s!"Unrecognised overflow flag found: {MLIR.AST.docAttrVal y}. \
        We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"

open InstCombine (MOp) in
instance : TransformExpr SLLVM 0 where
  mkExpr (Γ : Ctxt SLLVM.Ty) (opStx : MLIR.AST.Op 0) := do
  let args ← opStx.parseArgs Γ

  /- `binW` is the (lazily computed) width, assuming a binary operation -/
  let binW := do
  -- ^^ NOTE: `binW` is bound with := rather than ← on purpose, to ensure laziness
    let args ← args.assumeArity 2
    return getVarWidth args[0]

  /- `unW` is the (lazily computed) width, assuming an unary operation -/
  let unW := do
    let args ← args.assumeArity 1
    return getVarWidth args[0]

  let mkExprOf := opStx.mkExprOf (args? := args) Γ
  match opStx.name with
    -- Ternary Operations
    | "llvm.select" =>
        let args ← args.assumeArity 3
        let w := getVarWidth args[1]
        mkExprOf <| MOp.select w
    -- Binary Operations
    | "llvm.and"      => mkExprOf <| MOp.and (← binW)
    | "llvm.or"       => mkExprOf <| MOp.or (← binW) ⟨opStx.hasAttr "isDisjoint"⟩
    | "llvm.xor"      => mkExprOf <| MOp.xor (← binW)
    | "llvm.urem"     => mkExprOf <| MOp.urem (← binW)
    | "llvm.srem"     => mkExprOf <| MOp.srem (← binW)
    | "llvm.lshr"     => mkExprOf <| MOp.lshr (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.ashr"     => mkExprOf <| MOp.ashr (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.sdiv"     => mkExprOf <| MOp.sdiv (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.udiv"     => mkExprOf <| MOp.udiv (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.shl"      => mkExprOf <| MOp.shl (← binW) (← parseOverflowFlags opStx)
    | "llvm.add"      => mkExprOf <| MOp.add (← binW) (← parseOverflowFlags opStx)
    | "llvm.mul"      => mkExprOf <| MOp.mul (← binW) (← parseOverflowFlags opStx)
    | "llvm.sub"      => mkExprOf <| MOp.sub (← binW) (← parseOverflowFlags opStx)
    | "llvm.icmp.eq"  => mkExprOf <| MOp.icmp .eq (← binW)
    | "llvm.icmp.ne"  => mkExprOf <| MOp.icmp .ne (← binW)
    | "llvm.icmp.ugt" => mkExprOf <| MOp.icmp .ugt (← binW)
    | "llvm.icmp.uge" => mkExprOf <| MOp.icmp .uge (← binW)
    | "llvm.icmp.ult" => mkExprOf <| MOp.icmp .ult (← binW)
    | "llvm.icmp.ule" => mkExprOf <| MOp.icmp .ule (← binW)
    | "llvm.icmp.sgt" => mkExprOf <| MOp.icmp .sgt (← binW)
    | "llvm.icmp.sge" => mkExprOf <| MOp.icmp .sge (← binW)
    | "llvm.icmp.slt" => mkExprOf <| MOp.icmp .slt (← binW)
    | "llvm.icmp.sle" => mkExprOf <| MOp.icmp .sle (← binW)
    -- Unary Operations
    | "llvm.not"   => mkExprOf <| MOp.not (← unW)
    | "llvm.neg"   => mkExprOf <| MOp.neg (← unW)
    | "llvm.copy"  => mkExprOf <| MOp.copy (← unW)
    | "llvm.zext"  => mkExprOf <| MOp.zext (← unW) (← getOutputWidth opStx "zext") ⟨ opStx.hasAttr "nonNeg" ⟩
    | "llvm.sext"  => mkExprOf <| MOp.sext (← unW) (← getOutputWidth opStx "sext")
    | "llvm.trunc" => mkExprOf <| MOp.trunc (← unW) (← getOutputWidth opStx "trunc") (← parseOverflowFlags opStx)
    -- Constant
    | "llvm.mlir.constant" =>
      let ⟨val, ty⟩ ← opStx.getIntAttr "value"
      let opTy@(.bitvec w) ← mkTy ty
      mkExprOf <| MOp.const w val
    -- Fallback
    | opName => throw <| .unsupportedOp opName

instance : TransformReturn SLLVM 0 where
  mkReturn (Γ : Ctxt SLLVM.Ty) (opStx : MLIR.AST.Op 0) := do
  if opStx.name ≠ "llvm.return" then
    throw <| .unsupportedOp s!"Tried to build return out of non-return statement {opStx.name}"
  else
    let args ← (← opStx.parseArgs Γ).assumeArity 1
    let ⟨ty, v⟩ := args[0]
    return ⟨.pure, ty, Com.ret v⟩

elab "[sllvm| " reg:mlir_region "]" : term =>
  SSA.elabIntoCom' reg SLLVM
