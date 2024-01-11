import Qq
import SSA.Projects.InstCombine.Base
import Std.Data.BitVec
import SSA.Projects.MLIRSyntax.AST
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
-- import SSA.Projects.InstCombine.LLVM.Transform.Dialects.InstCombine

open Qq Lean Meta Elab.Term Elab Command
open InstCombine (MOp MTy Width)

open MLIR

namespace InstcombineTransformDialect

def mkUnaryOp {Γ : Ctxt (MTy φ)} {ty : (MTy φ)} (op : MOp φ)
  (e : Ctxt.Var Γ ty) : MLIR.AST.ExceptM (MOp φ) <| Expr (MOp φ) Γ ty :=
  match ty with
  | .bitvec w =>
    match op with
    | .unary w' op => if h : w = w'
      then return ⟨
        .unary w' op,
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e) .nil,
        .nil
      ⟩
      else throw <| .widthError w w'
      | _ => throw .unsupportedUnaryOp

def mkBinOp {Γ : Ctxt (MTy φ)} {ty : (MTy φ)} (op : MOp φ)
    (e₁ e₂ : Ctxt.Var Γ ty) : MLIR.AST.ExceptM (MOp φ) <| Expr (MOp φ) Γ ty :=
  match ty with
  | .bitvec w =>
    match op with
    | .binary w' op => if h : w = w'
      then return ⟨
        .binary w' op,
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | op => throw <| .unsupportedBinaryOp s!"unsupported binary operation {op}"

def mkIcmp {Γ : Ctxt _} {ty : (MTy φ)} (op : MOp φ)
    (e₁ e₂ : Ctxt.Var Γ ty) : MLIR.AST.ExceptM (MOp φ) <| Expr (MOp φ) Γ (.bitvec 1) :=
  match ty with
  | .bitvec w =>
    match op with
      | .icmp p w' => if  h : w = w'
      then return ⟨
        .icmp p w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
      | _ => throw <| .unsupportedOp "unsupported icmp operation"

def mkSelect {Γ : Ctxt (MTy φ)} {ty : (MTy φ)} (op : MOp φ)
    (c : Ctxt.Var Γ (.bitvec 1)) (e₁ e₂ : Ctxt.Var Γ ty) :
    MLIR.AST.ExceptM (MOp φ) <| Expr (MOp φ) Γ ty :=
  match ty with
  | .bitvec w =>
    match op with
        | .select w' => if  h : w = w'
        then return ⟨
          .select w',
          by simp [OpSignature.outTy, signature, h],
          .cons c <|.cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
          .nil
        ⟩
        else throw <| .widthError w w'
        | _ => throw <| .unsupportedOp "Unsupported select operation"

def mkOpExpr {Γ : Ctxt (MTy φ)} (op : MOp φ)
    (arg : HVector (fun t => Ctxt.Var Γ t) (OpSignature.sig op)) :
    MLIR.AST.ExceptM (MOp φ) <| Expr (MOp φ) Γ (OpSignature.outTy op) :=
  match op with
  | .and _ | .or _ | .xor _ | .shl _ | .lshr _ | .ashr _
  | .add _ | .mul _ | .sub _ | .udiv _ | .sdiv _
  | .srem _ | .urem _  =>
    let (e₁, e₂) := arg.toTuple
    mkBinOp op e₁ e₂
  | .icmp _ _ =>
    let (e₁, e₂) := arg.toTuple
    mkIcmp op e₁ e₂
  | .not _ | .neg _ | .copy _ =>
    mkUnaryOp op arg.head
  | .select _ =>
    let (c, e₁, e₂) := arg.toTuple
    mkSelect op c e₁ e₂
  | .const .. => throw <| .unsupportedOp  "Tried to build (MOp φ) expression from constant"

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (MOp φ) (MTy φ)
  | MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless w => do
    return .bitvec w
  | _ => throw .unsupportedType -- "Unsupported type"

instance instTransformTy : MLIR.AST.TransformTy (MOp φ) (MTy φ) φ where
  mkTy := mkTy

def mkExpr (Γ : Ctxt (MTy φ)) (opStx : MLIR.AST.Op φ) : AST.ReaderM (MOp φ) (Σ ty, Expr (MOp φ) Γ ty) := do
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
            return ⟨.bitvec w₂, selectOp⟩
          else
            throw <| .widthError w₁ w₂ -- s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
        else throw <| .unsupportedOp s!"expected select condtion to have width 1, found width '{w₁}'"
      | op => throw <| .unsupportedOp s!"Unsuported ternary operation or invalid arguments '{op}'"
  | v₁Stx::v₂Stx::[] =>
    let ⟨.bitvec w₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
    let ⟨.bitvec w₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
    -- let ty₁ := ty₁.instantiave
    let op ← match opStx.name with
      | "llvm.and"    => pure (MOp.and w₁)
      | "llvm.or"     => pure (MOp.or w₁)
      | "llvm.xor"    => pure (MOp.xor w₁)
      | "llvm.shl"    => pure (MOp.shl w₁)
      | "llvm.lshr"   => pure (MOp.lshr w₁)
      | "llvm.ashr"   => pure (MOp.ashr w₁)
      | "llvm.urem"   => pure (MOp.urem w₁)
      | "llvm.srem"   => pure (MOp.srem w₁)
      | "llvm.add"    => pure (MOp.add w₁)
      | "llvm.mul"    => pure (MOp.mul w₁)
      | "llvm.sub"    => pure (MOp.sub w₁)
      | "llvm.sdiv"   => pure (MOp.sdiv w₁)
      | "llvm.udiv"   => pure (MOp.udiv w₁)
      | "llvm.icmp.eq" => pure (MOp.icmp LLVM.IntPredicate.eq w₁)
      | "llvm.icmp.ne" => pure (MOp.icmp LLVM.IntPredicate.ne w₁)
      | "llvm.icmp.ugt" => pure (MOp.icmp LLVM.IntPredicate.ugt w₁)
      | "llvm.icmp.uge" => pure (MOp.icmp LLVM.IntPredicate.uge w₁)
      | "llvm.icmp.ult" => pure (MOp.icmp LLVM.IntPredicate.ult w₁)
      | "llvm.icmp.ule" => pure (MOp.icmp LLVM.IntPredicate.ule w₁)
      | "llvm.icmp.sgt" => pure (MOp.icmp LLVM.IntPredicate.sgt w₁)
      | "llvm.icmp.sge" => pure (MOp.icmp LLVM.IntPredicate.sge w₁)
      | "llvm.icmp.slt" => pure (MOp.icmp LLVM.IntPredicate.slt w₁)
      | "llvm.icmp.sle" => pure (MOp.icmp LLVM.IntPredicate.sle w₁)
      | opstr => throw <| .unsupportedOp s!"Unsuported binary operation or invalid arguments '{opstr}'"
    match op with
    | .icmp .. =>
      if hty : w₁ = w₂ then
        let icmpOp ← mkIcmp op v₁ (hty ▸ v₂)
        return ⟨.bitvec 1, icmpOp⟩
      else
        throw <| .widthError w₁ w₂ -- s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
    | _ =>
      if hty : w₁ = w₂ then
        let binOp ← mkBinOp op v₁ (hty ▸ v₂)
        return ⟨.bitvec w₁, binOp⟩
      else
        throw <| .widthError w₁ w₂ -- s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
  | vStx::[] =>
    let ⟨.bitvec w, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    let op ← match opStx.name with
        | "llvm.not" => pure <| MOp.not w
        | "llvm.neg" => pure <| MOp.neg w
        | "llvm.copy" => pure <| MOp.copy w
        | _ => throw <| .generic s!"Unknown (unary) operation syntax {opStx.name}"
    let op ← mkUnaryOp op v
    return ⟨.bitvec w, op⟩
  | [] =>
    if opStx.name ==  "llvm.mlir.constant"
    then do
    let some att := opStx.attrs.getAttr "value"
      | throw <| .generic "tried to resolve constant without 'value' attribute"
    match att with
      | .int val ty =>
          let opTy@(MTy.bitvec w) ← mkTy ty -- ty.mkTy
          return ⟨opTy, ⟨
            MOp.const w val,
            by simp [OpSignature.outTy, signature, *],
            HVector.nil,
            HVector.nil
          ⟩⟩
      | _ => throw <| .generic "invalid constant attribute"
    else
      throw <| .generic s!"invalid (0-ary) expression {opStx.name}"
  | _ => throw <| .generic s!"unsupported expression (with unsupported arity) {opStx.name}"

instance : AST.TransformExpr (MOp φ) (MTy φ) φ where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (MTy φ)) (opStx : MLIR.AST.Op φ) : MLIR.AST.ReaderM (MOp φ) (Σ ty, Com (MOp φ) Γ ty) :=
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨ty, _root_.Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : AST.TransformReturn (MOp φ) (MTy φ) φ where
  mkReturn := mkReturn


/-!
  ## Instantiation
  Finally, we show how to instantiate a family of programs to a concrete program
-/

def instantiateMTy (vals : Vector Nat φ) : (MTy φ) → InstCombine.Ty
  | .bitvec w => .bitvec <| .concrete <| w.instantiate vals

def instantiateMOp (vals : Vector Nat φ) : MOp φ → InstCombine.Op
  | .and w => .and (w.instantiate vals)
  | .or w => .or (w.instantiate vals)
  | .not w => .not (w.instantiate vals)
  | .xor w => .xor (w.instantiate vals)
  | .shl w => .shl (w.instantiate vals)
  | .lshr w => .lshr (w.instantiate vals)
  | .ashr w => .ashr (w.instantiate vals)
  | .urem w => .urem (w.instantiate vals)
  | .srem w => .srem (w.instantiate vals)
  | .select w => .select (w.instantiate vals)
  | .add w => .add (w.instantiate vals)
  | .mul w => .mul (w.instantiate vals)
  | .sub w => .sub (w.instantiate vals)
  | .neg w => .neg (w.instantiate vals)
  | .copy w => .copy (w.instantiate vals)
  | .sdiv w => .sdiv (w.instantiate vals)
  | .udiv w => .udiv (w.instantiate vals)
  | .icmp c w => .icmp c (w.instantiate vals)
  | .const w val => .const (w.instantiate vals) val

def instantiateCtxt (vals : Vector Nat φ) (Γ : Ctxt (MTy φ)) : Ctxt InstCombine.Ty :=
  Γ.map (instantiateMTy vals)

def MOp.instantiateCom (vals : Vector Nat φ) : DialectMorphism (MOp φ) (InstCombine.Op) where
  mapOp := instantiateMOp vals
  mapTy := instantiateMTy vals
  preserves_signature op := by
    simp only [instantiateMTy, instantiateMOp, ConcreteOrMVar.instantiate, (· <$> ·), signature,
      InstCombine.MOp.sig, InstCombine.MOp.outTy, Function.comp_apply, List.map, Signature.mk.injEq,
      true_and]
    cases op using MOp.deepCasesOn <;> simp only [List.map, and_self, List.cons.injEq]


open InstCombine (Op Ty) in
def mkComInstantiate (reg : MLIR.AST.Region φ) :
    MLIR.AST.ExceptM (MOp φ) (Vector Nat φ → Σ (Γ : Ctxt InstCombine.Ty) (ty : InstCombine.Ty), Com InstCombine.Op Γ ty) := do
  let ⟨Γ, ty, com⟩ ← MLIR.AST.mkCom reg
  return fun vals =>
    ⟨instantiateCtxt vals Γ, instantiateMTy vals ty, com.map (MOp.instantiateCom vals)⟩

end InstcombineTransformDialect


/-
https://leanprover.zulipchat.com/#narrow/stream/287929-mathlib4/topic/Cannot.20Find.20.60Real.2Eadd.60/near/402089561
> I would recommend avoiding Qq for pattern matching.
> That part of the Qq implementation is spicy.

Therefore, we choose to match on raw `Expr`.
-/
open MLIR.AST InstCombine in
elab "[alive_icom (" mvars:term,* ")| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let φ : Nat := mvars.getElems.size
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
  let mvalues ← `(⟨[$mvars,*], by rfl⟩)
  let mvalues : Q(Vector Nat $φ) ← elabTermEnsuringType mvalues q(Vector Nat $φ)
  let com := q(InstcombineTransformDialect.mkComInstantiate (φ := $φ) $ast |>.map (· $mvalues))
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(MLIR.AST.ExceptM (MOp $φ) (Σ (Γ' : Ctxt (MTy $φ)) (ty : (MTy $φ)), Com (MOp $φ) Γ' ty)) ←
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := TransparencyMode.all) <|
        return ←reduce com
  let comExpr : Expr := com
  trace[Meta] com
  trace[Meta] comExpr
  match comExpr.app3? ``Except.ok with
  | .some (_εexpr, _αexpr, aexpr) =>
      match aexpr.app4? ``Sigma.mk with
      | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
        match sndexpr.app4? ``Sigma.mk with
        | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
            return sndexpr
        | .none => throwError "Found `Except.ok (Sigma.mk _ WRONG)`, Expected (Except.ok (Sigma.mk _ (Sigma.mk _ _))"
      | .none => throwError "Found `Except.ok WRONG`, Expected (Except.ok (Sigma.mk _ _))"
  | .none => throwError "Expected `Except.ok`, found {comExpr}"
macro "[alive_icom| " reg:mlir_region "]" : term => `([alive_icom ()| $reg])
