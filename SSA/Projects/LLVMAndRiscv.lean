import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.Util.ConcreteOrMVar
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.Syntax
import SSA.Projects.RISCV64.Base
import SSA.Projects.RISCV64.Semantics
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Core.HVector

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

/-- Defining an instance for LLVM.Ty from InstCombine.Ty instance.-/
instance : DecidableEq LLVM.Ty :=
  fun a b => by
    simp only [LLVM] at a b
    exact (inferInstanceAs (DecidableEq (InstCombine.MTy 0)) a b)

/-- Defining an instance for LLVM.Op from InstCombine.Op instance. -/
instance : DecidableEq LLVM.Op :=
  fun a b => by
    simp only [LLVM] at a b
    exact (inferInstanceAs (DecidableEq (InstCombine.MOp 0)) a b)

inductive Ty where
  | llvm : (LLVM.Ty) -> Ty
  | riscv : (Dialect.Ty RISCV64.RV64) -> Ty
  deriving DecidableEq, Repr

inductive Op where
  | llvm : (Dialect.Op LLVM) -> Op
  | riscv : (Dialect.Op RISCV64.RV64) -> Op
  | builtin.unrealized_conversion_cast.riscvToLLVM : Op
  | builtin.unrealized_conversion_cast.LLVMToriscv : Op
  deriving DecidableEq, Repr

/-- Semantics of an unrealized conversion cast from RISC-V 64 to LLVM.
We wrap `BitVec 64`in `Option (BitVec 64)` -/
def builtin.unrealized_conversion_cast.riscvToLLVM (toCast : BitVec 64 ) : Option (BitVec 64 ) := some toCast

/--
Semantics of an unrealized conversion cast from LLVM to RISC-V.
This cast attempts to lower an `(Option (BitVec 64))` to a concrete `(BitVec 64)`.
If the value is `some`, we extract the underlying `BitVec`.
If it is `none` (e.g., an LLVM poison value), we default to the zero `BitVec`.
-/
def builtin.unrealized_conversion_cast.LLVMToriscv (toCast : Option (BitVec 64)) : BitVec 64 := toCast.getD 0#64

@[simp]
abbrev LLVMPlusRiscV : Dialect where
  Op := Op
  Ty := Ty

instance : TyDenote (Dialect.Ty LLVMPlusRiscV) where
  toType := fun
    | .llvm llvmTy => TyDenote.toType llvmTy
    | .riscv riscvTy => TyDenote.toType riscvTy

@[simp]
instance LLVMPlusRiscVSignature : DialectSignature LLVMPlusRiscV where
  signature
  | .llvm llvmOp => .llvm <$> DialectSignature.signature llvmOp
  | .riscv riscvOp => .riscv <$> DialectSignature.signature riscvOp
  | .builtin.unrealized_conversion_cast.riscvToLLVM =>
      {sig := [Ty.riscv .bv], outTy := Ty.llvm (.bitvec 64), regSig := []}
  | .builtin.unrealized_conversion_cast.LLVMToriscv =>
      {sig := [Ty.llvm (.bitvec 64)], outTy := (Ty.riscv .bv), regSig := []}

instance : ToString (Dialect.Ty LLVMPlusRiscV)  where
  toString t := repr t |>.pretty

@[simp_denote]
def llvmArgsFromHybrid : {tys : List LLVM.Ty} → HVector TyDenote.toType (tys.map LLVMRiscV.Ty.llvm) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (llvmArgsFromHybrid xs)

@[simp_denote]
def riscvArgsFromHybrid : {tys : List RISCV64.RV64.Ty} → HVector TyDenote.toType (tys.map LLVMRiscV.Ty.riscv) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (riscvArgsFromHybrid xs)

@[simp, reducible]
instance : DialectDenote (LLVMPlusRiscV) where
  denote
  | .llvm (llvmOp), args , .nil => DialectDenote.denote llvmOp (llvmArgsFromHybrid args) .nil
  | .riscv (riscvOp), args , .nil => DialectDenote.denote riscvOp (riscvArgsFromHybrid args) .nil
  | .builtin.unrealized_conversion_cast.riscvToLLVM, elemToCast, _ =>
    let toCast : (BitVec 64) := (elemToCast.getN 0 (by simp [DialectSignature.sig, signature])) -- adapting to the newly introduced PoisonOr wrapper.
    let casted : Option (BitVec 64) := builtin.unrealized_conversion_cast.riscvToLLVM toCast
    PoisonOr.ofOption casted
  | .builtin.unrealized_conversion_cast.LLVMToriscv,
    (elemToCast : HVector TyDenote.toType [Ty.llvm (.bitvec 64)]), _ =>
    let toCast : PoisonOr (BitVec 64) := (elemToCast.getN 0 (by simp [DialectSignature.sig, signature]))
    builtin.unrealized_conversion_cast.LLVMToriscv toCast.toOption

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

attribute [simp, simp_denote] HVector.ubermapM
attribute [simp, simp_denote] HVector.ubermap

end LLVMRiscV
