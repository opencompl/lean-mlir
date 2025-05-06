import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.Util.ConcreteOrMVar
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.all
set_option pp.fieldNotation false

open InstCombine(LLVM)
namespace LLVMRiscV
/- The types of this dialect contain the types modelled in the LLVM dialect
and in the Riscv Dialect. -/

inductive Ty where
  | llvm : (Dialect.Ty LLVM) -> Ty
  | riscv : (Dialect.Ty RISCV64.RV64) -> Ty
  deriving DecidableEq, Repr


inductive Op where
  | llvm : (Dialect.Op LLVM) -> Op
  | riscv : (Dialect.Op RISCV64.RV64) -> Op
  | builtin.unrealized_conversion_cast.riscvToLLVM : Op
  | builtin.unrealized_conversion_cast.LLVMToriscv : Op
  deriving DecidableEq, Repr
def builtin.unrealized_conversion_cast.riscvToLLVM (toCast : BitVec 64 ): Option (BitVec 64 ) := some toCast
/--
Casting a some x to x. The none (poison case) will be harded coded to zero bit vector as any
values refines a poison value.
-/
def builtin.unrealized_conversion_cast.LLVMToriscv (toCast : Option (BitVec 64)) : BitVec 64 := toCast.getD 0#64 -- rethink choice later


@[simp]
abbrev LLVMPlusRiscV : Dialect where
  Op := Op
  Ty := Ty

namespace LLVMPlusRiscV.Op

-- def llvm (llvmOp : LLVM.Op) : LLVMPlusRiscV.Op :=
--   --((@id (Dialect.Op LLVMPlusRiscV) <|
--     LLVMRiscV.Op.llvm llvmOp
--     --))


end LLVMPlusRiscV.Op

instance : TyDenote (Dialect.Ty LLVMPlusRiscV) where
  toType := fun
    | .llvm llvmTy => TyDenote.toType llvmTy
    | .riscv riscvTy => TyDenote.toType riscvTy

/-
instance (ty : Ty) : Inhabited (TyDenote.toType ty) where
  default := match ty with
    | .llvm llvmTy => default
    | .riscv riscvTy => default
-/

@[simp]
instance LLVMPlusRiscVSignature : DialectSignature LLVMPlusRiscV where
  signature
  | .llvm llvmOp => .llvm <$> DialectSignature.signature llvmOp
  | .riscv riscvOp => .riscv <$> DialectSignature.signature riscvOp
  | .builtin.unrealized_conversion_cast.riscvToLLVM => {sig := [Ty.riscv .bv], outTy := Ty.llvm (.bitvec 64), regSig := []}
  | .builtin.unrealized_conversion_cast.LLVMToriscv => {sig := [Ty.llvm (.bitvec 64)], outTy := (Ty.riscv .bv), regSig := []} -- to do: overthink the 64 again
/-
@[simp, reducible]
def Op.sig : Op → List Ty
  | .llvm llvmop  => List.map Ty.llvm llvmop.sig

@[simp, reducible]
def Op.outTy : Op → Ty
  | .llvm op => Ty.llvm (op.outTy) -- dont understand why op is of type instCombine and not LLVM



@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature LLVMPlusRiscV := ⟨Op.signature⟩
-/

instance : ToString (Dialect.Ty LLVMPlusRiscV)  where
  toString t := repr t |>.pretty


def extractllvmArgs : LLVMRiscV.Op → LLVM.Op
  | .llvm llvmOp => llvmOp
  | _ => .const 64 0 -- fallback case if function gets called on RISCV ops.


def extractriscvArgs : LLVMRiscV.Op → RISCV64.RV64.Op
  | .riscv riscvOp => riscvOp
  | _ => .li 0 -- fallback case if function gets called on LLVM ops.



#check LLVMRiscV.Op.llvm _
#check LLVMPlusRiscV.Op
-- #check (LLVMPlusRiscV.Op).llvm
-- #check (LLVMPlusRiscV.Op.llvm _  )

#check ((@id (Dialect.Op LLVMPlusRiscV) <| LLVMRiscV.Op.llvm _))
#check (Dialect.Op LLVMPlusRiscV)

example (d : Dialect) : d.Ty := by
  sorry


-- HVector toType (argumentTypes (.llvm llvmOp))
-- HVector toType ((argumentTypes llvmOp).map .llvm : List Hybrid.Ty)

-- args : HVector toType (argumentTypes llvmOp : List LLVM.Ty)
-- args[i] : toType (argumentTypes ...)[i]

-- #check LLVMPlusRiscV.Op.llvm
@[simp_denote]
def llvmArgsFromHybrid : {tys : List LLVM.Ty} → HVector TyDenote.toType (tys.map LLVMRiscV.Ty.llvm) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (llvmArgsFromHybrid xs)

 /-
 typeclass instance problem is stuck, it is often due to metavariable
  DialectSignature ?m.791
 -/
  -- HVector.map' (fun ty => (_ : LLVM.Op)) _ args

@[simp_denote]
def riscvArgsFromHybrid : {tys : List RISCV64.RV64.Ty} → HVector TyDenote.toType (tys.map LLVMRiscV.Ty.riscv) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (riscvArgsFromHybrid xs)

@[simp, reducible]
instance : DialectDenote (LLVMPlusRiscV) where
  denote
  | .llvm (llvmOp), args , .nil  => DialectDenote.denote llvmOp (llvmArgsFromHybrid args) .nil
  | .riscv (riscvOp), args , .nil  => DialectDenote.denote riscvOp (riscvArgsFromHybrid args) .nil
  | .builtin.unrealized_conversion_cast.riscvToLLVM, elemToCast, _  => builtin.unrealized_conversion_cast.riscvToLLVM (elemToCast.getN 0 (by simp [DialectSignature.sig, signature]))
  | .builtin.unrealized_conversion_cast.LLVMToriscv, elemToCast, _  => builtin.unrealized_conversion_cast.LLVMToriscv (elemToCast.getN 0 (by simp [DialectSignature.sig, signature]))

@[simp_denote]
def ctxtTransformToLLVM  (Γ : Ctxt LLVMPlusRiscV.Ty) :=
  Ctxt.map  (fun ty  =>
    match ty with
    | .llvm someLLVMTy => someLLVMTy
    | .riscv _  => .bitvec 999
  ) Γ

#check Ctxt

#check Ctxt.Hom


-- def Ctxt.filterMap.aux (Γ : Ctxt Ty) (f : Ty → Option Ty') (iΓ : Nat) : Σ (Δ : Ctxt Ty'), Fin   :=
--   match Γ with
--   | [] => []
--   | t :: ts =>
--     match f t with
--     | .none => Ctxt.filterMap.aux ts f
--     | .some t' => t' :: Ctxt.filterMap.aux ts f

-- def ctxtTransformToLLVM? (Γ : Ctxt LLVMPlusRiscV.Ty) : Ctxt LLVM.Ty :=
--   Ctxt.filterMap.aux Γ (fun ty =>
--     match ty with
--     | .llvm ty => some ty
--     | _ => none
--   )
@[simp_denote]
def ctxtTransformToRiscV (Γ : Ctxt LLVMPlusRiscV.Ty) :=
  Ctxt.map  (fun ty  =>
    match ty with
    | .riscv someRiscVTy  => someRiscVTy
    | _  => .bv -- unsure what to return here because want to signal in case transformation is not valid
  ) Γ

/-- Projection of `outTy` commutes with `Signature.map`. -/
@[simp, simp_denote]
theorem outTy_map_signature_eq {s : Signature α} {f : α → β} :
  Signature.outTy (f <$> s) = f s.outTy := rfl

-- @bollu says @salinhkuhn should work directly on lean-mlir, rather than using as a submodule,
-- because the development is complex enough to constantly add new features into lena-mlir
def _root_.HVector.foldlM {B : Type*} [Monad m] (f : ∀ (a : α), B → A a → m B) :
    ∀ {l : List α}, (init : B) → (as : HVector A l) → m B
  | [],   b, .nil       => return b
  | t::_, b, .cons a as => do foldlM f (← f t b a) as

/-- Simultaneous map on the type and value level of an HVector. -/
@[simp_denote]
def _root_.HVector.ubermap {A : α → Type} {B : β → Type}
    {l : List α}
    (F : α → β)
    (f : {a : α} → (v : A a) → B (F a) )
    (as : HVector A l) : (HVector B (F <$> l)) :=
  match l, as with
  | [], .nil => .nil
  | _t :: _ts, .cons a as => HVector.cons (f a) (HVector.ubermap F f as)

/--
Simultaneous map on the type and value level of an HVector while performing monadic effects for value translation.
-/
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
        -- args1 : HVector (Ctxt.Var (ctxtTransformToLLVM Γ)) (DialectSignature.sig op1)
        let args' : HVector (Ctxt.Var Γ) (.llvm <$> DialectSignature.sig op1) ←
          args1.ubermapM fun t v => do
            match h : Γ.get? v.val with
            | some ty' => do
              match hty : ty' with
              | .riscv _ =>
                throw <| .generic s!"INTERNAL ERROR: This case is impossible, LLVM expression is pointing to RISCV variable."
              | .llvm originalLLVMTy =>
                if hty' : originalLLVMTy = t then
                  return ⟨v.val, by rw [h, hty']⟩
                else
                  throw <|.generic s!"INTERNAL ERROR: This case is impossible, LLVM expression is pointing to an incorrect bitwidth LLVM argument."
                  -- return ⟨v.val, by rw [h]⟩
            | none =>
              -- this is impossible, because ctxtTransformToLLVM is a `List.map`, which always maintains length.
              -- sorry
              throw <| .generic s!"INTERNAL ERROR: This case is impossible, as 'ctxtTransformToLLVM' is length-preserving."
        return Expr.mk
          (op := Op.llvm op1)
          (eff_le := eff_le1)
          (ty_eq := ty_eq1 ▸ rfl) -- @bollu: Discussion with Alex needed about cute-ism.
          (args := args')-- .cons e₁ <| .cons e₂ .nil)
          (regArgs := HVector.nil)
        -- LLVMPlusRiscV Γ eff (.llvm ty)

def transformExprRISCV (e : Expr (RISCV64.RV64) ( ctxtTransformToRiscV Γ) eff ty) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Expr LLVMPlusRiscV Γ eff (.riscv ty)) :=
    match e with
    | Expr.mk op1 ty_eq1 eff_le1 args1 regArgs1 => do
        -- args1 : HVector (Ctxt.Var (ctxtTransformToLLVM Γ)) (DialectSignature.sig op1)
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
                  -- return ⟨v.val, by rw [h]⟩
            | none =>
              -- this is impossible, because ctxtTransformToLLVM is a `List.map`, which always maintains length.
              -- sorry
              throw <| .generic s!"INTERNAL ERROR: This case is impossible, as 'ctxtTransformToLLVM' is length-preserving."
        return Expr.mk
          (op := Op.riscv op1)
          (eff_le := eff_le1)
          (ty_eq := ty_eq1 ▸ rfl)
          (args := args')-- .cons e₁ <| .cons e₂ .nil)
          (regArgs := HVector.nil)
        -- LLVMPlusRiscV Γ eff (.llvm ty)

-- def transformExprLLVMCasesArgs  (e : Expr (InstCombine.MetaLLVM 0) (ctxtTransformToLLVM Γ) eff ty) :=
--   match e with
--   | Expr.mk op1 ty_eq1 eff_le1 args regArgs1 =>
--       Expr.mk
--       (op := LLVMPlusRiscV.Op.llvm op1 )
--       (eff_le := eff_le1 )
--       (ty_eq := by rfl)
--       (args := _ )-- .cons e₁ <| .cons e₂ .nil)
--       (regArgs := HVector.nil)
--       -- LLVMPlusRiscV Γ eff (.llvm ty)
/-

def rem {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.rem)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

-/


#check Expr.mk
#check Ctxt.Var

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

-- TO DO: discuss with Sid and Alex
def mkExpr1 (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
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
-- to do: ask alex or sid if they agree on catching all errors or only unsupported op
  else
    let llvmParse := InstcombineTransformDialect.mkExpr (ctxtTransformToLLVM  Γ) opStx (← read) -- reading state out of the monad.
    match llvmParse with
      | .ok ⟨eff, ty, expr⟩ => do -- returns llvm expression
        let v ← transformExprLLVM expr
        return ⟨eff, .llvm ty, v⟩
      | .error  (_) => do --- unsure here if that makes sense to try to parse as riscv given all errors -> ask Alex and Sid
        let ⟨eff, (ty) , expr⟩ ← RiscvMkExpr.mkExpr (ctxtTransformToRiscV Γ) opStx (← read)
        let v ← transformExprRISCV expr
        return ⟨eff, .riscv ty , v⟩
    /- | .error  (MLIR.AST.TransformError.unsupportedOp _) => do
        let ⟨eff, (ty) , expr⟩ ← RiscvMkExpr.mkExpr (ctxtTransformToRiscV Γ) opStx (← read)
        let v ← transformExprRISCV expr
        return ⟨eff, .riscv ty , v⟩-/
      -- | _ => throw <| .generic s!"Ill-formed program, coulnd't parse it as llvm nor riscv."



def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
  MLIR.AST.ReaderM (LLVMPlusRiscV) (Σ eff ty, Expr (LLVMPlusRiscV) Γ eff ty) := do
  let llvmParse := InstcombineTransformDialect.mkExpr (ctxtTransformToLLVM  Γ) opStx (← read) -- reading state out of the monad.
  match llvmParse with
    | .ok ⟨eff, ty, expr⟩ => do -- returns llvm expression
      let v ← transformExprLLVM expr
      return ⟨eff, .llvm ty, v⟩
    | .error (.unsupportedOp _) => do
      let ⟨eff, (ty) , expr⟩ ← RiscvMkExpr.mkExpr (ctxtTransformToRiscV Γ) opStx (← read)
      let v ← transformExprRISCV expr
      return ⟨eff, .riscv ty , v⟩
    | _ => throw <| .generic s!"Ill-formed program, coulnd't parse it as llvm nor riscv."


instance : MLIR.AST.TransformExpr (LLVMPlusRiscV ) 0   where
  mkExpr := mkExpr1


/-
def Var (Γ : Ctxt Ty) (t : Ty) : Type :=
  { i : Nat // Γ.get? i = some t }
-/

-- TO DO: finish this proof, not to hard but will take some time + talk with Sid and Alex if this makes sense
@[simp_denote]
def transformVarLLVM (v :  Ctxt.Var (ctxtTransformToLLVM Γ) ty) :   Ctxt.Var Γ (LLVMRiscV.Ty.llvm ty) :=
  match v with
  | ⟨h, ty⟩ =>  ⟨h, by sorry ⟩

@[simp_denote]
def transformVarRISCV (v :  Ctxt.Var (ctxtTransformToRiscV Γ) ty) :   Ctxt.Var Γ (LLVMRiscV.Ty.riscv ty) :=
  match v with
  | ⟨h, ty⟩ =>  ⟨h, sorry ⟩


def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (LLVMPlusRiscV)
    (Σ eff ty, Com LLVMPlusRiscV Γ eff ty) := do
    let llvmParseReturn := InstcombineTransformDialect.mkReturn (ctxtTransformToLLVM  Γ) opStx (← read)
    match llvmParseReturn with
    | .ok ⟨eff, ty, Com.ret v⟩ =>
      return ⟨eff, .llvm ty, Com.ret (transformVarLLVM v) ⟩
    | _ =>
      let ⟨eff, ty , com⟩ ← RiscvMkExpr.mkReturn  (ctxtTransformToRiscV Γ) opStx (← read)
      match com with
      |Com.ret v =>
        return ⟨eff, .riscv ty, Com.ret (transformVarRISCV v) ⟩ -- need to transform variable from riscv
      |_ => throw <| .generic s!"unable to parse return as either LLVM type or RISCV type."


instance : MLIR.AST.TransformReturn (LLVMPlusRiscV) 0 where
  mkReturn := mkReturn
   -- | _ => throw <| .generic s!"Ill-formed return, coulnd't parse it as llvm nor riscv."




open Qq MLIR AST Lean Elab Term Meta in
elab "[LV|" reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(LLVMPlusRiscV)

end LLVMRiscV
