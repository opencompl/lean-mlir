import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.ComWrappers
open LLVM
open BitVec
open ComWrappers

open Ctxt (Var Valuation DerivedCtxt)

open Lean Elab Tactic Meta


theorem minimal6 : ∀ (x : BitVec 32),
  ((some x).bind fun x =>
    (if False then none else some (x.sshiftRight 1)).bind fun x' =>
      some (x'.sshiftRight 1))
  = (some x) := by
  intro x
  simp (config := {failIfUnchanged := false, implicitDefEqProofs := false}) only [Option.some_bind]


#check minimal6

/--
Check if an expression is contained in the current goal and fail otherwise.
This tactic does not modify the goal state.
 -/
local elab "contains? " ts:term : tactic => withMainContext do
  let tgt ← getMainTarget
  if (← kabstract tgt (← elabTerm ts none)) == tgt then throwError "pattern not found"

/-- Look for a variable in the context and generalize it, fail otherwise. -/
local macro "generalize_or_fail" "at" ll:ident : tactic =>
  `(tactic|
      (
        -- We first check with `contains?` if the term is present in the goal.
        -- This is needed as `generalize` never fails and just introduces a new
        -- metavariable in case no variable is found. `contains?` will instead
        -- fail if the term is not present in the goal.
        contains? ($ll (_ : Var ..))
        generalize ($ll (_ : Var ..)) = e at *;
        simp (config := {failIfUnchanged := false}) only [TyDenote.toType] at e
        revert e
      )
  )

/-- `only_goal $t` runs `$t` on the current goal, but only if there is a goal to be solved.
Essentially, this silences "no goals to be solved" errors -/
macro "only_goal" t:tacticSeq : tactic =>
  `(tactic| first | done | $t)


def lhs :
    Com InstCombine.LLVM [] .pure (InstCombine.Ty.bitvec 32) :=
  .var (const 32 (-1)) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def aaaaa:
    Com InstCombine.LLVM [] .pure (InstCombine.Ty.bitvec 32) :=
  .var (const 32 (-1)) <|
  .var (add 32 0 0 ) <|
  .var (neg 32 0) <|
  .ret ⟨1, by simp [Ctxt.snoc]⟩



#version
--set_option pp.all true in
--set_option debug.skipKernelTC true in
--set_option trace.profiler true in
set_option diagnostics true in
/-
[reduction] unfolded declarations (max: 268, num: 17): ▶
[reduction] unfolded instances (max: 133, num: 3): ▶
[reduction] unfolded reducible declarations (max: 2280, num: 21): ▶
[type_class] used instances (max: 23, num: 4): ▶
[def_eq] heuristic for solving `f a =?= f b` (max: 80, num: 7): ▶
[kernel] unfolded declarations (max: 200035, num: 44): ▶
use `set_option diagnostics.threshold <num>` to control threshold for reporting counters
-/
/-
[reduction] unfolded declarations (max: 268, num: 17): ▶
[reduction] unfolded instances (max: 133, num: 3): ▶
[reduction] unfolded reducible declarations (max: 2280, num: 21): ▶
[type_class] used instances (max: 23, num: 4): ▶
[def_eq] heuristic for solving `f a =?= f b` (max: 80, num: 7): ▶
[kernel] unfolded declarations (max: 50035, num: 44): ▶
use `set_option diagnostics.threshold <num>` to control threshold for reporting counters
-/
theorem dec_mask_neg_i32_proof (c : Ctxt.Valuation []) : lhs.denote c = aaaaa.denote c := by
  simp_alive_meta
  simp_alive_ssa

  /-
  [reduction] unfolded declarations (max: 268, num: 17): ▶
  [reduction] unfolded instances (max: 133, num: 3): ▶
  [reduction] unfolded reducible declarations (max: 2280, num: 21): ▶
  [type_class] used instances (max: 23, num: 4): ▶
  [def_eq] heuristic for solving `f a =?= f b` (max: 80, num: 7): ▶
  [kernel] unfolded declarations (max: 50035, num: 44): ▼
    [] Nat.rec ↦ 50035
    [] Nat.casesOn ↦ 30048
    [] Nat.add.match_1 ↦ 10004
    [] Nat.beq.match_1 ↦ 10001
    [] InstCombine.Ty ↦ 411
    [] Dialect.Ty ↦ 382
    [] TyDenote.toType ↦ 270
    [] InstCombine.MTy.casesOn ↦ 182
    [] InstCombine.MTy.rec ↦ 182
    [] InstCombine.Ty.width.match_1 ↦ 182
    [] ConcreteOrMVar.casesOn ↦ 181
    [] ConcreteOrMVar.rec ↦ 109
    [] Function.comp ↦ 107
    [] IntW ↦ 102
    [] InstCombine.MOp.casesOn ↦ 94
    [] Var ↦ 89
    [] HMod.hMod ↦ 57
    [] Mod.mod ↦ 57
    [] InstCombine.MOp.rec ↦ 57
    [] EffectKind.casesOn ↦ 53
    [] EffectKind.rec ↦ 53
    [] reprEffectKind.match_1✝ ↦ 51
    [] Id ↦ 51
    [] EffectKind.toMonad ↦ 51
    [] DialectSignature.sig ↦ 44
    [] Signature.sig ↦ 44
    [] InstCombine.MOp.sig ↦ 44
    [] InstCombine.MOp.sig.match_1 ↦ 44
    [] Ctxt.snoc ↦ 43
    [] InstCombine.MOp.outTy ↦ 41
    [] InstCombine.MOp.outTy.match_1 ↦ 41
    [] List.rec ↦ 36
    [] Dialect.Op ↦ 33
    [] InstCombine.Op ↦ 33
    [] DialectSignature.outTy ↦ 28
    [] Prod.fst ↦ 28
    [] Prod.snd ↦ 28
    [] Signature.outTy ↦ 28
    [] Ctxt ↦ 25
    [] InstCombine.Ty.bitvec ↦ 25
    [] Decidable.casesOn ↦ 22
    [] DialectSignature.effectKind ↦ 21
    [] pure ↦ 21
    [] Signature.effectKind ↦ 21
  use `set_option diagnostics.threshold <num>` to control threshold for reporting counters
  -/
  unfold lhs aaaaa
  simp only [simp_llvm_wrap]

  /- access the valuation -/
  --intros Γv

  rw [Com.denote]
  rw [Com.denote]
  rw [Com.denote]
  rw [Com.denote]
  --simp only [Com.denote]

  --simp (config := {failIfUnchanged := false}) only [
  --  Com.denote,
  --  ]
  rw [Expr.denote]
  rw [Expr.denote]
  rw [Expr.denote]

  rw [HVector.map]
  rw [HVector.map]
  rw [HVector.map]
  rw [HVector.map]
  rw [HVector.map]
  rw [HVector.map]

  rw [EffectKind.liftEffect_rfl]

  /-
  c : Ctxt.Valuation []
  ⊢ sorry.denote c =
    pure
      ((c::ᵥid
              (DialectDenote.denote (InstCombine.MOp.const (ConcreteOrMVar.concrete 32) (-1)) HVector.nil
                HVector.nil.denote)::ᵥid
            (DialectDenote.denote (InstCombine.MOp.add (ConcreteOrMVar.concrete 32))
              ((c::ᵥid
                      (DialectDenote.denote (InstCombine.MOp.const (ConcreteOrMVar.concrete 32) (-1)) HVector.nil
                        HVector.nil.denote))
                  ⟨0,
                    aaaaa.proof_1⟩::ₕ((c::ᵥid
                        (DialectDenote.denote (InstCombine.MOp.const (ConcreteOrMVar.concrete 32) (-1)) HVector.nil
                          HVector.nil.denote))
                    ⟨0, aaaaa.proof_1⟩::ₕHVector.nil))
              HVector.nil.denote))
        ⟨0, aaaaa.proof_3⟩)
  -/
  /-
  rw [Ctxt.Valuation.snoc_eval]
  revert c
  unfold Dialect.Ty
  unfold Dialect.m
  unfold InstCombine.LLVM
  simp only []
  -/


  /-
  c : Ctxt.Valuation []
  ⊢ sorry.denote c =
    pure
      ((c::ᵥid
              (DialectDenote.denote (InstCombine.MOp.const (ConcreteOrMVar.concrete 32) (-1)) HVector.nil
                HVector.nil.denote)::ᵥid
            (DialectDenote.denote (InstCombine.MOp.add (ConcreteOrMVar.concrete 32))
              ((c::ᵥid
                      (DialectDenote.denote (InstCombine.MOp.const (ConcreteOrMVar.concrete 32) (-1)) HVector.nil
                        HVector.nil.denote))
                  ⟨0,
                    aaaaa.proof_1⟩::ₕ((c::ᵥid
                        (DialectDenote.denote (InstCombine.MOp.const (ConcreteOrMVar.concrete 32) (-1)) HVector.nil
                          HVector.nil.denote))
                    ⟨0, aaaaa.proof_1⟩::ₕHVector.nil))
              HVector.nil.denote))
        ⟨0, aaaaa.proof_3⟩)
  -/
  simp (config := {failIfUnchanged := false, implicitDefEqProofs := false}) only [Ctxt.Valuation.snoc_eval]

  simp only [InstCombine.LLVM]
  revert c
  unfold Dialect.Ty
  simp only []

#print dec_mask_neg_i32_proof
