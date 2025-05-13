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

open InstCombine(LLVM)
namespace LLVMRiscV

/-! # Hybrid dialect
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

-- Defining an instance for LLVM.Ty from InstCombine.Ty instance.
instance : DecidableEq LLVM.Ty :=
  fun a b => by
    simp only [LLVM] at a b
    exact (inferInstanceAs (DecidableEq (InstCombine.MTy 0)) a b)

-- Defining an instance for LLVM.Op from InstCombine.Op instance.
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

/- Semantics of an unrealized conversion cast from RISC-V 64 to LLVM.
We wrap the 64-bit BitVec in Option.some. -/
def builtin.unrealized_conversion_cast.riscvToLLVM (toCast : BitVec 64 ) : Option (BitVec 64 ) := some toCast

/-
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
    | .riscv someRiscVTy  => someRiscVTy
    | _  => .bv
  ) Γ

/-- Projection of `outTy` commutes with `Signature.map`. -/
@[simp, simp_denote]
theorem outTy_map_signature_eq {s : Signature α} {f : α → β} :
  Signature.outTy (f <$> s) = f s.outTy := rfl

def _root_.HVector.foldlM {B : Type*} [Monad m] (f : ∀ (a : α), B → A a → m B) :
    ∀ {l : List α}, (init : B) → (as : HVector A l) → m B
  | [],   b, .nil       => return b
  | t::_, b, .cons a as => do foldlM f (← f t b a) as

/-! Simultaneous map on the type and value level of an HVector. -/
@[simp_denote]
def _root_.HVector.ubermap {A : α → Type} {B : β → Type}
    {l : List α}
    (F : α → β)
    (f : {a : α} → (v : A a) → B (F a) )
    (as : HVector A l) : (HVector B (F <$> l)) :=
  match l, as with
  | [], .nil => .nil
  | _t :: _ts, .cons a as => HVector.cons (f a) (HVector.ubermap F f as)

/-!
Simultaneous map on the type and value level of an HVector while
performing monadic effects for value translation.-/
@[simp_denote]
def _root_.HVector.ubermapM [Monad m] {A : α → Type} {B : β → Type}
    {l : List α}
    {F : α → β}
    (f : (a : α) → (v : A a) → m (B (F a)) )
    (as : HVector A l) : m (HVector B (F <$> l)) :=
  match l, as with
  | [], .nil => return .nil
  | t :: _ts, .cons a as => do return HVector.cons (← f t a) (← HVector.ubermapM f as)

@[simp_denote]
def transformExprLLVM (e : Expr (InstCombine.MetaLLVM 0) (ctxtTransformToLLVM Γ) eff ty) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Expr LLVMPlusRiscV Γ eff (.llvm ty)) :=
    match e with
    | Expr.mk op1 ty_eq1 eff_le1 args1 regArgs1 => do
        let args' : HVector (Ctxt.Var Γ) (.llvm <$> DialectSignature.sig op1) ←
          args1.ubermapM fun t v => do
            match h : Γ.get? v.val with
            | some ty' => do
              match hty : ty' with
              | .riscv _ =>
                throw <| .generic s!"INTERNAL ERROR: This case is impossible, LLVM expression is pointing to RISC-V variable."
              | .llvm originalLLVMTy =>
                if hty' : originalLLVMTy = t then
                  return ⟨v.val, by rw [h, hty']⟩
                else
                  throw <|.generic s!"INTERNAL ERROR: This case is impossible, LLVM expression is pointing to an incorrect bitwidth LLVM argument."
            | none =>
              -- this is impossible, because ctxtTransformToLLVM is a `List.map`, which always maintains length.
              throw <| .generic s!"INTERNAL ERROR: This case is impossible, as 'ctxtTransformToLLVM' is length-preserving."
        return Expr.mk
          (op := Op.llvm op1)
          (eff_le := eff_le1)
          (ty_eq := ty_eq1 ▸ rfl)
          (args := args')
          (regArgs := HVector.nil)

def transformExprRISCV (e : Expr (RISCV64.RV64) (ctxtTransformToRiscV Γ) eff ty) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Expr LLVMPlusRiscV Γ eff (.riscv ty)) :=
    match e with
    | Expr.mk op1 ty_eq1 eff_le1 args1 regArgs1 => do
        let args' : HVector (Ctxt.Var Γ) (.riscv <$> DialectSignature.sig op1) ←
          args1.ubermapM fun t v => do
            match h : Γ.get? v.val with
            | some ty' => do
              match hty : ty' with
              | .llvm _ =>
                throw <| .generic s!"INTERNAL ERROR: This case is impossible, RISCV expression is pointing to LLVM variable."
              | .riscv originalRISCVTy =>
                if hty' : originalRISCVTy = t then
                  return ⟨v.val, by rw [h, hty']⟩
                else
                  throw <|.generic s!"INTERNAL ERROR: This case is impossible, RISCV expression is pointing to an incorrect bitwidth LLVM argument."
            | none =>
              -- this is impossible, because ctxtTransformToLLVM is a `List.map`, which always maintains length.
              throw <| .generic s!"INTERNAL ERROR: This case is impossible, as 'ctxtTransformToLLVM' is length-preserving."
        return Expr.mk
          (op := Op.riscv op1)
          (eff_le := eff_le1)
          (ty_eq := ty_eq1 ▸ rfl)
          (args := args')
          (regArgs := HVector.nil)

/-
To be able to perform staged parsing I had to make a change to the following file:
SSA.Core.MLIRSyntax.Transform.lean
There I modified the transform error to not dependend on a dialect anymore.
Before each dialect had its own exception monad ExceptM which did not allow me to perform staged parsing.
-/
instance : MLIR.AST.TransformTy (LLVMPlusRiscV) 0 where
  mkTy tStx := do
    try
      let llvmParse ← InstcombineTransformDialect.mkTy tStx
      return .llvm llvmParse
    catch _llvmErr =>
      try
        let riscvParse ← RiscvMkExpr.mkTy tStx
        return .riscv riscvParse
      catch _riscvErr =>
        throw <| .generic s!"unable to parse type as either LLVM type or RISCV type."

def mkExprHybrid (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Σ eff ty, Expr (LLVMPlusRiscV) Γ eff ty) := do
  if (opStx.name = "builtin.unrealized_conversion_cast" )  then
    match opStx.args with
    | v₁Stx :: [] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, opStx.name with
      | .riscv (.bv) , "builtin.unrealized_conversion_cast"=>
              return ⟨ .pure,  .llvm (.bitvec 64) ,⟨ .builtin.unrealized_conversion_cast.riscvToLLVM , by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
      | .llvm (.bitvec 64) , "builtin.unrealized_conversion_cast"=>
              return ⟨ .pure, .riscv (.bv) ,⟨ .builtin.unrealized_conversion_cast.LLVMToriscv , by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
      | _ , _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
    | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
  else
    let llvmParse := InstcombineTransformDialect.mkExpr (ctxtTransformToLLVM  Γ) opStx (← read)
    match llvmParse with
      | .ok ⟨eff, ty, expr⟩ => do
        let v ← transformExprLLVM expr
        return ⟨eff, .llvm ty, v⟩
      | .error  (_) => do --- here I continue with Risc-V parsing whenever LLVM parsing failed.
        let ⟨eff, (ty) , expr⟩ ← RiscvMkExpr.mkExpr (ctxtTransformToRiscV Γ) opStx (← read)
        let v ← transformExprRISCV expr
        return ⟨eff, .riscv ty , v⟩

instance : MLIR.AST.TransformExpr (LLVMPlusRiscV ) 0   where
  mkExpr := mkExprHybrid

-- TO DO: this proof still needs to be completed.
@[simp_denote]
def transformVarLLVM (v :  Ctxt.Var (ctxtTransformToLLVM Γ) ty) :   Ctxt.Var Γ (LLVMRiscV.Ty.llvm ty) :=
  match v with
  | ⟨h, ty⟩ => ⟨h, by
    sorry⟩

@[simp_denote]
def transformVarRISCV (v :  Ctxt.Var (ctxtTransformToRiscV Γ) ty) :   Ctxt.Var Γ (LLVMRiscV.Ty.riscv ty) :=
  match v with
  | ⟨h, ty⟩ => ⟨h, by
    sorry⟩

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (LLVMPlusRiscV)
    (Σ eff ty, Com LLVMPlusRiscV Γ eff ty) := do
    let llvmParseReturn := InstcombineTransformDialect.mkReturn (ctxtTransformToLLVM  Γ) opStx (← read)
    match llvmParseReturn with
    | .ok ⟨eff, ty, Com.ret v⟩ =>
      return ⟨eff, .llvm ty, Com.ret (transformVarLLVM v)⟩
    | _ =>
      let ⟨eff, ty , com⟩ ← RiscvMkExpr.mkReturn (ctxtTransformToRiscV Γ) opStx (← read)
      match com with
      |Com.ret v =>
        return ⟨eff, .riscv ty, Com.ret (transformVarRISCV v)⟩
      |_ => throw <| .generic s!"Unable to parse return as either LLVM type or RISC-V type."

instance : MLIR.AST.TransformReturn (LLVMPlusRiscV) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[LV|" reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(LLVMPlusRiscV)

end LLVMRiscV








section examplesHybridDialect
open LLVMRiscV

/-! # Testing
This section contains simple, small test cases to check wether the hybrid dialect parses correctly.
Additionaly these are examples on writting down the hybrid dialect.
-/

def RISCVReturn := [LV|{
  ^entry (%0 : !i64 ):
  "ret" (%0) : (!i64) -> ()
}]
#check RISCVReturn

def LLVMReturn :=
  [LV| {
  ^bb0(%X : i64, %Y : i64) :
   llvm.return %X : i64
  }]
#check LLVMReturn

/- ## test add -/
def llvm_add:=
  [LV| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add   %X, %Y : i64
      llvm.return %v1 : i64
  }]
#check llvm_add

def RISCV_add_pretty := [LV|{
  ^entry (%0: !i64):
    %1 =  add %0, %0 : !i64
          ret %1 : !i64
}]

def RISCV_add_unpretty := [LV| {
  ^entry (%0: !i64):
    %1 = "add" (%0, %0) : (!i64, !i64) -> (!i64)
         "ret" (%1) : (!i64) -> ()
}]

/- ## test cases with disjoint, nsw and exact flags -/
def or_disjoint_flag_test := [LV| {
  ^entry (%0: i64):
    %1 = llvm.or disjoint %0, %0 :  i64
    "llvm.return" (%1) : (i64) -> ()
}]
def add_flag_test_both := [LV| {
  ^entry (%0: i64):
    %1 = llvm.add %0, %0 overflow<nsw, nuw> : i64
    "llvm.return" (%1) : (i64) -> ()
}]

def add_flag_test := [LV| {
  ^entry (%0: i64):
    %1 = llvm.add %0, %0 overflow<nsw> : i64
    "llvm.return" (%1) : (i64) -> ()
}]
/- ## larger test cases  -/
  def llvm_const_add_neg_add:=
      [LV|{
      ^bb0(%X : i64):
      %v1 = llvm.mlir.constant 123848392 : i64
      %v2 = llvm.add %X, %v1 : i64
      %v3 = llvm.mlir.constant 0 :  i64
      %v4 = llvm.sub %v3, %X : i64
      %v = llvm.add %v2, %v1 : i64
      llvm.return %v : i64
  }]
  #check llvm_const_add_neg_add

  def riscv_const_add_neg_add_unpretty :=
  [LV| {
      ^bb0(%X : !i64):
      %v1 = "li" () { imm = 123848392 : !i64 } : (!i64, !i64) -> (!i64)
      %v2 = "add" (%X, %v1) : (!i64, !i64) -> (!i64)
      %v3 = "li" () { imm = 0 : !i64 } : (!i64, !i64) -> (!i64)
      %v4 = "sub" (%v3, %X) : (!i64, !i64) -> (!i64)
      %v = "add" (%v2, %v1) : (!i64, !i64) -> (!i64)
      "ret" (%v) : (!i64, !i64) -> ()
  }]
#check riscv_const_add_neg_add_unpretty


end examplesHybridDialect
