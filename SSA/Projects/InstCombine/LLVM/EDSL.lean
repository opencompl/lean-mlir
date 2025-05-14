/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import SSA.Projects.InstCombine.Base
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.MLIRSyntax.Transform.Utils
import SSA.Projects.InstCombine.LLVM.CLITests

open Qq Lean Meta Elab.Term Elab Command
open InstCombine (LLVM MetaLLVM MOp Width)

open MLIR

namespace InstcombineTransformDialect
open AST (Op TransformError)
private abbrev ReaderM (φ) := AST.ReaderM (MetaLLVM φ)

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (MetaLLVM φ) ((MetaLLVM φ).Ty)
  | MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless w => return .bitvec w
  | _ => throw .unsupportedType

instance instTransformTy : AST.TransformTy (MetaLLVM φ) φ := { mkTy }
instance : AST.TransformTy (LLVM) 0 := { mkTy }

def getOutputWidth (opStx : MLIR.AST.Op φ) (op : String) :
    Except (TransformError) (Width φ) := do
  match opStx.res with
  | res::[] =>
    match res.2 with
    | .int _ w => pure w
    | _ => throw <| .generic s!"The operation {op} must output an integer type"
  | _ => throw <| .generic s!"The operation {op} must have a single output"

/-- Given a variable of arbitrary type, return its width.

This relies on the fact that `bitvec _` is the only type currently modelled.
In future, this might start throwing errors, if the type is not a bitvec.
-/
def getVarWidth {Γ : Ctxt (MetaLLVM φ).Ty} : (Σ t, Γ.Var t) → Width φ
  | ⟨.bitvec w, _⟩ => w

def parseOverflowFlags (op : AST.Op φ) : ReaderM φ LLVM.NoWrapFlags :=
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

open InstCombine.MOp in
def mkExpr (Γ : Ctxt (MetaLLVM φ).Ty) (opStx : MLIR.AST.Op φ) :
    AST.ReaderM (MetaLLVM φ) (Σ eff ty, Expr (MetaLLVM φ) Γ eff ty) := do
  let args ← opStx.parseArgs Γ

  /- `binW` is the (lazily computed) width, assuming a binary operation -/
  let binW : AST.ReaderM (MetaLLVM φ) (Width φ) := do
  -- ^^ NOTE: `binW` is bound with := rather than ← on purpose, to ensure laziness
    let args ← args.assumeArity 2
    return getVarWidth args[0]

  /- `unW` is the (lazily computed) width, assuming an unary operation -/
  let unW := do
    let args ← args.assumeArity 1
    return getVarWidth args[0]

  let mkExprOf := opStx.mkExprOf (args? := args) Γ
  match opStx.name with
    -- Ternary Operations
    | "llvm.select" =>
        let args ← args.assumeArity 3
        let w := getVarWidth args[1]
        mkExprOf <| select w
    -- Binary Operations
    | "llvm.and"      => mkExprOf <| and (← binW)
    | "llvm.or"       => mkExprOf <| or (← binW) ⟨opStx.hasAttr "isDisjoint"⟩
    | "llvm.xor"      => mkExprOf <| xor (← binW)
    | "llvm.urem"     => mkExprOf <| urem (← binW)
    | "llvm.srem"     => mkExprOf <| srem (← binW)
    | "llvm.lshr"     => mkExprOf <| lshr (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.ashr"     => mkExprOf <| ashr (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.sdiv"     => mkExprOf <| sdiv (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.udiv"     => mkExprOf <| udiv (← binW) ⟨opStx.hasAttr "isExact"⟩
    | "llvm.shl"      => mkExprOf <| shl (← binW) (← parseOverflowFlags opStx)
    | "llvm.add"      => mkExprOf <| add (← binW) (← parseOverflowFlags opStx)
    | "llvm.mul"      => mkExprOf <| mul (← binW) (← parseOverflowFlags opStx)
    | "llvm.sub"      => mkExprOf <| sub (← binW) (← parseOverflowFlags opStx)
    | "llvm.icmp.eq"  => mkExprOf <| icmp .eq (← binW)
    | "llvm.icmp.ne"  => mkExprOf <| icmp .ne (← binW)
    | "llvm.icmp.ugt" => mkExprOf <| icmp .ugt (← binW)
    | "llvm.icmp.uge" => mkExprOf <| icmp .uge (← binW)
    | "llvm.icmp.ult" => mkExprOf <| icmp .ult (← binW)
    | "llvm.icmp.ule" => mkExprOf <| icmp .ule (← binW)
    | "llvm.icmp.sgt" => mkExprOf <| icmp .sgt (← binW)
    | "llvm.icmp.sge" => mkExprOf <| icmp .sge (← binW)
    | "llvm.icmp.slt" => mkExprOf <| icmp .slt (← binW)
    | "llvm.icmp.sle" => mkExprOf <| icmp .sle (← binW)
    -- Unary Operations
    | "llvm.not"   => mkExprOf <| .not (← unW)
    | "llvm.neg"   => mkExprOf <| neg (← unW)
    | "llvm.copy"  => mkExprOf <| copy (← unW)
    | "llvm.zext"  => mkExprOf <| zext (← unW) (← getOutputWidth opStx "zext") ⟨ opStx.hasAttr "nonNeg" ⟩
    | "llvm.sext"  => mkExprOf <| sext (← unW) (← getOutputWidth opStx "sext")
    | "llvm.trunc" => mkExprOf <| trunc (← unW) (← getOutputWidth opStx "trunc") (← parseOverflowFlags opStx)
    -- Constant
    | "llvm.mlir.constant" =>
      let ⟨val, ty⟩ ← opStx.getIntAttr (Ty := (MetaLLVM φ).Ty) "value"
      let opTy@(.bitvec w) ← mkTy ty
      mkExprOf <| const w val
    -- Fallback
    | opName => throw <| .unsupportedOp opName

instance : AST.TransformExpr (MetaLLVM φ) φ := { mkExpr }
instance : AST.TransformExpr LLVM 0 := { mkExpr }

def mkReturn (Γ : Ctxt (MetaLLVM φ).Ty) (opStx : MLIR.AST.Op φ) :
    MLIR.AST.ReaderM (MetaLLVM φ) (Σ eff ty, Com (MetaLLVM φ) Γ eff ty) := do
  if opStx.name ≠ "llvm.return" then
    throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"
  else
    let args ← (← opStx.parseArgs Γ).assumeArity 1
    let ⟨ty, v⟩ := args[0]
    return ⟨.pure, ty, Com.ret v⟩

instance : AST.TransformReturn (MetaLLVM φ) φ := { mkReturn }
instance : AST.TransformReturn LLVM 0 := { mkReturn }

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
