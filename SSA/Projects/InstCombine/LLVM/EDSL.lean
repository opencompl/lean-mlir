/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import SSA.Projects.InstCombine.Base
import Batteries.Data.BitVec
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.CLITests

open Qq Lean Meta Elab.Term Elab Command
open InstCombine (LLVM MetaLLVM MOp Width)

open MLIR

namespace InstcombineTransformDialect

def mkUnaryOp {Γ : Ctxt (MetaLLVM φ).Ty} {w : Width φ} (op : MOp.UnaryOp)
  (e : Ctxt.Var Γ (.bitvec w)) : Expr (MetaLLVM φ) Γ .pure (.bitvec w) :=
  ⟨
    .unary w op,
    rfl,
    by constructor,
    .cons e .nil,
    .nil
  ⟩


def mkBinOp {Γ : Ctxt (MetaLLVM φ).Ty} {w : Width φ} (op : MOp.BinaryOp)
    (e₁ e₂ : Ctxt.Var Γ (.bitvec w)) : Expr (MetaLLVM φ) Γ .pure (.bitvec w) :=
  ⟨
    .binary w op,
    rfl,
    by constructor,
    .cons e₁ <| .cons e₂ .nil ,
    .nil
  ⟩

def mkIcmp {Γ : Ctxt _} {w : Width φ} (p : LLVM.IntPredicate)
    (e₁ e₂ : Ctxt.Var Γ (.bitvec w)) : Expr (MetaLLVM φ) Γ .pure (.bitvec 1) :=
  ⟨
    .icmp p w,
    rfl,
    by constructor,
    .cons e₁ <| .cons e₂ .nil,
    .nil
  ⟩


def mkSelect {Γ : Ctxt (MetaLLVM φ).Ty} {ty : (MetaLLVM φ).Ty} (op : MOp φ)
    (c : Ctxt.Var Γ (.bitvec 1)) (e₁ e₂ : Ctxt.Var Γ ty) :
    MLIR.AST.ExceptM (MetaLLVM φ) <| Expr (MetaLLVM φ) Γ .pure ty :=
  match ty with
  | .bitvec w =>
    match op with
        | .select w' => if  h : w = w'
        then return ⟨
          .select w',
          by simp [DialectSignature.outTy, signature, h],
          by constructor,
          .cons c <|.cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
          .nil
        ⟩
        else throw <| .widthError w w'
        | _ => throw <| .unsupportedOp "Unsupported select operation"

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (MetaLLVM φ) ((MetaLLVM φ).Ty)
  | MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless w => do
    return .bitvec w
  | _ => throw .unsupportedType -- "Unsupported type"

instance instTransformTy : MLIR.AST.TransformTy (MetaLLVM φ) φ where
  mkTy := mkTy

def mkExpr (Γ : Ctxt (MetaLLVM φ).Ty) (opStx : MLIR.AST.Op φ) :
    AST.ReaderM (MetaLLVM φ) (Σ eff ty, Expr (MetaLLVM φ) Γ eff ty) := do
  match opStx.args with
  | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨.bitvec w₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨.bitvec w₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨.bitvec w₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match opStx.name with
      | "llvm.select" =>
        if hw1 : w₁ = 1 then
          if hw23 : w₂  = w₃ then
            let selectOp ← mkSelect (MOp.select w₂) (hw1 ▸ v₁) v₂ (hw23 ▸ v₃)
            return ⟨.pure, .bitvec w₂, selectOp⟩
          else
            throw <| .widthError w₁ w₂ -- s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
        else throw <| .unsupportedOp s!"expected select condtion to have width 1, found width '{w₁}'"
      | op => throw <| .unsupportedOp s!"Unsuported ternary operation or invalid arguments '{op}'"
  | v₁Stx::v₂Stx::[] =>
    let ⟨.bitvec w,  v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
    let ⟨.bitvec w', v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx

    if hty : w ≠ w' then
      throw <| .widthError w w' -- the arguments don't have the same width!
    else
      let v₂ : Γ.Var (.bitvec w) := (by simpa using hty) ▸ v₂

      let (op : MOp.BinaryOp ⊕ LLVM.IntPredicate) ← match opStx.name with
        | "llvm.and"    => pure <| Sum.inl .and
        | "llvm.or"     => pure <| Sum.inl .or
        | "llvm.xor"    => pure <| Sum.inl .xor
        | "llvm.shl"    => pure <| Sum.inl .shl
        | "llvm.lshr"   => pure <| Sum.inl .lshr
        | "llvm.ashr"   => pure <| Sum.inl .ashr
        | "llvm.urem"   => pure <| Sum.inl .urem
        | "llvm.srem"   => pure <| Sum.inl .srem
        | "llvm.add"    => pure <| Sum.inl .add
        | "llvm.mul"    => pure <| Sum.inl .mul
        | "llvm.sub"    => pure <| Sum.inl .sub
        | "llvm.sdiv"   => pure <| Sum.inl .sdiv
        | "llvm.udiv"   => pure <| Sum.inl .udiv
        | "llvm.icmp.eq"  => pure <| Sum.inr LLVM.IntPredicate.eq
        | "llvm.icmp.ne"  => pure <| Sum.inr LLVM.IntPredicate.ne
        | "llvm.icmp.ugt" => pure <| Sum.inr LLVM.IntPredicate.ugt
        | "llvm.icmp.uge" => pure <| Sum.inr LLVM.IntPredicate.uge
        | "llvm.icmp.ult" => pure <| Sum.inr LLVM.IntPredicate.ult
        | "llvm.icmp.ule" => pure <| Sum.inr LLVM.IntPredicate.ule
        | "llvm.icmp.sgt" => pure <| Sum.inr LLVM.IntPredicate.sgt
        | "llvm.icmp.sge" => pure <| Sum.inr LLVM.IntPredicate.sge
        | "llvm.icmp.slt" => pure <| Sum.inr LLVM.IntPredicate.slt
        | "llvm.icmp.sle" => pure <| Sum.inr LLVM.IntPredicate.sle
        | opstr => throw <| .unsupportedOp s!"Unsuported binary operation or invalid arguments '{opstr}'"
      return match op with
        | .inl binOp  => ⟨_, _, mkBinOp binOp v₁ v₂⟩
        | .inr pred   => ⟨_, _, mkIcmp pred v₁ v₂⟩
  | vStx::[] =>
    let ⟨.bitvec w, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    let op ← match opStx.name with
        | "llvm.not"  => pure .not
        | "llvm.neg"  => pure .neg
        | "llvm.copy" => pure .copy
        | _ => throw <| .generic s!"Unknown (unary) operation syntax {opStx.name}"
    return ⟨_, _, mkUnaryOp op v⟩
  | [] =>
    if opStx.name ==  "llvm.mlir.constant"
    then do
    let some att := opStx.attrs.getAttr "value"
      | throw <| .generic "tried to resolve constant without 'value' attribute"
    match att with
      | .int val ty =>
          let opTy@(.bitvec w) ← mkTy ty -- ty.mkTy
          return ⟨.pure, opTy, ⟨
            MOp.const w val,
            by simp [DialectSignature.outTy, signature, *],
            by constructor,
            HVector.nil,
            HVector.nil
          ⟩⟩
      | _ => throw <| .generic "invalid constant attribute"
    else
      throw <| .generic s!"invalid (0-ary) expression {opStx.name}"
  | _ => throw <| .generic s!"unsupported expression (with unsupported arity) {opStx.name}"

instance : AST.TransformExpr (MetaLLVM φ) φ where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (MetaLLVM φ).Ty) (opStx : MLIR.AST.Op φ) :
    MLIR.AST.ReaderM (MetaLLVM φ) (Σ eff ty, Com (MetaLLVM φ) Γ eff ty) :=
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, _root_.Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : AST.TransformReturn (MetaLLVM φ) φ where
  mkReturn := mkReturn


/-!
  ## Instantiation
  Finally, we show how to instantiate a family of programs to a concrete program
-/

def instantiateMTy (vals : Vector Nat φ) : (MetaLLVM φ).Ty → LLVM.Ty
  | .bitvec w => .bitvec <| w.instantiate vals

def instantiateMOp (vals : Vector Nat φ) : (MetaLLVM φ).Op → LLVM.Op
  | .binary w binOp => .binary (w.instantiate vals) binOp
  | .unary w unOp => .unary (w.instantiate vals) unOp
  | .select w => .select (w.instantiate vals)
  | .icmp c w => .icmp c (w.instantiate vals)
  | .const w val => .const (w.instantiate vals) val

def instantiateCtxt (vals : Vector Nat φ) (Γ : Ctxt (MetaLLVM φ).Ty) : Ctxt InstCombine.Ty :=
  Γ.map (instantiateMTy vals)

open InstCombine in
def MOp.instantiateCom (vals : Vector Nat φ) : DialectMorphism (MetaLLVM φ) LLVM where
  mapOp := instantiateMOp vals
  mapTy := instantiateMTy vals
  preserves_signature op := by
    have h1 : ∀ (φ : Nat), 1 = ConcreteOrMVar.concrete (φ := φ) 1 := by intros φ; rfl
    cases op <;>
      simp only [instantiateMTy, instantiateMOp, ConcreteOrMVar.instantiate, (· <$> ·), signature,
      InstCombine.MOp.sig, InstCombine.MOp.outTy, Function.comp_apply, List.map,
      Signature.mk, Signature.mkEffectful.injEq,
      List.map_cons, List.map_nil, and_self, MTy.bitvec,
      List.cons.injEq, MTy.bitvec.injEq, and_true, true_and,
      RegionSignature.map, Signature.map, h1]

open InstCombine in
def mkComInstantiate (reg : MLIR.AST.Region φ) :
    MLIR.AST.ExceptM (MetaLLVM φ) (Vector Nat φ → Σ Γ eff ty, Com LLVM Γ eff ty) := do
  let ⟨Γ, eff, ty, com⟩ ← MLIR.AST.mkCom reg
  return fun vals =>
    let Γ' := instantiateCtxt vals Γ
    let ty' := instantiateMTy vals ty
    let com' := com.changeDialect (MOp.instantiateCom vals)
    ⟨Γ', eff, ty', com'⟩

end InstcombineTransformDialect

/-
https://leanprover.zulipchat.com/#narrow/stream/287929-mathlib4/topic/Cannot.20Find.20.60Real.2Eadd.60/near/402089561
> I would recommend avoiding Qq for pattern matching.
> That part of the Qq implementation is spicy.

Therefore, we choose to match on raw `Expr`.
-/
open SSA InstcombineTransformDialect InstCombine in
elab "[alive_icom (" mvars:term,* ")| " reg:mlir_region "]" : term => do
  have φ : Nat := mvars.getElems.size
  -- HACK: QQ needs `φ` to be `have`-bound, rather than `let`-bound, otherwise `elabIntoCom` fails
  let mcom ← withTraceNode `alive_icom (return m!"{exceptEmoji ·} elabIntoCom") <|
    SSA.elabIntoCom reg q(MetaLLVM $φ)

  let mvalues : Q(Vector Nat $φ) ←
    withTraceNode `alive_icom (return m!"{exceptEmoji ·} elaborating mvalues") <| do
      let mvalues ← `(⟨[$mvars,*], by rfl⟩)
      elabTermEnsuringType mvalues q(Vector Nat $φ)

  let com ← withTraceNode `alive_icom (return m!"{exceptEmoji ·} building final Expr") <| do
    let instantiateFun ← mkAppM ``MOp.instantiateCom #[mvalues]
    let com ← mkAppM ``Com.changeDialect #[instantiateFun, mcom]
    synthesizeSyntheticMVarsNoPostponing
    return com

  return com

macro "[alive_icom| " reg:mlir_region "]" : term => `([alive_icom ()| $reg])

macro "deftest" name:ident " := " test_reg:mlir_region : command => do
  `(@[reducible, llvmTest $name] def $(name) : ConcreteCliTest :=
       let code := [alive_icom ()| $test_reg]
       { name := $(quote name.getId), ty := code.ty, context := code.ctxt, code := code, })
