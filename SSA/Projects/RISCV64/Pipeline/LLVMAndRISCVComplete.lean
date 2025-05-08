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
namespace LLVMRiscVComplete
/- The types of this dialect contain the types modelled in the LLVM dialect
and in the Riscv Dialect. -/
instance : DecidableEq LLVM.Ty :=
  fun a b => by
    simp only [LLVM] at a b
    exact (inferInstanceAs (DecidableEq (InstCombine.MTy 0)) a b)

-- TODO: move into LLVM.
instance : DecidableEq LLVM.Op :=
  fun a b => by
    simp only [LLVM] at a b
    exact (inferInstanceAs (DecidableEq (InstCombine.MOp 0)) a b)


inductive Ty where
  | llvm : (Dialect.Ty LLVM) -> Ty
  | riscv : (Dialect.Ty RISCV64.RV64) -> Ty
  deriving DecidableEq, Repr

inductive Op where
  | llvm : (Dialect.Op LLVM) -> Op
  | riscv : (Dialect.Op RISCV64.RV64) -> Op
  | builtin.unrealized_conversion_cast.riscvToLLVM : Op
  | builtin.unrealized_conversion_cast.LLVMToriscv : Nat → Op -- to fix
  deriving DecidableEq, Repr
def builtin.unrealized_conversion_cast.riscvToLLVM (toCast : BitVec 64 ): Option (BitVec 64 ) := some toCast

-- change to do :: ask here 
def builtin.unrealized_conversion_cast.LLVMToriscv (toCast : Option (BitVec w)) : BitVec 64 := BitVec.setWidth 64 (toCast.getD 0#w) -- rethink choice later


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
  | .builtin.unrealized_conversion_cast.riscvToLLVM => {sig := [Ty.riscv .bv], outTy := Ty.llvm (.bitvec 64), regSig := []}
  | .builtin.unrealized_conversion_cast.LLVMToriscv w  => {sig := [Ty.llvm (.bitvec (w))], outTy := (Ty.riscv .bv), regSig := []} -- to do: overthink the 64 again
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


def extractllvmArgs : LLVMRiscVComplete.Op → LLVM.Op
  | .llvm llvmOp => llvmOp
  | _ => .const 64 0 -- fallback case if function gets called on RISCV ops.


def extractriscvArgs : LLVMRiscVComplete.Op → RISCV64.RV64.Op
  | .riscv riscvOp => riscvOp
  | _ => .li 0 -- fallback case if function gets called on LLVM ops.




@[simp_denote]
def llvmArgsFromHybrid : {tys : List LLVM.Ty} → HVector TyDenote.toType (tys.map LLVMRiscVComplete.Ty.llvm) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (llvmArgsFromHybrid xs)

 /-
 typeclass instance problem is stuck, it is often due to metavariable
  DialectSignature ?m.791
 -/
  -- HVector.map' (fun ty => (_ : LLVM.Op)) _ args

@[simp_denote]
def riscvArgsFromHybrid : {tys : List RISCV64.RV64.Ty} → HVector TyDenote.toType (tys.map LLVMRiscVComplete.Ty.riscv) → HVector TyDenote.toType tys
  | [], .nil => .nil
  | _ :: _, .cons x xs => .cons x (riscvArgsFromHybrid xs)

@[simp, reducible]
instance : DialectDenote (LLVMPlusRiscV) where
  denote
  | .llvm (llvmOp), args , .nil  => DialectDenote.denote llvmOp (llvmArgsFromHybrid args) .nil
  | .riscv (riscvOp), args , .nil  => DialectDenote.denote riscvOp (riscvArgsFromHybrid args) .nil
  | .builtin.unrealized_conversion_cast.riscvToLLVM, elemToCast, _  =>
    let toCast : (BitVec 64) := (elemToCast.getN 0 (by simp [DialectSignature.sig, signature]))
    let casted : Option (BitVec 64) := builtin.unrealized_conversion_cast.riscvToLLVM toCast
    PoisonOr.ofOption casted
  | .builtin.unrealized_conversion_cast.LLVMToriscv w, (elemToCast : HVector TyDenote.toType [Ty.llvm (.bitvec w)]), _  =>
    let toCast : PoisonOr (BitVec w) := (elemToCast.getN 0 (by simp [DialectSignature.sig, signature]))
    builtin.unrealized_conversion_cast.LLVMToriscv toCast.toOption -- to do show what I did here

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
  if (opStx.name = "builtin.unrealized_conversion_cast.riscvToLLVM" ) || (opStx.name =  "builtin.unrealized_conversion_cast.LLVMToriscv" )  then
    match opStx.args with
    | v₁Stx :: [] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, opStx.name with
      | .riscv (.bv) , "builtin.unrealized_conversion_cast.riscvToLLVM"=>
              return ⟨ .pure,  .llvm (.bitvec 64) ,⟨ .builtin.unrealized_conversion_cast.riscvToLLVM , by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
      | .llvm (.bitvec w) , "builtin.unrealized_conversion_cast.LLVMToriscv"=>
              return ⟨ .pure, .riscv (.bv) ,⟨ .builtin.unrealized_conversion_cast.LLVMToriscv w , by rfl, by constructor,
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
elab "[CV|" reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(LLVMPlusRiscV)

end LLVMRiscVComplete

def mul_llvm_noflag := [CV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def mul_llvm_noflag8 := [CV| {
    ^entry (%x: i8, %amount: i8 ):
      %1 = llvm.mul %x, %amount : i8 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i8
  }]

def mul_llvm_noflag8_riscv := [CV| {
    ^entry (%x: i8, %amount: i8 ):
      %1 = llvm.mul %x, %amount : i8 -- value depends on wether to no overflow flag is present or not
       %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%x) : (i8) -> !i64
       %x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%x) : (i8) -> !i64
       %y= "builtin.unrealized_conversion_cast.riscvToLLVM" (%x2) : (!i64) -> (i64)
      llvm.return %y : i64
  }]
#check mul_llvm_noflag

def mul_riscv := [CV| {
    ^entry (%r1: i8, %r2: i8 ):
      %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%r1) : (i8) -> !i64
      %x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%r2) : (i8) -> !i64
      %res = mul %x1, %x2 : !i64
      %y= "builtin.unrealized_conversion_cast.riscvToLLVM" (%res) : (!i64) -> (i8)
      llvm.return %y : i64
  }]
#check mul_riscv

def mul_riscv2 := [CV| {
    ^entry (%r1: i64, %r2: i64 ):
      %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%r1) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%r2) : (i64) -> !i64
      %res = mul %x1, %x2 : !i64
      %y= "builtin.unrealized_conversion_cast.riscvToLLVM" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]


def icmp_eq := [CV| {
    ^entry (%x1: i64 ):
      --%x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%r1) : (i8) -> !i64
      --%x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%r2) : (i8) -> !i64
      %0 = llvm.icmp.ne %x1,  %x1: i64  -- unsure why have to retunr i64 again -> just for the parser  '
      %1 = llvm.icmp.ne %0,  %0: i1
      %x3 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%x1) : (i64) -> !i64
      %y= "builtin.unrealized_conversion_cast.riscvToLLVM" (%x3) : (!i64) -> (i64)
      llvm.return %y : i64
  }]

#check icmp_eq
-- important both copared perands need to have the same type
def test_icmp_ule := [CV|
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.ule %X, %Y : i4
  llvm.return %r : i1
} ]

def test_icmp_uge := [CV|
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.uge %X, %Y : i4
  llvm.return %r : i1
}]


def test_icmp_sle := [CV|
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.sle %X, %Y : i4
  llvm.return %r : i1
}]

def test_icmp_sge := [CV|
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.sge %X, %Y : i4
  llvm.return %r : i1
}]
#check test_icmp_sge


def riscv_program_lowering1_lhs := [CV|
{
^bb0(%X : i4, %Y : i4, %Z : i4, %H : i64) :
  %r = llvm.add %X,%Y : i4
  %2 = llvm.add %H, %H : i64
  llvm.return %2 : i64
}]


def riscv_program_lowering1_rhs := [CV|
{
^bb0(%X : i4, %Y : i4, %Z : i4, %H : i64) :
  %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%X) : (i4) -> !i64
  %y1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%Y) : (i4) -> !i64
  %z1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%H) : (i64) -> !i64
  %res1 = add  %x1, %y1 : !i64
  %res2 = add  %z1, %z1 : !i64
  %r1= "builtin.unrealized_conversion_cast.riscvToLLVM" (%res2) : (!i64) -> (i64)
  llvm.return %r1 : i64
}]


structure LLVMPeepholeRewriteRefine2 (Γ : Ctxt  LLVMRiscVComplete.Ty) where
  lhs : Com  LLVMRiscVComplete.LLVMPlusRiscV Γ .pure ( LLVMRiscVComplete.Ty.llvm (.bitvec w))
  rhs : Com  LLVMRiscVComplete.LLVMPlusRiscV Γ .pure ( LLVMRiscVComplete.Ty.llvm (.bitvec 64))
  correct : ∀ V, BitVec.Refinement (lhs.denote V : Option _) (rhs.denote V : Option _)

-- NEED HELP IN IDENTIFYING THE W
-- NEED to change the refinement statement of BitVec to they must be equal when we appply BitVec.setWidth 64 ()
def llvm_add_lower_riscv : LLVMPeepholeRewriteRefine2 [LLVMRiscVComplete.Ty.llvm (.bitvec 4) , LLVMRiscVComplete.Ty.llvm (.bitvec 4),LLVMRiscVComplete.Ty.llvm (.bitvec 4)] :=
  {lhs := riscv_program_lowering1_lhs , rhs:= riscv_program_lowering1_rhs ,
   correct := by

    sorry
  }


def riscv_program_lowering2 := [CV|
{
^bb0(%X : i64, %Y : i64, %Z : i64) :
  %r = llvm.icmp.sge %X, %Y : i64
  %r1 = llvm.icmp.sge %Z, %Y : i64
  llvm.return %r : i1
}]
open LLVMRiscVComplete
namespace LLVMRiscVCompleteProofs
open Lean Meta Elab in

@[simp_denote]
private theorem valuation_var_last_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t : Ty} {s : Γ.Valuation} {x : TyDenote.toType t} : (s.snoc x) (Ctxt.Var.last Γ t) = x := by
  rfl

#check Ctxt.Valuation.snoc

/-
```
  Option (BitVec 64)
```
```
  toType ?t
```
-/

/-! # Instruction lowering patterns
    This file contains a collection of instruction lowerings that are performed by
    LLVM and make explicit what is performed by the LLVM backkend.
     -/
/-
f: Ctxt.Valuation.snoc, xs: [Ty,
 instTyDenoteTyLLVMPlusRiscV,
 [],
 Ty.llvm (InstCombine.Ty.bitvec 64),
 Ctxt.Valuation.nil,
 e,
 Ty.llvm (InstCombine.Ty.bitvec 64),
 Ctxt.Var.last [] (Ty.llvm (InstCombine.MTy.bitvec 64))]
-/
open Lean Meta Elab in
simproc [simp_denote] valuation_var_last_eq ((Ctxt.Valuation.snoc _ _) (Ctxt.Var.last _ _)) := fun e => do
  -- logInfo m!"Matched (Valuation.snoc s x) (Ctxt.Var.last Γ t) with {e}"
  let (_f, xs) := e.getAppFnArgs
  -- logInfo m!"f: {f}, xs: {xs}"
  let ty := xs[0]!
  let s := xs[4]!
  let x := xs[xs.size - 1 - 2]!
  -- logInfo m!"x: {x}"
  -- TODO: @alexkeizer, don't kill me for this :D I was lazy, so I just write down the full implicit match.
  -- We should probably decide which arguments are implicit, and then only pass these as explicit args.
  let proof ← mkAppOptM ``valuation_var_last_eq.lemma #[.some ty, .none, .none, .none, .some s, .some x]
  return .visit {
    expr := x,
    -- proof? := ← mkSorry (← mkEq x rhs) .true -- TODO: replace with call to valuation_var_last_eq.lemma.
    proof? := proof
  }


theorem riscVArgsFromHybrid_nil_eq : riscvArgsFromHybrid (HVector.nil) = HVector.nil := rfl

-- LLVMRiscV.llvmArgsFromHybrid {tys : List LLVM.Ty} :
--   @HVector Ty (@TyDenote.toType Ty instTyDenoteTyLLVMPlusRiscV) (@List.map LLVM.Ty Ty Ty.llvm tys) →
--     @HVector LLVM.Ty (@TyDenote.toType LLVM.Ty InstCombine.instTyDenoteTy) tys
set_option pp.explicit true in
#check llvmArgsFromHybrid
#check HVector.cons
#synth Lean.ToExpr (List Lean.Expr)

#check Lean.instToExprListOfToLevel


open Lean Meta Elab in
/-- Convert a `List Expr` into an `Expr` by building calls to `List.nil` and `List.cons`.
Note that the `ToExpr` instance of `List` is insufficient, since it perform a *deep expression cast*,
where it converts any `List α` where `[ToExpr α]` into a `List Expr`. So, when given a list of expressions, like [.const Nat],
instead of building `[Nat]`, it builds `[Lean.Expr.Const ``Nat]` (i.e.., it seralizes the `Expr` as well!).
Instead, we want a shallow serialization, where we just build `List.cons (.const Nat) List.nil`.
-/
def listExprToExprShallow (type : Option Expr) : List Expr → MetaM Expr
| .nil => mkAppOptM ``List.nil #[type]
| .cons x xs => do mkAppOptM ``List.cons #[type, x, ← listExprToExprShallow type xs]

open Lean Meta Elab in
#check Lean.Environment

def f (n : Nat) : Bool := n % 2 == 0

def g : ∀ (_ : Nat), Bool := fun n => n % 2 == 0
def h : ∀ (w : Nat), BitVec w  :=
  -- | value
  fun (w : Nat) => 0#w

def h' : (w : Nat) → BitVec w  :=
  -- | value
  fun (w : Nat) => 0#w

-- let x := xdef in rest <-> (fun x => rest) xdef

/-#
Let versus Lambda in DTT (dependent type theory)
namespace LetVersusLam
inductive Matrix : Nat → Nat → Type where
| id : (n : Nat) → Matrix n n

def f (n : Nat) : Matrix n n :=
  let m := n
  let out : Matrix m n := Matrix.id n -- n : Nat, m : Nat, m = n |- Matrix.id n is well-typed
  out

def f' (n : Nat) : Matrix n n :=
  (fun m =>
    -- n : Nat, m : Nat |- Matrix.id n is well typed
    let out : Matrix m n := Matrix.id n
    out) n
end LetVersusLam
-/

#eval show String from toString (`Nat.Abs)

@[simp_denote]
def llvmArgsFromHybrid_nil_eq :
  (llvmArgsFromHybrid HVector.nil) = HVector.nil := rfl

def llvmArgsFromHybrid_cons_eq.lemma {ty  : LLVM.Ty} {tys : List LLVM.Ty}
    (x : TyDenote.toType (LLVMRiscVComplete.Ty.llvm ty))
    (xs : HVector TyDenote.toType (tys.map LLVMRiscVComplete.Ty.llvm)) :
  (llvmArgsFromHybrid (tys := ty :: tys) (HVector.cons x xs)) =
  HVector.cons (f := TyDenote.toType) (a := ty) (as := tys) x (llvmArgsFromHybrid xs)
   := rfl


open Lean Meta Elab in
/-- Extract out the raw LLVM type from the. -/
def extractLLVMTy (x : Expr) : SimpM Expr := do
  let_expr Ty.llvm xRealTy := (← reduce x)
    | throwError m! "expected type of {x} to be `Ty.llvm _`, but got {x}"
  return xRealTy

open Lean Meta Elab in
simproc [simp_denote] llvmArgsFromHybrid_cons_eq (llvmArgsFromHybrid _) := fun e => do
  let_expr llvmArgsFromHybrid _ lhs := e
    | throwError m!"unable to find llvmArgsFromHybrid in {e}"
  let_expr HVector.cons _α _f as a x xs := lhs
    | throwError m!"unable to find HVector.cons in {lhs}"
  let xRealTy ← extractLLVMTy a
  let some (_, xsRealTys) := Expr.listLit? (← reduce as)
    | return .continue
  let xsRealTys ←  xsRealTys.mapM extractLLVMTy

  logInfo m!"found (llvmArgsFromHybrid (HVector.cons ({x} : {xRealTy}) ({xs} : {xsRealTys})"
  let llvmTypeType := mkApp (mkConst ``Dialect.Ty []) (mkConst ``InstCombine.LLVM [])
  let xsRealTys ← listExprToExprShallow (.some llvmTypeType) xsRealTys

  logInfo m!"calling {``llvmArgsFromHybrid_cons_eq.lemma} with {xRealTy}, {xsRealTys}, {x}, {xs}"
  logInfo m!"XXXX"
  let proof := mkAppN (mkConst ``llvmArgsFromHybrid_cons_eq.lemma []) #[xRealTy, xsRealTys, x, xs]
  logInfo m!"YYYY"
  logInfo m!"built proof {proof}"
  let proof ← reduce proof
  logInfo m!"reduced proof to {proof}"
  let eq ← reduce (← inferType proof)
  logInfo m!"reduced type of proof (i.e. the equality) to {eq}"
  let .some (_ty, _lhs, rhs) := eq.eq?
    | throwError "unable to reduce application of 'llvmArgsFromHybrid_cons_eq.lemma' to an equality, only reduced to '{eq}'."
  logInfo m!"final right-hand-side of equality is: {rhs}"
  return .visit {
    expr := rhs,
    proof? := .some proof
  }

@[simp_denote]
def riscvArgsFromHybrid_nil_eq :
  (riscvArgsFromHybrid HVector.nil) = HVector.nil := rfl

def riscvArgsFromHybrid_cons_eq.lemma {ty  : RISCV64.RV64.Ty} {tys : List RISCV64.RV64.Ty}
    (x : TyDenote.toType (LLVMRiscVComplete.Ty.riscv ty))
    (xs : HVector TyDenote.toType (tys.map LLVMRiscVComplete.Ty.riscv)) :
  (riscvArgsFromHybrid (tys := ty :: tys) (HVector.cons x xs)) =
  HVector.cons (f := TyDenote.toType) (a := ty) (as := tys) x (riscvArgsFromHybrid xs)
   := rfl

open Lean Meta Elab in
/-- Extract out the raw LLVM type from the. -/
def extractRiscvTy (x : Expr) : SimpM Expr := do
  let_expr Ty.riscv xRealTy := (← reduce x)
    | throwError m! "expected type of {x} to be `Ty.riscv _`, but got {x}"
  return xRealTy


open Lean Meta Elab in
simproc [simp_denote] riscvArgsFromHybrid_cons_eq (riscvArgsFromHybrid _) := fun e => do
  let_expr riscvArgsFromHybrid _ lhs := e
    | throwError m!"unable to find riscvArgsFromHybrid in {e}"
  let_expr HVector.cons _α _f as a x xs := lhs
    | throwError m!"unable to find HVector.cons in {lhs}"
  let xRealTy ← extractRiscvTy a
  let some (_, xsRealTys) := Expr.listLit? (← reduce as)
    | return .continue
  let xsRealTys ←  xsRealTys.mapM extractRiscvTy

  logInfo m!"found (llvmArgsFromHybrid (HVector.cons ({x} : {xRealTy}) ({xs} : {xsRealTys})"
  let llvmTypeType := mkApp (mkConst ``Dialect.Ty []) (mkConst ``RISCV64.RV64 [])
  let xsRealTys ← listExprToExprShallow (.some llvmTypeType) xsRealTys

  logInfo m!"calling {``riscvArgsFromHybrid_cons_eq.lemma} with {xRealTy}, {xsRealTys}, {x}, {xs}"
  logInfo m!"XXXX"
  let proof := mkAppN (mkConst ``riscvArgsFromHybrid_cons_eq.lemma []) #[xRealTy, xsRealTys, x, xs]
  logInfo m!"YYYY"
  logInfo m!"built proof {proof}"
  let proof ← reduce proof
  logInfo m!"reduced proof to {proof}"
  let eq ← reduce (← inferType proof)
  logInfo m!"reduced type of proof (i.e. the equality) to {eq}"
  let .some (_ty, _lhs, rhs) := eq.eq?
    | throwError "unable to reduce application of riscvArgsFromHybrid_cons_eq.lemma to an equality, only reduced to '{eq}'."
  logInfo m!"final right-hand-side of equality is: {rhs}"
  return .visit {
    expr := rhs,
    proof? := .some proof
  }

@[simp_denote]
theorem valuation_var_snoc_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t t' : Ty} {s : Γ.Valuation} {x : TyDenote.toType t} {v : Γ.Var t'} :
  (s.snoc x) (Ctxt.Var.toSnoc v) = s v := rfl


/- # ADD, riscv   -/
def add_riscv := [CV| { -- this isnt correct bc add could overflow and then riscv is anyways more precise
    ^entry (%lhs: i4, %rhs: i4 ):
      %lhsr = "builtin.unrealized_conversion_cast.LLVMToriscv"(%lhs) : (i4) -> !i64
      %rhsr = "builtin.unrealized_conversion_cast.LLVMToriscv"(%rhs) : (i4) -> !i64
      %add1 = add %lhsr, %rhsr : !i64
      %addl = "builtin.unrealized_conversion_cast.riscvToLLVM" (%add1) : (!i64) -> (i64)
      llvm.return %addl : i64
  }]
def add_riscvi8 := [CV| {
    ^entry (%lhs: i8, %rhs: i8 ):
      %lhsr = "builtin.unrealized_conversion_cast.LLVMToriscv"(%lhs) : (i8) -> !i64
      %rhsr = "builtin.unrealized_conversion_cast.LLVMToriscv"(%rhs) : (i8) -> !i64
      %add1 = add %lhsr, %rhsr : !i64
      %addl = "builtin.unrealized_conversion_cast.riscvToLLVM" (%add1) : (!i64) -> (i64)
      llvm.return %addl : i64
  }]

def llvm_xor := [CV| {
    ^entry (%x: i32, %y: i32 ):
      %1 = llvm.xor  %x, %y : i32 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i32
  }]

def xor_riscv := [CV| {
    ^entry (%x: i32, %y: i32 ):
      %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%x) : (i32) -> !i64
      %x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%y) : (i32) -> !i64
      %1 =  xor %x1, %x2 : !i64 -- value depends on wether to no overflow flag is present or not
      %2 = "builtin.unrealized_conversion_cast.riscvToLLVM" (%1) : (!i64) -> (i64)
      llvm.return %2 : i64
  }]

  def llvm_xor_lower_riscv: LLVMPeepholeRewriteRefine2 [Ty.llvm (.bitvec 32) , Ty.llvm (.bitvec 32)] :=
  {lhs := llvm_xor , rhs := xor_riscv, correct := by
    unfold llvm_xor xor_riscv
    simp_peephole
    rintro (_|a) (_|b) <;> simp only [LLVM.xor, LLVM.xor?, Option.bind_eq_bind, Option.some_bind]
    . simp
    . simp
    . simp
    . simp [BitVec.Refinement , RTYPE_pure64_RISCV_XOR , builtin.unrealized_conversion_cast.riscvToLLVM, builtin.unrealized_conversion_cast.LLVMToriscv]
      bv_decide
  }

-- attempt to write in pure bitvecotr only
theorem toBitVeconly (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
BitVec.extractLsb 63 0 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toNat * rs2_val.toNat)))
  = BitVec.setWidth 64 (BitVec.mul rs1_val rs2_val)  := by sorry -- to do
