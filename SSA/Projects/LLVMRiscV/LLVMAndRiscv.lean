import SSA.Projects.InstCombine.Base
import SSA.Projects.RISCV64.Base
import SSA.Projects.RISCV64.Syntax
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
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
  deriving DecidableEq, Repr, Lean.ToExpr

inductive Op where
  | llvm : LLVM.Op -> Op
  | riscv : RISCV64.RV64.Op -> Op
  | castRiscv : Nat → Op
  | castLLVM : Nat → Op
  deriving DecidableEq, Repr, Lean.ToExpr

/-- Semantics of an unrealized conversion cast from RISC-V 64 to LLVM.
We wrap `BitVec 64`in `Option (BitVec 64)` -/
@[simp_riscv]
def castriscvToLLVM (toCast : BitVec 64) : PoisonOr (BitVec w) :=
  .value (BitVec.signExtend w toCast)

/--
Semantics of an unrealized conversion cast from LLVM to RISC-V.
This cast attempts to lower an `(Option (BitVec 64))` to a concrete `(BitVec 64)`.
If the value is `some`, we extract the underlying `BitVec`.
If it is `none` (e.g., an LLVM poison value), we default to the zero `BitVec`.
-/
@[simp_riscv]
def castLLVMToriscv (toCast : PoisonOr (BitVec w)) : BitVec 64 :=
  BitVec.signExtend 64 (toCast.toOption.getD 0#w)

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
  | .castRiscv w =>
      {sig := [Ty.riscv .bv], returnTypes := [Ty.llvm (.bitvec w)], regSig := []}
  | .castLLVM w =>
      {sig := [Ty.llvm (.bitvec w)], returnTypes := [Ty.riscv .bv], regSig := []}

instance : ToString LLVMPlusRiscV.Op  where
  toString := fun
  | .llvm llvm    => toString llvm
  | .riscv riscv  => toString riscv
  | .castLLVM _ => "builtin.unrealized_conversion_cast"
  | .castRiscv _  => "builtin.unrealized_conversion_cast"

instance : ToString LLVMPlusRiscV.Ty where
  toString := fun
  | .llvm llvm    => toString llvm
  | .riscv riscv  => toString riscv

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
  | .llvm llvmOp, args, .nil => do
      let xs ← DialectDenote.denote llvmOp (llvmArgsFromHybrid args) .nil
      return xs.map' Ty.llvm (fun t x => x)
  | .riscv (riscvOp), args, .nil => do
      let xs ← DialectDenote.denote riscvOp (riscvArgsFromHybrid args) .nil
      return xs.map' Ty.riscv (fun t x => x)
  | .castRiscv _ , elemToCast, _ =>
    let toCast : BitVec 64 :=
      elemToCast.getN 0 (by simp [DialectSignature.sig, signature]) -- adapting to the newly introduced PoisonOr wrapper.
    [castriscvToLLVM toCast]ₕ
  | .castLLVM _,
    (elemToCast : HVector TyDenote.toType [Ty.llvm (.bitvec _)]), _ =>
    let toCast : PoisonOr (BitVec _) :=
      elemToCast.getN 0 (by simp)
    [castLLVMToriscv toCast]ₕ

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
theorem returnTypes_map_signature_eq {s : Signature α} {f : α → β} :
  Signature.returnTypes (f <$> s) = f <$> s.returnTypes := rfl

/- We tag the following definitions as `simp` and `simp_denote`
   so that `simp_peephole` and `simp` include them during simplification. -/
attribute [simp, simp_denote] HVector.mapM'
attribute [simp, simp_denote] HVector.map'

/--  This function lifts an expression from the `InstCombine` dialect into the corresponding
  expression in the hybrid dialect `LLVMPlusRiscV`.
  The hybrid dialect models LLVM-type operations, so this function transforms an InstCombine expression
  into an equivalent LLVM expression within the hybrid dialect. It is invoked in the hybrid dialect parser,
  where we attempt to reuse the existing LLVM parser, which returns a `Com` in the `InstCombine` dialect.
  To integrate the parsed `InstCombine` expression back into the hybrid dialect, we invoke this function.
 -/
@[simp_denote]
def transformExprLLVM (e : Expr (InstCombine.MetaLLVM 0) (ctxtTransformToLLVM Γ) eff ty) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Expr LLVMPlusRiscV Γ eff (.llvm <$> ty)) :=
    match e with
    | Expr.mk op1 ty_eq1 eff_le1 args1 regArgs1 => do
        let args' : HVector (Ctxt.Var Γ) (.llvm <$> DialectSignature.sig op1) ←
          args1.mapM' fun t v => do
            match h : Γ[v.val]? with
            | some ty' => do
              match hty : ty' with
              | .riscv _ => /- This is impossible, because mixing LLVM and RiscV variables would've already
                              been caught by the LLVM parser before invoking this function. -/
                throw <| .generic s!"INTERNAL ERROR: This case is impossible, LLVM expression is pointing to RISCV variable.
                Should haven been caught by the LLVM parser."
              | .llvm originalLLVMTy =>
                if hty' : originalLLVMTy = t then
                  return ⟨v.val, by rw [h, hty']⟩
                else
                  throw <|.generic s!"INTERNAL ERROR: This case is impossible, LLVM expression is pointing to an incorrect bitwidth LLVM argument."
            | none =>
              -- This is impossible, because ctxtTransformToLLVM is a `List.map`, which always maintains length.
              throw <| .generic s!"INTERNAL ERROR: This case is impossible, as 'ctxtTransformToLLVM' is length-preserving."
        return Expr.mk
          (op := Op.llvm op1)
          (eff_le := eff_le1)
          (ty_eq := by cases ty_eq1; rfl)
          (args := args')
          (regArgs := HVector.nil)

/--
  This function is analogous to `transformExprLLVM`. It lifts an expression
  in the `RISCV64.RV64` dialect into an expression in the `LLVMPlusRiscV` hybrid dialect.
  This function is used in the hybrid dialect parser after successfully parsing a RISC-V expression of type Com.
  To lift it back into the hybrid dialect — that is, to convert it into a RISC-V computation
  representation within the hybrid dialect — we invoke this function.
.-/
@[simp_denote]
def transformExprRISCV (e : Expr RISCV64.RV64 (ctxtTransformToRiscV Γ) eff ty) :
  MLIR.AST.ReaderM LLVMPlusRiscV (Expr LLVMPlusRiscV Γ eff (.riscv <$> ty)) :=
    match e with
    | Expr.mk op1 ty_eq1 eff_le1 args1 regArgs1 => do
        let args' : HVector (Ctxt.Var Γ) (.riscv <$> DialectSignature.sig op1) ←
          args1.mapM' fun t v => do
            let i := v.toFin.cast <| by
              simp [ctxtTransformToRiscV]; rfl

            match h : Γ.toList.get i with
            | .llvm _ => /- This is impossible, because mixing LLVM and RiscV variables would've already been
                          caught by RISC-V parserbeen caught by the RISC-V parser before invoking this function. -/
                throw <| .generic s!"INTERNAL ERROR: This case is impossible, RISCV expression is pointing to LLVM variable.
                Should have been caught by the RISC-V parser."
            | .riscv originalRISCVTy =>
                if hty' : originalRISCVTy = t then
                  return ⟨i, by rcases Γ; simp_all⟩
                else
                  throw <|.generic s!"INTERNAL ERROR: This case is impossible, RISCV expression is pointing to an incorrect bitwidth LLVM argument."
        return Expr.mk
          (op := Op.riscv op1)
          (eff_le := eff_le1)
          (ty_eq := by cases ty_eq1; rfl)
          (args := args')
          (regArgs := HVector.nil)

instance : MLIR.AST.TransformTy LLVMPlusRiscV 0 where
  mkTy tStx := do
  try
    let llvmParse ← InstcombineTransformDialect.mkTy tStx
    return .llvm llvmParse
  catch llvmErr =>
    try
      let riscvParse ← RiscvMkExpr.mkTy tStx
      return .riscv riscvParse
    catch riscvErr =>
        throw <|.generic s!" INTERNAL ERROR : While trying to transform from MLIR AST to dialect specific AST
         the transformation failed. The errors thrown are:
          s!{(toString (repr riscvErr))} and s!{(toString (repr llvmErr ))}"

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Σ eff ty, Expr LLVMPlusRiscV Γ eff ty) := do
  let args ← opStx.parseArgs Γ
  if (opStx.name = "builtin.unrealized_conversion_cast") then
    let mkExprOf := opStx.mkExprOf (args? := args) Γ
    let args ← (← opStx.parseArgs Γ).assumeArity 1
    let ⟨ty, v⟩ := args[0]
    match ty with
      | .riscv (.bv) =>
         match opStx.res with
        | res::[] =>
           match res.2 with
          | .int _ w =>  mkExprOf <| .castRiscv w.toConcrete
          | _ => throw <| .generic s!"A cast operation must output an integer type"
        | _ => throw <| .generic s!"A cast operation must only have one return type"
      | .llvm (.bitvec w) => mkExprOf <| (.castLLVM  w.toConcrete)
  else
    let llvmParse := InstcombineTransformDialect.mkExpr (ctxtTransformToLLVM  Γ) opStx (← read)
    match llvmParse with
      | .ok ⟨eff, ty, expr⟩ => do
        let v ← transformExprLLVM expr
        return ⟨eff, .llvm <$> ty, v⟩
      | .error  (_) => do
        let ⟨eff, ty , expr⟩ ← RiscvMkExpr.mkExpr (ctxtTransformToRiscV Γ) opStx (← read)
        let v ← transformExprRISCV expr
        return ⟨eff, .riscv <$> ty, v⟩

instance : MLIR.AST.TransformExpr (LLVMPlusRiscV) 0   where
  mkExpr := mkExpr

@[simp_denote]
def transformVarLLVM (v : Ctxt.Var (ctxtTransformToLLVM Γ) ty) :
     MLIR.AST.ReaderM LLVMPlusRiscV (Ctxt.Var Γ (LLVMRiscV.Ty.llvm ty)) :=
  if h : Γ[v.1]? = some (LLVMRiscV.Ty.llvm ty) then
   return ⟨_ , h⟩
  else
    throw <| .generic s!"TransformVarLLVM FAILED: Tried to convert a variable of wrong type."

@[simp_denote]
def transformVarRISCV (v : Ctxt.Var (ctxtTransformToRiscV Γ) ty) :
    MLIR.AST.ReaderM LLVMPlusRiscV (Ctxt.Var Γ (LLVMRiscV.Ty.riscv ty)) :=
  if h : Γ[v.1]? = some (LLVMRiscV.Ty.riscv ty) then
   return ⟨_ , h⟩
  else
     throw <| .generic s!"TransformVarRISCV FAILED: Tried to convert a variable of wrong type."

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM LLVMPlusRiscV
  (Σ eff ty, Com LLVMPlusRiscV Γ eff ty) := do
  let llvmParseReturn := InstcombineTransformDialect.mkReturn (ctxtTransformToLLVM  Γ) opStx (← read)
  match llvmParseReturn with
  | .ok ⟨eff, ty, Com.rets vs⟩ =>
    let vs : HVector Γ.Var (.llvm <$> ty) ←
      vs.mapM' (fun _ => transformVarLLVM)
    return ⟨eff, .llvm <$> ty, Com.rets vs⟩
  | .error e =>
    match e with
    | .unsupportedOp _s=>
      let ⟨eff, ty , com⟩ ← RiscvMkExpr.mkReturn (ctxtTransformToRiscV Γ) opStx (← read)
      match com with
      | Com.rets vs =>
        let vs : HVector Γ.Var (.riscv <$> ty) ←
          vs.mapM' (fun _ => transformVarRISCV)
        return ⟨eff, .riscv <$> ty, Com.rets vs⟩
      | _ => throw <| .unsupportedOp s!"Unable to parse return as either LLVM type or RISCV type."
    | e => throw e
  | _ => throw <| .generic s!"Unable to parse return as the program is impure and therefore not supported."

instance : MLIR.AST.TransformReturn LLVMPlusRiscV 0 where
  mkReturn := mkReturn

open Qq in
instance : DialectToExpr LLVMPlusRiscV where
  toExprDialect := q(LLVMPlusRiscV)
  toExprM := q(Id)

elab "[LV|" reg:mlir_region "]" : term => do
  SSA.elabIntoCom' reg LLVMPlusRiscV

end LLVMRiscV
