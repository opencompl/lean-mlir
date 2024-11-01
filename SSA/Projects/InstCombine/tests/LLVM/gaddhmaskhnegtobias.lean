import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.ComWrappers
open LLVM
open BitVec
open ComWrappers

open Ctxt (Var Valuation DerivedCtxt)

open Lean Elab Tactic Meta

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
    Com InstCombine.LLVM [] .pure (InstCombine.Ty.bitvec 32) := sorry

def aaaaa:
    Com InstCombine.LLVM [] .pure (InstCombine.Ty.bitvec 32) :=
  .var (const 32 (-1)) <|
  .var (add 32 0 0 ) <|
  .var (neg 32 0) <|
  .ret ⟨1, by simp [Ctxt.snoc]⟩

#check InstCombine.LLVM


theorem test : ∀ (c : @Ctxt.Valuation InstCombine.Ty InstCombine.instTyDenoteTy (@List.nil.{0} InstCombine.Ty)),
  @Eq.{1}
    (EffectKind.toMonad EffectKind.pure Id.{0}
      (@TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy
        (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))))
    (@Com.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM
      InstCombine.instTyDenoteTy InstCombine.instDialectDenoteLLVM Id.instMonad.{0} (@List.nil.{0} InstCombine.Ty)
      EffectKind.pure (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
      (sorryAx.{1}
        (@Com (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM
          (@List.nil.{0} InstCombine.Ty) EffectKind.pure
          (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
        Bool.false)
      c)
    (@Pure.pure.{0, 0} (EffectKind.toMonad EffectKind.pure Id.{0})
      (@Applicative.toPure.{0, 0} (EffectKind.toMonad EffectKind.pure Id.{0})
        (@Monad.toApplicative.{0, 0} (EffectKind.toMonad EffectKind.pure Id.{0})
          (@EffectKind.instMonadToMonad EffectKind.pure Id.{0} Id.instMonad.{0})))
      (@TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy
        (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
      (@Ctxt.Valuation.snoc InstCombine.Ty InstCombine.instTyDenoteTy
        (@Ctxt.snoc InstCombine.Ty (@List.nil.{0} InstCombine.Ty)
          (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
        (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
        (@Ctxt.Valuation.snoc InstCombine.Ty InstCombine.instTyDenoteTy (@List.nil.{0} InstCombine.Ty)
          (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))) c
          (@id.{1}
            (EffectKind.toMonad
              (@DialectSignature.effectKind (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                InstCombine.instDialectSignatureLLVM
                (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                  (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
              Id.{0}
              (@TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy
                (@DialectSignature.outTy (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                  InstCombine.instDialectSignatureLLVM
                  (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                      (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                    (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))))
            (@DialectDenote.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instTyDenoteTy
              InstCombine.instDialectSignatureLLVM InstCombine.instDialectDenoteLLVM
              (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1))))
              (@HVector.nil.{0, 0} InstCombine.Ty fun (x : InstCombine.Ty) =>
                @TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy x)
              (@HVector.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM
                InstCombine.instTyDenoteTy InstCombine.instDialectDenoteLLVM Id.instMonad.{0}
                (@DialectSignature.regSig (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                  InstCombine.instDialectSignatureLLVM
                  (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                      (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                    (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
                (@HVector.nil.{0, 0} (Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty)
                  fun (t : Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty) =>
                  @Com (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM t.1
                    EffectKind.impure t.2)))))
        (@id.{1}
          (EffectKind.toMonad
            (@DialectSignature.effectKind (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
              InstCombine.instDialectSignatureLLVM
              (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
            Id.{0}
            (@TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy
              (@DialectSignature.outTy (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                InstCombine.instDialectSignatureLLVM
                (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                  (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))))
          (@DialectDenote.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instTyDenoteTy
            InstCombine.instDialectSignatureLLVM InstCombine.instDialectDenoteLLVM
            (@InstCombine.MOp.add (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
              (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
              (LLVM.NoWrapFlags.mk Bool.false Bool.false))
            (@HVector.cons.{0, 0} InstCombine.Ty
              (fun (x : InstCombine.Ty) => @TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy x)
              (@List.cons.{0} InstCombine.Ty
                (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                (@List.nil.{0} (InstCombine.MTy (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0)))))
              (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
              (@Ctxt.Valuation.snoc InstCombine.Ty InstCombine.instTyDenoteTy (@List.nil.{0} InstCombine.Ty)
                (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))) c
                (@id.{1}
                  (EffectKind.toMonad
                    (@DialectSignature.effectKind (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                      InstCombine.instDialectSignatureLLVM
                      (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                        (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                          (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                        (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
                    Id.{0}
                    (@TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy
                      (@DialectSignature.outTy (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                        InstCombine.instDialectSignatureLLVM
                        (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                          (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                          (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))))
                  (@DialectDenote.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instTyDenoteTy
                    InstCombine.instDialectSignatureLLVM InstCombine.instDialectDenoteLLVM
                    (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                      (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                        (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                      (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1))))
                    (@HVector.nil.{0, 0} InstCombine.Ty fun (x : InstCombine.Ty) =>
                      @TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy x)
                    (@HVector.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                      InstCombine.instDialectSignatureLLVM InstCombine.instTyDenoteTy InstCombine.instDialectDenoteLLVM
                      Id.instMonad.{0}
                      (@DialectSignature.regSig (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                        InstCombine.instDialectSignatureLLVM
                        (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                          (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                          (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
                      (@HVector.nil.{0, 0} (Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty)
                        fun (t : Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty) =>
                        @Com (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM t.1
                          EffectKind.impure t.2))))
                (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                (@Subtype.mk.{1} Nat
                  (fun (i : Nat) =>
                    @Eq.{1} (Option.{0} InstCombine.Ty)
                      (@Ctxt.get? InstCombine.Ty
                        (@Ctxt.snoc InstCombine.Ty (@List.nil.{0} InstCombine.Ty)
                          (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                        i)
                      (@Option.some.{0} InstCombine.Ty
                        (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                          (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))))
                  (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0)) aaaaa.proof_1))
              (@HVector.cons.{0, 0} InstCombine.Ty
                (fun (x : InstCombine.Ty) => @TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy x)
                (@List.nil.{0} InstCombine.Ty)
                (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                (@Ctxt.Valuation.snoc InstCombine.Ty InstCombine.instTyDenoteTy (@List.nil.{0} InstCombine.Ty)
                  (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))) c
                  (@id.{1}
                    (EffectKind.toMonad
                      (@DialectSignature.effectKind (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                        InstCombine.instDialectSignatureLLVM
                        (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                          (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                          (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
                      Id.{0}
                      (@TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy
                        (@DialectSignature.outTy (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                          InstCombine.instDialectSignatureLLVM
                          (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                              (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                            (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))))
                    (@DialectDenote.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instTyDenoteTy
                      InstCombine.instDialectSignatureLLVM InstCombine.instDialectDenoteLLVM
                      (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                        (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                          (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                        (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1))))
                      (@HVector.nil.{0, 0} InstCombine.Ty fun (x : InstCombine.Ty) =>
                        @TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy x)
                      (@HVector.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                        InstCombine.instDialectSignatureLLVM InstCombine.instTyDenoteTy
                        InstCombine.instDialectDenoteLLVM Id.instMonad.{0}
                        (@DialectSignature.regSig (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                          InstCombine.instDialectSignatureLLVM
                          (@InstCombine.MOp.const (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                              (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                            (@Neg.neg.{0} Int Int.instNegInt (@OfNat.ofNat.{0} Int 1 (@instOfNat 1)))))
                        (@HVector.nil.{0, 0} (Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty)
                          fun (t : Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty) =>
                          @Com (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM
                            t.1 EffectKind.impure t.2))))
                  (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                      (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                  (@Subtype.mk.{1} Nat
                    (fun (i : Nat) =>
                      @Eq.{1} (Option.{0} InstCombine.Ty)
                        (@Ctxt.get? InstCombine.Ty
                          (@Ctxt.snoc InstCombine.Ty (@List.nil.{0} InstCombine.Ty)
                            (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                          i)
                        (@Option.some.{0} InstCombine.Ty
                          (@InstCombine.MTy.bitvec (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                            (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                              (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))))
                    (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0)) aaaaa.proof_1))
                (@HVector.nil.{0, 0} InstCombine.Ty fun (x : InstCombine.Ty) =>
                  @TyDenote.toType InstCombine.Ty InstCombine.instTyDenoteTy x)))
            (@HVector.denote (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM
              InstCombine.instTyDenoteTy InstCombine.instDialectDenoteLLVM Id.instMonad.{0}
              (@DialectSignature.regSig (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0})
                InstCombine.instDialectSignatureLLVM
                (@InstCombine.MOp.add (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                  (@ConcreteOrMVar.concrete.{0} Nat (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0))
                    (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
                  (LLVM.NoWrapFlags.mk Bool.false Bool.false)))
              (@HVector.nil.{0, 0} (Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty)
                fun (t : Prod.{0, 0} (Ctxt InstCombine.Ty) InstCombine.Ty) =>
                @Com (Dialect.mk InstCombine.Op InstCombine.Ty Id.{0}) InstCombine.instDialectSignatureLLVM t.1
                  EffectKind.impure t.2))))
        (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))
        (@Subtype.mk.{1} Nat
          (fun (i : Nat) =>
            @Eq.{1} (Option.{0} InstCombine.Ty)
              (@Ctxt.get? InstCombine.Ty
                (@Ctxt.snoc InstCombine.Ty
                  (@Ctxt.snoc InstCombine.Ty (@List.nil.{0} InstCombine.Ty)
                    (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                  (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32))))
                i)
              (@Option.some.{0} InstCombine.Ty (InstCombine.Ty.bitvec (@OfNat.ofNat.{0} Nat 32 (instOfNatNat 32)))))
          (@OfNat.ofNat.{0} Nat 0 (instOfNatNat 0)) aaaaa.proof_3))) := by
  s

--set_option pp.all true in
--set_option debug.skipKernelTC true in
theorem dec_mask_neg_i32_proof (c : Ctxt.Valuation []) : lhs.denote c = aaaaa.denote c := by
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
  simp (config := {failIfUnchanged := false}) only [Ctxt.Valuation.snoc_eval]
  simp only [InstCombine.LLVM]
  revert c
  unfold Dialect.Ty
  simp only []
