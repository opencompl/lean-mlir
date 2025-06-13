import Qq
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet
import SSA.Projects.CIRCT.Comb.CombSemantics
import SSA.Projects.InstCombine.Base
import SSA.Core.MLIRSyntax.Transform.Utils
import SSA.Projects.InstCombine.LLVM.CLITests

open Qq Lean Meta Elab.Term Elab Command
open MLIR

namespace MLIR2Comb

section Dialect

inductive Ty
| bitvec (w : Nat) : Ty -- A bitvector of width `w`.
deriving DecidableEq, Repr, ToExpr

inductive Op
| add (w : Nat) (arity : Nat)
| and (w : Nat) (arity : Nat)
-- | concat (w : List Nat) -- len(w) = #args, wi is the width of the i-th arg
| divs (w : Nat)
| divu (w : Nat)
| extract (w : Nat) (n : Nat)
| icmp (p : String) (w : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat) (arity : Nat)
| mux (w : Nat)
| or (w : Nat) (arity : Nat)
| parity (w : Nat)
| replicate (w : Nat) (n : Nat)
| shl (w : Nat)
| shrs (w : Nat)
| shru (w : Nat)
| sub (w : Nat)
| xor (w : Nat) (arity : Nat)
deriving DecidableEq, Repr, ToExpr

abbrev Comb : Dialect where
  Op := Op
  Ty := Ty

instance : ToString Ty where
  toString t := repr t |>.pretty

def_signature for Comb where
  | .add w n => ${List.replicate n (Ty.bitvec w)} → (Ty.bitvec w)
  | .and w n => ${List.replicate n (Ty.bitvec w)} → (Ty.bitvec w)
  -- | .concat l => (Ty.hList l) → (Ty.bitvec l.sum)
  | .divs w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .divu w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .extract w n => (Ty.bitvec w) → (Ty.bitvec (w - n))
  | .icmp _ w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec 1)
  | .mods w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .modu w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .mul w n => ${List.replicate n (Ty.bitvec w)} → (Ty.bitvec w)
  | .mux w => (Ty.bitvec w, Ty.bitvec w, Ty.bitvec 1) → (Ty.bitvec w)
  | .or w n => ${List.replicate n (Ty.bitvec w)} → (Ty.bitvec w)
  | .parity w => (Ty.bitvec w) → (Ty.bitvec 1)
  | .replicate w n => (Ty.bitvec w) → (Ty.bitvec (w * n))
  | .shl w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .shrs w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .shru w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .sub w => (Ty.bitvec w, Ty.bitvec w) → (Ty.bitvec w)
  | .xor w n => ${List.replicate n (Ty.bitvec w)} → (Ty.bitvec w)

instance : TyDenote (Dialect.Ty Comb) where
  toType := fun
  | .bitvec w => BitVec w

def HVector.replicateToList {α : Type} {f : α → Type} {a : α} :
    {n : Nat} → HVector f (List.replicate n a) → List (f a)
  | 0, _ => []
  | n+1, HVector.cons x xs => x :: replicateToList xs

def ofString? (s : String) : Option CombOp.IcmpPredicate :=
  match s with
  | "eq" => some .eq
  | "ne" => some .ne
  | "slt" => some .slt
  | "sle" => some .sle
  | "sgt" => some .sgt
  | "sge" => some .sge
  | "ult" => some .ult
  | "ule" => some .ule
  | "ugt" => some .ugt
  | "uge" => some .uge
  | _     => none

def_denote for Comb where
  | .add _ _ => fun xs => CombOp.add (HVector.replicateToList (f := TyDenote.toType) xs)
  | .and _ _ => fun xs => CombOp.and (HVector.replicateToList (f := TyDenote.toType) xs)
  -- | .concat _ => fun xs => CombOp.concat xs
  | .divs _ => BitVec.sdiv
  | .divu _ => BitVec.udiv
  | .extract _ _ => fun x => CombOp.extract x _
  | .icmp p _ => fun x y => CombOp.icmp (Option.get! (ofString? p)) x y
  | .mods _ => BitVec.smod
  | .modu _ => BitVec.umod
  | .mul _ _ => fun xs => CombOp.mul (HVector.replicateToList (f := TyDenote.toType) xs)
  | .mux _ => fun x y => CombOp.mux x y
  | .or _ _ => fun xs => CombOp.or (HVector.replicateToList (f := TyDenote.toType) xs)
  | .parity _ => fun x => CombOp.parity x
  | .replicate _ n => fun xs => CombOp.replicate xs n
  | .shl _ => fun x y => CombOp.shl x y
  | .shrs _ => BitVec.sshiftRight'
  | .shru _ => fun x y => CombOp.shru x y
  | .sub _ => BitVec.sub
  | .xor _ _ => fun xs => CombOp.xor (HVector.replicateToList (f := TyDenote.toType) xs)

end Dialect

def mkTy : MLIR.AST.MLIRType 0 → MLIR.AST.ExceptM Comb (Comb.Ty)
  | MLIR.AST.MLIRType.int _ w =>
    match w with
    | .concrete w' => return .bitvec w'
    | .mvar _ => throw <| .generic s!" bitVec size can't be an mvar!"
  | _ => throw .unsupportedType

-- borrowed from the LLVM/EDSL infra
def getVarWidth {Γ : Ctxt Comb.Ty} : (Σ t, Γ.Var t) → Nat
  | ⟨.bitvec w, _⟩ => w

instance instTransformTy : AST.TransformTy (Comb) 0 := { mkTy }
instance : AST.TransformTy (Comb) 0 := { mkTy }

/-- Convert a list of dependent pairs into an HVector -/
def ofList {Γ : Ctxt _} ty : (l : List ((ty : Comb.Ty) × Γ.Var ty)) → (h : l.all (·.1 = ty)) → HVector (Γ.Var) (List.replicate l.length ty)
| [], h => .nil
| ⟨ty', var⟩::rest, h =>
  have hty : ty' = ty := by simp_all
  have hrest : rest.all (·.1 = ty) := by simp_all
  .cons (hty ▸ var) (ofList _ rest hrest)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM Comb (Σ eff ty, Expr Comb Γ eff ty) := do
  let args ← opStx.parseArgs Γ
  -- 1-ary ops
  let unW := do
    let args ← args.assumeArity 1
    return getVarWidth args[0]
  -- 2-ary ops
  let binW : AST.ReaderM (Comb) (Nat) := do
    let args ← args.assumeArity 2
    return getVarWidth args[0]
  -- 3-ary ops
  let terW : AST.ReaderM (Comb) (Nat) := do
    let args ← args.assumeArity 3
    return getVarWidth args[0]
  -- n-ary ops
  let args' ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ) -- will need to find a better way to do this
  if h : args'.length = 0 then
    throw <| .generic s!" empty list of argument provided for the variadic op {repr opStx.args}"
  else
    -- exclude empty list of args
    let nnW : AST.ReaderM (Comb) (Nat) := do
      let args ← args.assumeArity args'.length
      return getVarWidth args[0]
    let mkExprOf := opStx.mkExprOf (args? := args) Γ
    match (opStx.name).splitOn "_" with
    -- 1-ary
    | ["Comb.parity"] => mkExprOf <| .parity (← unW)
    | ["Comb.extract", ns] =>
      match ns.toNat? with
      | some n =>  mkExprOf <| .extract (← unW) n
      | _ => throw <| .generic s!" an integer attribute should be provided for {repr opStx.args}"
    | ["Comb.replicate", ns] =>
      match ns.toNat? with
      | some n =>  mkExprOf <| .replicate (← unW) n
      | _ => throw <| .generic s!" an integer attribute should be provided for {repr opStx.args}"
    -- 2-ary
    | ["Comb.divs"] => mkExprOf <| .divs (← binW)
    | ["Comb.divu"] => mkExprOf <| .divu (← binW)
    | ["Comb.icmp", ps] =>
      match (ofString? ps) with
      -- we avoid passing p as an IcmpPred type to avoid denoting the type
      | some p => mkExprOf <| .icmp ps (← binW)
      | _ => throw <| .generic s!" invalid attribute provided for {repr opStx.args}"
    | ["Comb.mods"] => mkExprOf <| .mods (← binW)
    | ["Comb.modu"] => mkExprOf <| .modu (← binW)
    | ["Comb.shl"] => mkExprOf <| .shl (← binW)
    | ["Comb.shrs"] => mkExprOf <| .shrs (← binW)
    | ["Comb.shru"] => mkExprOf <| .shru (← binW)
    | ["Comb.sub "] => mkExprOf <| .sub (← binW)
    -- 3-ary
    | ["Comb.mux"] => mkExprOf <| .mux (← terW)
    -- n-ary (variadic)
    | ["Comb.add"] => mkExprOf <| .add (← nnW) args'.length
    | ["Comb.and"] => mkExprOf <| .and (← nnW) args'.length
    | ["Comb.mul"] => mkExprOf <| .mul (← nnW) args'.length
    | ["Comb.or"] => mkExprOf <| .or (← nnW) args'.length
    | ["Comb.xor"] => mkExprOf <| .xor (← nnW) args'.length
    | _ => throw <| .unsupportedOp s!"{repr opStx}"

def mkReturn (Γ : Ctxt Comb.Ty) (opStx : MLIR.AST.Op 0) :
   MLIR.AST.ReaderM Comb (Σ eff ty, Com Comb Γ eff ty) := do
  if opStx.name ≠ "return" then
    throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"
  else
    let args ← (← opStx.parseArgs Γ).assumeArity 1
    let ⟨ty, v⟩ := args[0]
    return ⟨.pure, ty, Com.ret v⟩

instance : MLIR.AST.TransformExpr (Comb) 0 where
  mkExpr := mkExpr

instance : AST.TransformReturn Comb 0 := { mkReturn }

instance : DialectToExpr Comb where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``Comb []

open Qq MLIR AST Lean Elab Term Meta in
elab "[Comb_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom' reg Comb

end MLIR2Comb
