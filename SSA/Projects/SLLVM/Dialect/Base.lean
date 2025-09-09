/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Framework.Macro

import SSA.Projects.InstCombine.Base
import SSA.Projects.SLLVM.Dialect.Semantics

namespace LeanMLIR
open InstCombine (LLVM)

/-!
## SLLVM Dialect
SLLVM stands for "Structured LLVM"; eventually this dialect will become a
formalization of the `ptr + arith + scf` MLIR dialects.
This IR is conceptually similar to LLVM IR, except it uses only *structured*
control flow, hence the name.

Note that in the formalization, we assume a 64-bit architecture!
Nothing in the formalization itself should depend on the exact pointer-width,
but this assumption does affect which optimizations are admitted.

For now, though, this dialect just models only arithmetic, just like our
existing LLVM dialect, *but* it refines the semantics to include a proper model
of (side-effecting) UB.
-/

/-! ### Dialect definition -/

inductive SLLVMOp where
  | arith (o : LLVM.Op)
  | ptradd
  | load (w : Nat)
  | store (w : Nat)
  | free
  deriving DecidableEq, Lean.ToExpr

inductive SLLVMTy where
  | arith (t : LLVM.Ty)
  | ptr
  deriving DecidableEq, Lean.ToExpr

def SLLVM : Dialect where
  Op := SLLVMOp
  Ty := SLLVMTy
  m := EffectM

namespace SLLVM

instance : TyDenote SLLVM.Ty where
  toType
  | .arith t => ⟦t⟧
  | .ptr => SLLVM.Ptr

instance : DecidableEq SLLVM.Op := by unfold SLLVM; infer_instance
instance : DecidableEq SLLVM.Ty := by unfold SLLVM; infer_instance
instance : Lean.ToExpr SLLVM.Op := by unfold SLLVM; infer_instance
instance : Lean.ToExpr SLLVM.Ty := by unfold SLLVM; infer_instance

-- instance : ToString SLLVM.Op    := by unfold SLLVM; infer_instance
-- instance : ToString SLLVM.Ty    := by unfold SLLVM; infer_instance
-- instance : Repr SLLVM.Op        := by unfold SLLVM; infer_instance
-- instance : Repr SLLVM.Ty        := by unfold SLLVM; infer_instance

instance : Monad SLLVM.m        := by unfold SLLVM; infer_instance
instance : LawfulMonad SLLVM.m  := by unfold SLLVM; infer_instance

open Qq in instance : DialectToExpr SLLVM where
  toExprDialect := q(SLLVM)
  toExprM := q(Id.{0})

@[simp, simp_denote]
theorem m_eq : SLLVM.m α = EffectM α := by rfl

/-! ### Aliasses -/
section Alias
open InstCombine.LLVM SLLVMOp

@[match_pattern] nonrec abbrev Ty.arith : LLVM.Ty → SLLVM.Ty := .arith

@[match_pattern] abbrev Ty.bitvec (w : Nat) : SLLVM.Ty := .arith (.bitvec w)
@[match_pattern] abbrev Ty.ptr : SLLVM.Ty := .ptr

@[match_pattern] nonrec abbrev Op.arith : LLVM.Op → SLLVM.Op := .arith

@[match_pattern] nonrec abbrev Op.neg (w : Nat) : SLLVM.Op := arith <| Op.neg w
@[match_pattern] nonrec abbrev Op.not (w : Nat) : SLLVM.Op := arith <| Op.not w
@[match_pattern] nonrec abbrev Op.copy (w : Nat) : SLLVM.Op := arith <| Op.copy w
@[match_pattern] nonrec abbrev Op.sext (w w' : Nat) : SLLVM.Op := arith <| Op.sext w w'
@[match_pattern] nonrec abbrev Op.zext (w w' : Nat) (flag : LLVM.NonNegFlag := { }) : SLLVM.Op := arith <| Op.zext w w' flag
@[match_pattern] nonrec abbrev Op.trunc (w w' : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.trunc w w' flags

@[match_pattern] nonrec abbrev Op.and (w : Nat) : SLLVM.Op := arith <| Op.and w
@[match_pattern] nonrec abbrev Op.or (w : Nat) (flag : LLVM.DisjointFlag := { }) : SLLVM.Op := arith <| Op.or w flag
@[match_pattern] nonrec abbrev Op.xor (w : Nat) : SLLVM.Op := arith <| Op.xor w
@[match_pattern] nonrec abbrev Op.shl (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.shl w flags
@[match_pattern] nonrec abbrev Op.lshr (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.lshr w flag
@[match_pattern] nonrec abbrev Op.ashr (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.ashr w flag
@[match_pattern] nonrec abbrev Op.add (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.add w flags
@[match_pattern] nonrec abbrev Op.mul (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.mul w flags
@[match_pattern] nonrec abbrev Op.sub (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.sub w flags

@[match_pattern] nonrec abbrev Op.icmp (c : LLVM.IntPred) (w : Nat) : SLLVM.Op := arith <| Op.icmp c w
@[match_pattern] nonrec abbrev Op.const (w : Nat) (val : Int) : SLLVM.Op := arith <| Op.const w val
@[match_pattern] nonrec abbrev Op.select (w : Nat) : SLLVM.Op := arith <| Op.select w

@[match_pattern] nonrec abbrev Op.udiv (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.udiv w flag
@[match_pattern] nonrec abbrev Op.sdiv (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.sdiv w flag
@[match_pattern] nonrec abbrev Op.urem : Nat → SLLVM.Op := arith ∘ Op.urem
@[match_pattern] nonrec abbrev Op.srem : Nat → SLLVM.Op := arith ∘ Op.srem


@[simp, simp_denote] theorem toType_arith : toType (Ty.arith t) = toType t := rfl
@[simp, simp_denote] theorem toType_bitvec : toType (Ty.bitvec w) = LLVM.IntW w := rfl

end Alias

/-! ### Signature -/

open SLLVM.Ty in
/-- The signature of each operation is the same as in LLVM. -/
instance : DialectSignature SLLVM where
  signature
  | .arith op => SLLVM.Ty.arith <$> { DialectSignature.signature (d := LLVM) op with
        effectKind := match op with
          | .udiv .. | .sdiv .. | .urem .. | .srem .. => .impure
          | _ => .pure
      }
  | .ptradd => { sig := [ptr, bitvec 64], regSig := [], returnTypes := [ptr], effectKind := .pure }
  | .load w => { sig := [ptr], regSig := [], returnTypes := [bitvec w], effectKind := .impure }
  | .store w => { sig := [ptr, bitvec w], regSig := [], returnTypes := [], effectKind := .impure }
  | .free => { sig := [ptr], regSig := [], returnTypes := [], effectKind := .impure }


/-! ### argsToLLVM Helper -/
section ArgsToLLVM

def argsToLLVM {tys : List LLVM.Ty} :
    HVector toType (Ty.arith <$> tys) → HVector toType tys :=
  HVector.cast (by simp) (by simp)

open Qq Lean Meta in
partial def reduceArgsToLLVMAux : Meta.Simp.DSimproc := fun e => do
  let_expr argsToLLVM tys xs := e
    | return .continue
  withTraceNode `LeanMLIR.Elab (fun _ => pure m!"Simplifying application of `argsToLLVM`: {e}") <| do
    let ⟨_, ys⟩ ← go tys xs
    return .visit ys
where go (tys xs : Lean.Expr) : MetaM (Σ (tys : Q(List LLVM.Ty)), Q(HVector toType $tys)) :=
  match_expr xs with
  | HVector.nil _ _ =>
      return ⟨_, q(HVector.nil)⟩
  | HVector.cons _α _A tys t y ys => do
      let t' ← mkFreshExprMVarQ q(LLVM.Ty)
      let expected := mkApp (mkConst ``Ty.arith) t'
      unless (← isDefEq t expected) do
        trace[LeanMLIR.Elab] "{crossEmoji} Failed to unify:\n\t{t}\nwith:\n\t{expected}\
          \n\nIn implicit argument of expression:\n\t{xs}"
      let ⟨tys', ys⟩ ← go tys ys
      return ⟨
        q($t' :: $tys'),
        mkAppN (.const ``HVector.cons [0, 0]) #[
          q(LLVM.Ty), q(@toType LLVM.Ty _), tys', t', y, ys
        ]⟩
  | _ => do
      trace[LeanMLIR.Elab] "{crossEmoji} Failed to decompose:\n\t{xs}\
        \nExpected either `HVector.cons` or `HVector.nil`"
      return ⟨tys, xs⟩

-- simproc [simp, simp_denote] reduceArgsToLLVM (argsToLLVM (tys := no_index _) (
simproc reduceArgsToLLVM (argsToLLVM (tys := no_index (?t :: ?ts)) (
    .cons (α := no_index _) (f := no_index _) (a := no_index _) (as := no_index _) _ _)
  ) :=
  -- reduceArgsToLLVMAux
  fun _ => return .continue


theorem foo (x : ⟦Ty.arith t⟧) (xs : HVector toType (Ty.arith <$> ts)) :
    argsToLLVM (tys := no_index (t :: ts)) (
      .cons (α := no_index _) (f := no_index _) (a := no_index (Ty.arith t)) (as := no_index (Ty.arith <$> ts)) x xs)
    = zs := by
  sorry
#discr_tree_simp_key foo

open Lean Meta Elab Command DiscrTree Simp in
elab "#discr_tree_simproc_key " k:ident : command => liftTermElabM <| do
  let state := simprocDeclExt.getState (← getEnv)
  if let some (some keys) := state.newEntries[k.getId]? then
    Lean.logInfo (← keysAsPattern keys)
  else
    let n ← realizeGlobalConstNoOverloadWithInfo k
    if let some (some keys) := state.newEntries[n]? then
      Lean.logInfo (← keysAsPattern keys)
    else
      throwErrorAt k "not a simproc: {k}"

#discr_tree_simproc_key reduceArgsToLLVM

/-!
NOTE: we aggresively unfold `⟦t⟧` when `t` is a concrete type, and in our proof
goals `t` is always a concrete goal. That is why in `argsToLLVM_cons` we have to
specify `x : LLVM.IntW w`. Recall that Lean does not perform higher-order
unification, so if we instead said `x : ⟦t⟧`, Lean would not be able to
figure out that `t` should be assigned to `bitvec w` to unify `⟦t⟧` with
`LLVM.IntW w`, and instead would fail to apply the rewrite!
-/

end ArgsToLLVM

open Op in
instance : DialectDenote SLLVM where
  denote
  | Op.udiv _ flag => fun ([x, y]ₕ) _ => ([·]ₕ) <$> SLLVM.udiv x y flag
  | Op.sdiv _ flag => fun ([x, y]ₕ) _ => ([·]ₕ) <$> SLLVM.sdiv x y flag
  | Op.urem _      => fun ([x, y]ₕ) _ => ([·]ₕ) <$> SLLVM.urem x y
  | Op.srem _      => fun ([x, y]ₕ) _ => ([·]ₕ) <$> SLLVM.srem x y
  | Op.arith op => fun args .nil => do
    let x ← EffectKind.liftEffect (EffectKind.pure_le _) <|
      let args := SLLVM.argsToLLVM args
      DialectDenote.denote (d := LLVM) op args .nil
      return x.map' SLLVM.Ty.arith (fun _ x => x)
  -- ^^ For all other arithmetic ops, just refer to the pure LLVM semantics

  | .ptradd   => fun ([p, x]ₕ) _  => ([·]ₕ) <$> SLLVM.ptradd p x
  | .load w   => fun ([p]ₕ) _     => ([·]ₕ) <$> SLLVM.load p w
  | .store _  => fun ([p, x]ₕ) _  => (fun _ => []ₕ) <$> SLLVM.store p x
  | .free     => fun ([p]ₕ) _     => (fun _ => []ₕ) <$> SLLVM.free p

/-! ### Printing -/
section Print

instance : ToString SLLVM.Ty where
  toString := fun
    | .arith ty => toString ty
    | .ptr => "ptr"

instance : ToString SLLVM.Op where
  toString := fun
    | .arith op => toString op
    | .ptradd   => "ptradd"
    | .load _   => "load"
    | .store _  => "store"
    | .free     => "free"

instance : Repr SLLVM.Ty where
  reprPrec ty _ := toString ty
instance : Repr SLLVM.Op where
  reprPrec op _ := toString op

end Print
