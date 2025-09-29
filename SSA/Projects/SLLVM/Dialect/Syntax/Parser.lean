/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq

import LeanMLIR.MLIRSyntax
import SSA.Projects.SLLVM.Dialect.Basic

namespace LeanMLIR.SLLVM

-- open Qq Lean Meta Elab.Term Elab Command
open MLIR
open MLIR.AST

private abbrev ReaderM := MLIR.AST.ReaderM SLLVM

def mkTy : MLIRType 0 → ExceptM SLLVM SLLVM.Ty
  | .int .Signless w => return Ty.bitvec w.toConcrete
  | .undefined "ptr" => return Ty.ptr
  | _ => throw .unsupportedType

instance : TransformTy SLLVM 0 where
  mkTy := mkTy


def getOutputWidth (opStx : MLIR.AST.Op 0) :
    Except TransformError Nat := do
  match opStx.res with
  | res::[] =>
    match res.2 with
    | .int _ (.concrete w) => pure w
    | _ => throw <| .generic s!"The operation {opStx.name} must output an integer type"
  | _ => throw <| .generic s!"The operation {opStx.name} must have a single output"

/-- Given a variable of arbitrary type, return its width.

This relies on the fact that `bitvec _` is the only type currently modelled.
In future, this might start throwing errors, if the type is not a bitvec.
-/
def getIntWidth {Γ : Ctxt SLLVM.Ty} : (Σ t, Γ.Var t) → ReaderM Nat
  | ⟨Ty.bitvec w, _⟩ => return w
  | ⟨t, _⟩ => throw <| .generic s!"Expected type `bitvec _`, but found: {t}"

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

instance : DialectParse SLLVM 0 where
  isValidReturn Γ opStx := return opStx.name == "llvm.return"

  mkExpr (Γ : Ctxt SLLVM.Ty) (opStx : MLIR.AST.Op 0) := do
  let args ← opStx.parseArgs Γ

  /- `binW` is the (lazily computed) width, assuming a binary operation -/
  let binW := do
  -- ^^ NOTE: `binW` is bound with := rather than ← on purpose, to ensure laziness
    let args ← args.assumeArity 2
    getIntWidth args[0]

  /- `unW` is the (lazily computed) width, assuming an unary operation -/
  let unW := do
    let args ← args.assumeArity 1
    getIntWidth args[0]

  let getOutputWidth := getOutputWidth opStx

  let mkExprOf := opStx.mkExprOf (args? := args) Γ
  match opStx.name with
    -- new SLLVM operations
    | "ptr.add" => mkExprOf <| .ptradd
    | "ptr.load" => mkExprOf <| .load (← getOutputWidth)
    | "ptr.store" => do
        let args ← args.assumeArity 2
        mkExprOf <| .store (← getIntWidth args[1])
    | "ptr.alloca" => mkExprOf <| .alloca 8
    -- ^^ TODO: `llvm.alloca` ought to have an attribute `elem_type` which indicates the type being allocated
    -- Ternary Operations
    | "llvm.select" =>
        let args ← args.assumeArity 3
        let w ← getIntWidth args[1]
        mkExprOf <| Op.select w
    -- Binary Operations
    | "llvm.and"      => mkExprOf <| Op.and (← binW)
    | "llvm.or"       => mkExprOf <| Op.or (← binW) ⟨opStx.hasAttr "isDisjoint"⟩
    | "llvm.xor"      => mkExprOf <| Op.xor (← binW)
    | "llvm.urem"     => mkExprOf <| Op.urem (← binW)
    | "llvm.srem"     => mkExprOf <| Op.srem (← binW)
    | "llvm.lshr"     => mkExprOf <| Op.lshr (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.ashr"     => mkExprOf <| Op.ashr (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.sdiv"     => mkExprOf <| Op.sdiv (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.udiv"     => mkExprOf <| Op.udiv (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.shl"      => mkExprOf <| Op.shl (← binW) (← parseOverflowFlags opStx)
    | "llvm.add"      => mkExprOf <| Op.add (← binW) (← parseOverflowFlags opStx)
    | "llvm.mul"      => mkExprOf <| Op.mul (← binW) (← parseOverflowFlags opStx)
    | "llvm.sub"      => mkExprOf <| Op.sub (← binW) (← parseOverflowFlags opStx)
    | "llvm.icmp.eq"  => mkExprOf <| Op.icmp .eq (← binW)
    | "llvm.icmp.ne"  => mkExprOf <| Op.icmp .ne (← binW)
    | "llvm.icmp.ugt" => mkExprOf <| Op.icmp .ugt (← binW)
    | "llvm.icmp.uge" => mkExprOf <| Op.icmp .uge (← binW)
    | "llvm.icmp.ult" => mkExprOf <| Op.icmp .ult (← binW)
    | "llvm.icmp.ule" => mkExprOf <| Op.icmp .ule (← binW)
    | "llvm.icmp.sgt" => mkExprOf <| Op.icmp .sgt (← binW)
    | "llvm.icmp.sge" => mkExprOf <| Op.icmp .sge (← binW)
    | "llvm.icmp.slt" => mkExprOf <| Op.icmp .slt (← binW)
    | "llvm.icmp.sle" => mkExprOf <| Op.icmp .sle (← binW)
    -- Unary Operations
    | "llvm.not"   => mkExprOf <| Op.not (← unW)
    | "llvm.neg"   => mkExprOf <| Op.neg (← unW)
    | "llvm.copy"  => mkExprOf <| Op.copy (← unW)
    | "llvm.zext"  => mkExprOf <| Op.zext (← unW) (← getOutputWidth) ⟨ opStx.hasAttr "nonNeg" ⟩
    | "llvm.sext"  => mkExprOf <| Op.sext (← unW) (← getOutputWidth)
    | "llvm.trunc" => mkExprOf <| Op.trunc (← unW) (← getOutputWidth) (← parseOverflowFlags opStx)
    -- Constant
    | "llvm.mlir.constant" => do
      let ⟨val, ty⟩ ← opStx.getIntAttr "value"
      let opTy ← mkTy ty
      let Ty.bitvec w := opTy
        | throw <| .generic s!"Expected a `bitvec _`, but found: {opTy}"
      mkExprOf <| Op.const w val
    -- Fallback
    | opName => throw <| .unsupportedOp opName

elab "[sllvm| " reg:mlir_region "]" : term =>
  SSA.elabIntoCom' reg SLLVM
