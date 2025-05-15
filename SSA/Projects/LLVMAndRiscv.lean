import SSA.Projects.InstCombine.Base
import SSA.Projects.RISCV64.Base

open InstCombine(LLVM)
namespace LLVMRiscV


/-!
# Hybrid dialect

This file contains a hybrid dialect combining
SSA.Projects.RISCV64 and SSA.Projects.InstCombine.
Modelling two dialects within a larger hybrid dialect allows us
to reuse existing infrastructure such as the Peephole Rewriter which
currently only operates within one dialect.

To make the intermixing of the type system across the dialects work,
we insert unrealized_conversion_cast like MLIR does during lowering.
see: section (UnrealizedConversionCastOp)
https://mlir.llvm.org/docs/Dialects/Builtin/#builtinunrealized_conversion_cast-unrealizedconversioncastop
 -/

inductive Ty where
  | llvm : LLVM.Ty -> Ty
  | riscv : RISCV64.RV64.Ty -> Ty
  deriving DecidableEq, Repr

inductive Op where
  | llvm : LLVM.Op -> Op
  | riscv : RISCV64.RV64.Op -> Op
  | castRiscv : Op
  | castLLVM : Op
  deriving DecidableEq, Repr

/-- Semantics of an unrealized conversion cast from RISC-V 64 to LLVM.
We wrap `BitVec 64`in `Option (BitVec 64)` -/
def castriscvToLLVM (toCast : BitVec 64) : PoisonOr (BitVec 64) :=
  .value toCast

/--
Semantics of an unrealized conversion cast from LLVM to RISC-V.
This cast attempts to lower an `(Option (BitVec 64))` to a concrete `(BitVec 64)`.
If the value is `some`, we extract the underlying `BitVec`.
If it is `none` (e.g., an LLVM poison value), we default to the zero `BitVec`.
-/
def castLLVMToriscv (toCast : PoisonOr (BitVec 64)) : BitVec 64 :=
  toCast.toOption.getD 0#64

@[simp]
abbrev LLVMPlusRiscV : Dialect where
  Op := Op
  Ty := Ty

instance : TyDenote LLVMPlusRiscV.Ty where
  toType := fun
    | .llvm llvmTy => TyDenote.toType llvmTy
    | .riscv riscvTy => TyDenote.toType riscvTy

@[simp]
instance LLVMPlusRiscVSignature : DialectSignature LLVMPlusRiscV where
  signature
  | .llvm llvmOp => .llvm <$> DialectSignature.signature llvmOp
  | .riscv riscvOp => .riscv <$> DialectSignature.signature riscvOp
  | .castRiscv =>
      {sig := [Ty.riscv .bv], outTy := Ty.llvm (.bitvec 64), regSig := []}
  | .castLLVM =>
      {sig := [Ty.llvm (.bitvec 64)], outTy := (Ty.riscv .bv), regSig := []}

instance : ToString LLVMPlusRiscV.Ty  where
  toString t := repr t |>.pretty

@[simp_denote]
def llvmArgsFromHybrid : {tys : List LLVM.Ty} →
  HVector TyDenote.toType (tys.map LLVMRiscV.Ty.llvm) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (llvmArgsFromHybrid xs)

@[simp_denote]
def riscvArgsFromHybrid : {tys : List RISCV64.RV64.Ty} →
  HVector TyDenote.toType (tys.map LLVMRiscV.Ty.riscv) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (riscvArgsFromHybrid xs)

@[simp, reducible]
instance : DialectDenote (LLVMPlusRiscV) where
  denote
  | .llvm (llvmOp), args, .nil =>
      DialectDenote.denote llvmOp (llvmArgsFromHybrid args) .nil
  | .riscv (riscvOp), args, .nil =>
      DialectDenote.denote riscvOp (riscvArgsFromHybrid args) .nil
  | .castRiscv, elemToCast, _ =>
    let toCast : BitVec 64 :=
      elemToCast.getN 0 (by simp [DialectSignature.sig, signature]) -- adapting to the newly introduced PoisonOr wrapper.
    castriscvToLLVM toCast
  | .castLLVM,
    (elemToCast : HVector TyDenote.toType [Ty.llvm (.bitvec 64)]), _ =>
    let toCast : PoisonOr (BitVec 64) :=
      elemToCast.getN 0 (by simp [DialectSignature.sig, signature])
    castLLVMToriscv toCast

@[simp_denote]
def ctxtTransformToLLVM  (Γ : Ctxt LLVMPlusRiscV.Ty) :=
  Ctxt.map  (fun ty  =>
    match ty with
    | .llvm someLLVMTy => someLLVMTy
    | .riscv _  => .bitvec 999 -- To identify non llvm type values.
  ) Γ

@[simp_denote]
def ctxtTransformToRiscV (Γ : Ctxt LLVMPlusRiscV.Ty) :=
  Ctxt.map  (fun ty  =>
    match ty with
    | .riscv someRiscVTy => someRiscVTy
    | _  => .bv
  ) Γ

/-- Projection of `outTy` commutes with `Signature.map`. -/
@[simp, simp_denote]
theorem outTy_map_signature_eq {s : Signature α} {f : α → β} :
  Signature.outTy (f <$> s) = f s.outTy := rfl

/- We tag the following definitions as `simp` and `simp_denote`
   so that `simp_peephole` and `simp` include them during simplification. -/
attribute [simp, simp_denote] outTy_map_signature_eq
attribute [simp, simp_denote] HVector.mapM'
attribute [simp, simp_denote] HVector.map'

end LLVMRiscV
