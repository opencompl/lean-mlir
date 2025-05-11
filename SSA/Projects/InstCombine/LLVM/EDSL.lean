/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import SSA.Projects.InstCombine.Base
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Projects.InstCombine.LLVM.CLITests

open Qq Lean Meta Elab.Term Elab Command
open InstCombine (LLVM MetaLLVM MOp Width)

open MLIR

namespace InstcombineTransformDialect

def mkUnaryOp {Γ : Ctxt (MetaLLVM φ).Ty} {w : Width φ} (op : MOp.UnaryOp φ)
  (e : Ctxt.Var Γ (.bitvec w)) : Expr (MetaLLVM φ) Γ .pure (op.outTy w) :=
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

def mkIcmp {Γ : Ctxt _} {w : Width φ} (p : LLVM.IntPred)
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

instance instTransformTy : AST.TransformTy (MetaLLVM φ) φ where
  mkTy := mkTy
instance : AST.TransformTy (LLVM) 0 where
  mkTy := mkTy

def getOutputWidth (opStx : MLIR.AST.Op φ) (op : String) :
    AST.ReaderM (MetaLLVM φ) (Width φ) := do
  match opStx.res with
  | res::[] =>
    match res.2 with
    | .int _ w => pure w
    | _ => throw <| .generic s!"The operation {op} must output an integer type"
  | _ => throw <| .generic s!"The operation {op} must have a single output"

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
        else throw <|
          .unsupportedOp s!"expected select condtion to have width 1, found width '{w₁}'"
      | op => throw <| .unsupportedOp s!"Unsuported ternary operation or invalid arguments '{op}'"
  | v₁Stx::v₂Stx::[] =>
    let ⟨.bitvec w,  v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
    let ⟨.bitvec w', v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx

    if hty : w ≠ w' then
      throw <| .widthError w w' -- the arguments don't have the same width!
    else
      let v₂ : Γ.Var (.bitvec w) := (by simpa using hty) ▸ v₂

      let (op : MOp.BinaryOp ⊕ LLVM.IntPred) ← match opStx.name with
        | "llvm.and"    => pure <| Sum.inl .and
        | "llvm.or"     => do
          let isDisjoint? := opStx.attrs.getAttr "isDisjoint"
          pure <| Sum.inl (.or ⟨isDisjoint?.isSome⟩)
        | "llvm.xor"    => pure <| Sum.inl .xor
        | "llvm.urem"   => pure <| Sum.inl .urem
        | "llvm.srem"   => pure <| Sum.inl .srem
        | "llvm.lshr"   => do
          let isExact? := opStx.attrs.getAttr "isExact"
          pure <| Sum.inl (.lshr ⟨isExact?.isSome⟩)
        | "llvm.ashr"   => do
          let isExact? := opStx.attrs.getAttr "isExact"
          pure <| Sum.inl (.ashr ⟨isExact?.isSome⟩)
        | "llvm.sdiv"   => do
          let isExact? := opStx.attrs.getAttr "isExact"
          pure <| Sum.inl (.sdiv ⟨isExact?.isSome⟩)
        | "llvm.udiv"   => do
          let isExact? := opStx.attrs.getAttr "isExact"
          pure <| Sum.inl (.udiv ⟨isExact?.isSome⟩)
        | "llvm.shl"    =>  do
          let attr? := opStx.attrs.getAttr "overflowFlags"
          match attr? with
            | .none =>  pure <| Sum.inl (MOp.BinaryOp.shl)
            | .some y => match y with
              | .opaque_ "llvm.overflow" "nsw" => pure <| Sum.inl (MOp.BinaryOp.shl ⟨true, false⟩)
              | .opaque_ "llvm.overflow" "nuw" => pure <| Sum.inl (MOp.BinaryOp.shl ⟨false, true⟩)
              | .list [.opaque_ "llvm.overflow" "nuw", .opaque_ "llvm.overflow" "nsw"] => pure <| Sum.inl (MOp.BinaryOp.shl ⟨true, true⟩)
              | .list [.opaque_ "llvm.overflow" "nsw", .opaque_ "llvm.overflow" "nuw"] => pure <| Sum.inl (MOp.BinaryOp.shl ⟨true, true⟩)
              | .opaque_ "llvm.overflow" s => throw <| .generic s!"The overflow flag {s} not allowed. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
              | _ => throw <| .generic s!"Unrecognised overflow flag found: {MLIR.AST.docAttrVal y}. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
        | "llvm.add"    =>  do
          let attr? := opStx.attrs.getAttr "overflowFlags"
          match attr? with
            | .none =>  pure <| Sum.inl (MOp.BinaryOp.add)
            | .some y => match y with
              | .opaque_ "llvm.overflow" "nsw" => pure <| Sum.inl (MOp.BinaryOp.add ⟨true, false⟩)
              | .opaque_ "llvm.overflow" "nuw" => pure <| Sum.inl (MOp.BinaryOp.add ⟨false, true⟩)
              | .list [.opaque_ "llvm.overflow" "nuw", .opaque_ "llvm.overflow" "nsw"] => pure <| Sum.inl (MOp.BinaryOp.add ⟨true, true⟩)
              | .list [.opaque_ "llvm.overflow" "nsw", .opaque_ "llvm.overflow" "nuw"] => pure <| Sum.inl (MOp.BinaryOp.add ⟨true, true⟩)
              | .opaque_ "llvm.overflow" s => throw <| .generic s!"The overflow flag {s} not allowed. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
              | _ => throw <| .generic s!"Unrecognised overflow flag found: {MLIR.AST.docAttrVal y}. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
        | "llvm.mul"    => do
          let attr? := opStx.attrs.getAttr "overflowFlags"
          match attr? with
            | .none =>  pure <| Sum.inl (MOp.BinaryOp.mul)
            | .some y => match y with
              | .opaque_ "llvm.overflow" "nsw" => pure <| Sum.inl (MOp.BinaryOp.mul ⟨true, false⟩)
              | .opaque_ "llvm.overflow" "nuw" => pure <| Sum.inl (MOp.BinaryOp.mul ⟨false, true⟩)
              | .list [.opaque_ "llvm.overflow" "nuw", .opaque_ "llvm.overflow" "nsw"] => pure <| Sum.inl (MOp.BinaryOp.mul ⟨true, true⟩)
              | .list [.opaque_ "llvm.overflow" "nsw", .opaque_ "llvm.overflow" "nuw"] => pure <| Sum.inl (MOp.BinaryOp.mul ⟨true, true⟩)
              | .opaque_ "llvm.overflow" s => throw <| .generic s!"The overflow flag {s} not allowed. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
              | _ => throw <| .generic s!"Unrecognised overflow flag found: {MLIR.AST.docAttrVal y}. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
        | "llvm.sub"    =>  do
          let attr? := opStx.attrs.getAttr "overflowFlags"
          match attr? with
            | .none =>  pure <| Sum.inl (MOp.BinaryOp.sub)
            | .some y => match y with
              | .opaque_ "llvm.overflow" "nsw" => pure <| Sum.inl (MOp.BinaryOp.sub ⟨true, false⟩)
              | .opaque_ "llvm.overflow" "nuw" => pure <| Sum.inl (MOp.BinaryOp.sub ⟨false, true⟩)
              | .list [.opaque_ "llvm.overflow" "nuw", .opaque_ "llvm.overflow" "nsw"] => pure <| Sum.inl (MOp.BinaryOp.sub ⟨true, true⟩)
              | .list [.opaque_ "llvm.overflow" "nsw", .opaque_ "llvm.overflow" "nuw"] => pure <| Sum.inl (MOp.BinaryOp.sub ⟨true, true⟩)
              | .opaque_ "llvm.overflow" s => throw <| .generic s!"The overflow flag {s} not allowed. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
              | _ => throw <| .generic s!"Unrecognised overflow flag found: {MLIR.AST.docAttrVal y}. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
        | "llvm.icmp.eq"  => pure <| Sum.inr LLVM.IntPred.eq
        | "llvm.icmp.ne"  => pure <| Sum.inr LLVM.IntPred.ne
        | "llvm.icmp.ugt" => pure <| Sum.inr LLVM.IntPred.ugt
        | "llvm.icmp.uge" => pure <| Sum.inr LLVM.IntPred.uge
        | "llvm.icmp.ult" => pure <| Sum.inr LLVM.IntPred.ult
        | "llvm.icmp.ule" => pure <| Sum.inr LLVM.IntPred.ule
        | "llvm.icmp.sgt" => pure <| Sum.inr LLVM.IntPred.sgt
        | "llvm.icmp.sge" => pure <| Sum.inr LLVM.IntPred.sge
        | "llvm.icmp.slt" => pure <| Sum.inr LLVM.IntPred.slt
        | "llvm.icmp.sle" => pure <| Sum.inr LLVM.IntPred.sle
        | opstr => throw <|
          .unsupportedOp s!"Unsuported binary operation or invalid arguments '{opstr}'"
      return match op with
        | .inl binOp  => ⟨_, _, mkBinOp binOp v₁ v₂⟩
        | .inr pred   => ⟨_, _, mkIcmp pred v₁ v₂⟩
  | vStx::[] =>
    let ⟨.bitvec w, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    let op ← match opStx.name with
        | "llvm.not"   => pure .not
        | "llvm.neg"   => pure .neg
        | "llvm.copy"  => pure .copy
        | "llvm.zext"  => do
          let nonNeg? := opStx.attrs.getAttr "nonNeg"
          pure <| .zext (← getOutputWidth opStx "zext") ⟨nonNeg?.isSome⟩
        | "llvm.sext"  => pure <| .sext (← getOutputWidth opStx "sext")
        | "llvm.trunc" => do
          let attr? := opStx.attrs.getAttr "overflowFlags"
          match attr? with
            | .none =>  pure <| .trunc (← getOutputWidth opStx "trunc")
            | .some y => match y with
              | .opaque_ "llvm.overflow" "nsw" => pure <| .trunc (← getOutputWidth opStx "trunc") ⟨true, false⟩
              | .opaque_ "llvm.overflow" "nuw" => pure <| .trunc (← getOutputWidth opStx "trunc") ⟨false, true⟩
              | .list [.opaque_ "llvm.overflow" "nuw", .opaque_ "llvm.overflow" "nsw"] => pure <| .trunc (← getOutputWidth opStx "trunc") ⟨true, true⟩
              | .list [.opaque_ "llvm.overflow" "nsw", .opaque_ "llvm.overflow" "nuw"] => pure <| .trunc (← getOutputWidth opStx "trunc") ⟨true, true⟩
              | .opaque_ "llvm.overflow" s => throw <| .generic s!"The overflow flag {s} not allowed. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
              | _ => throw <| .generic s!"Unrecognised overflow flag found: {MLIR.AST.docAttrVal y}. We currently support nsw (no signed wrap) and nuw (no unsigned wrap)"
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
instance : AST.TransformExpr LLVM 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (MetaLLVM φ).Ty) (opStx : MLIR.AST.Op φ) :
    MLIR.AST.ReaderM (MetaLLVM φ) (Σ eff ty, Com (MetaLLVM φ) Γ eff ty) :=
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, _root_.Com.ret v⟩
  | _ => throw <|
    .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : AST.TransformReturn (MetaLLVM φ) φ where
  mkReturn := mkReturn
instance : AST.TransformReturn LLVM 0 where
  mkReturn := mkReturn

/-!
  ## Instantiation
  Finally, we show how to instantiate a family of programs to a concrete program
-/

open InstCombine LLVM Qq in
def MetaLLVM.instantiate (vals : Vector Expr φ) : DialectMetaMorphism (MetaLLVM φ) q(LLVM) where
  mapTy := fun
  | .bitvec w =>
    mkApp (mkConst ``Ty.bitvec) <| w.metaInstantiate vals
  mapOp :=
    fun
    | .binary w binOp =>
      let w := w.metaInstantiate vals
      mkApp2 (mkConst ``Op.binary) w (toExpr binOp)
    | .unary w unOp =>
      let w := w.metaInstantiate vals

      /- NOTE: `Op` contructors expect a `Nat` argument to indicate the width,
          but `MOp.UnaryOp` constructors expect `ConcreteOrMVar Nat 0`.
          Hence, we define `mapWidth` to construct the latter
      -/
      let mapWidth (w : ConcreteOrMVar Nat φ) : Q(ConcreteOrMVar Nat 0) :=
        let w : Q(Nat) := w.metaInstantiate vals
        q(.concrete $w)
      open MOp (UnaryOp) in
      let unOp : Q(UnaryOp 0) := match unOp with
        | .neg => q(.neg)
        | .not => q(.not)
        | .copy => q(.copy)
        | .trunc w' flags => q(.trunc $(mapWidth w') $flags)
        | .zext w' nneg => q(.zext $(mapWidth w') $nneg)
        | .sext w' => q(.sext $(mapWidth w'))
      mkApp2 (mkConst ``Op.unary) w unOp
    | .select w =>
      let w : Q(Nat) := w.metaInstantiate vals
      mkApp (mkConst ``Op.select) w
    | .icmp c w =>
      let w := w.metaInstantiate vals
      let c := toExpr c
      mkApp2 (mkConst ``Op.icmp) c w
    | .const w val =>
      let w := w.metaInstantiate vals
      let val := toExpr val
      mkApp2 (mkConst ``Op.const) w val

end InstcombineTransformDialect


open SSA InstcombineTransformDialect InstCombine in
elab "[llvm(" mvars:term,* ")| " reg:mlir_region "]" : term => do
  withTraceNode `LeanMLIR.Elab (pure m!"{exceptEmoji ·} elaborate LLVM program") <| do

  let φ : Nat := mvars.getElems.size
  let ⟨_, _, _, mcom⟩ ← SSA.elabIntoComObj reg (MetaLLVM φ)

  let res ← mcom.metaMap <| MetaLLVM.instantiate <| ←do
    let mvars : Vector _ φ := ⟨mvars.getElems, rfl⟩
    mvars.mapM fun (stx : Term) =>
      elabTermEnsuringType stx (mkConst ``Nat)

  trace[LeanMLIR.Elab] "elaborated expression: {res}"
  return res

macro "[llvm| " reg:mlir_region "]" : term => `([llvm()| $reg])

macro "deftest" name:ident " := " test_reg:mlir_region : command => do
  `(@[reducible, llvmTest $name] def $(name) : ConcreteCliTest :=
       let code := [llvm()| $test_reg]
       { name := $(quote name.getId), ty := code.ty, context := code.ctxt, code := code, })

section Test
open InstCombine.LLVM.Ty (bitvec)

/-- Assert that the elaborator respects variable ordering correctly -/
private def variable_order1 : Com LLVM [bitvec 2, bitvec 1]  .pure (bitvec 1) := [llvm()| {
    ^bb0(%arg1: i1, %arg2 : i2):
      "llvm.return"(%arg1) : (i1) -> ()
  }]
/-- Assert that the elaborator respects variable ordering correctly -/
private def variable_order2 : Com LLVM [bitvec 2, bitvec 1] .pure (bitvec 2) := [llvm()| {
    ^bb0(%arg1: i1, %arg2 : i2):
      "llvm.return"(%arg2) : (i2) -> ()
  }]
