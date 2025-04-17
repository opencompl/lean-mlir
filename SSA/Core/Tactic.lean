/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.MLIRSyntax.EDSL
import SSA.Core.Tactic.TacBench
import SSA.Core.Tactic.SimpSet
import Qq
import Lean.Meta.KAbstract
import Lean.Elab.Tactic.ElabTerm

namespace SSA

open Ctxt (Var Valuation DerivedCtxt)

open Lean Elab Tactic Meta

attribute [simp_denote]
  Int.ofNat_eq_coe Nat.cast_zero DerivedCtxt.snoc DerivedCtxt.ofCtxt
  DerivedCtxt.ofCtxt_empty Valuation.snoc_last
  Var.zero_eq_last Var.succ_eq_toSnoc
  Ctxt.empty Ctxt.empty_eq Ctxt.snoc Ctxt.Valuation.nil
  Ctxt.Valuation.snoc_last Ctxt.map
  Ctxt.Valuation.snoc_eval Ctxt.ofList Ctxt.Valuation.snoc_toSnoc
  HVector.map HVector.getN HVector.get HVector.toSingle HVector.toPair HVector.toTuple
  DialectDenote.denote Expr.op_mk Expr.args_mk
  DialectMorphism.mapOp DialectMorphism.mapTy List.map Ctxt.snoc List.map
  Function.comp Valuation.ofPair Valuation.ofHVector Function.uncurry
  List.length_singleton Fin.zero_eta List.map_eq_map List.map_cons List.map_nil
  bind_assoc pairBind
  /- `castPureToEff` -/
  Com.letPure Expr.denote_castPureToEff
  /- Unfold denotation -/
  Com.denote_var Com.denote_ret Expr.denote_unfold HVector.denote
  /- Effect massaging -/
  EffectKind.toMonad_pure EffectKind.toMonad_impure
  EffectKind.liftEffect_rfl
  Id.pure_eq Id.bind_eq id_eq

/-!
NOTE (Here Be Dragons 🐉):
`HVector.denote` has a typeclass assumption `TyDenote (Dialect.Ty d)`, where `d : Dialect`.
However, we tend to define `d` as an `abbrev`, so that our goal statement might have
`HVector.denote` where the concrete instance is `instTyDenote : TyDenote Ty`,
  and `Ty` is the expression that `d` was defined with.

We've observed `simp [HVector.denote]` not working in such situations.
  Even more surprising, `rw [HVector.denote]` *did* succeed in rewriting.
According to Zulip (https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/simp.20.5BX.5D.20fails.2C.20rw.20.5BX.5D.20works/near/358861409):
> simp [(X)] is a standard trick to fix simp [X] not working

By default, it seems that `simp` will synthesize typeclass arguments of a lemma, and then
use the *default* instance to determine whether a simp-lemma applies to the current goal.
Writing `simp [(X)]`, on the other hand, is equivalent to writing `simp [@X _ _ _]`
  (for as many underscores as `X` takes arguments, implicit or explicit).
The parentheses seems to enable `simp` to unify typeclass arguments as well, and thus the
  simp-lemma applies even for non-standard instances.

We've replicated this effect by defining `HVector.denote_{nil,cons}'`, as analogues
to their non-primed lemmas, which instead take all instances as regular implicit
arguments, thus guiding `simp` to unify against non-standard instances.
-/
section
variable {d : Dialect} {instSig : DialectSignature d}
  {instTyDenote : TyDenote d.Ty} {instDenote : DialectDenote d}
  {instMonad : Monad d.m}

@[simp_denote] lemma HVector.denote_nil'
    (T : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 .impure t.2) []) :
    HVector.denote T = HVector.nil := by
  cases T; simp [HVector.denote]

@[simp_denote] lemma HVector.denote_cons'
    (t : Ctxt d.Ty × d.Ty) (ts : List (Ctxt d.Ty × d.Ty))
    (a : Com d t.1 .impure t.2) (as : HVector (fun t => Com d t.1 .impure t.2) ts) :
    HVector.denote (.cons a as) = .cons (a.denote) (as.denote) := by
  simp [HVector.denote]

end

/--
`elimValuation` simplifies universal quantifiers `∀ (V : Valuation [t₁, ..., tₙ])`,
where the context of the valuation is a concrete list of types, into a sequence
of quantifiers `∀ (x0 : ⟦t₁⟧) (x1 : ⟦t₂⟧) ... (xn : ⟦tₙ⟧)`.
-/
simproc [simp_denote] elimValuation (∀ (_ : Ctxt.Valuation _), _) := fun e => do
  let .forallE _name VTy@(mkApp3 (.const ``Ctxt.Valuation _) Ty instTyDenote Γ) body _info := e
    | return .continue

  let some (_, Γelems) := Γ.listLit?
    | return .continue
  let Γelems := Γelems.toArray.reverse
  let xsTypes := Γelems.map (mkApp3 (mkConst ``TyDenote.toType) Ty instTyDenote)
  let declInfo := xsTypes.mapIdx fun i ty =>
    let x := if i == 0 then "e" else s!"e_{i}"
    (Name.mkSimple x, ty)

  withLocalDeclsDND declInfo <| fun xs => do
    let V := Valuation.mkOfElems Ty instTyDenote Γelems xs
    let newType ← mkForallFVars xs (body.instantiate1 V)
    let proof :=
      let mp  :=
        ←withLocalDeclD .anonymous e <| fun eProof => do
          mkLambdaFVars #[eProof] <|← mkLambdaFVars xs <| mkApp eProof V
      let mpr :=
        ←withLocalDeclD .anonymous newType <| fun newProof =>
          withLocalDeclD .anonymous VTy <| fun V => do
            let xs ← Γelems.reverse.mapIdxM fun i ty =>
              let v := Ctxt.mkVar Ty Γ ty (toExpr i) none
              pure <| mkApp2 V ty v
            mkLambdaFVars #[newProof, V] <| mkAppN newProof xs.reverse
      mkApp3 (mkConst ``propext) e newType <|
        mkApp4 (mkConst ``Iff.intro) e newType mp mpr
    return .visit {
      expr := newType,
      proof? := some proof
    }

open Lean.Parser.Tactic (location)
/--
`simp_peephole` simplifies away the framework overhead of denoting expressions/programs.

NOTE: crucial rewrites (in particular, `Com.denote_var`) will only apply if the
dialect monad `d.m` is known to be lawful. If `simp_peephole` is not simplifying
as expected, first verify that a `LawfulMonad d.m` instance is synthesizable.
-/
macro "simp_peephole" loc:(location)? : tactic =>
  `(tactic|(
      -- First, we ensure potential quantification over a Valuation is made explicit
      first
      | rw [funext_iff (α := Ctxt.Valuation _)] $[$loc]?
      | change ∀ (_ : Ctxt.Valuation _), _ $[$loc]?
      | skip
      -- Then, we simplify with the `simp_denote` simpset
      simp (config := {failIfUnchanged := false}) only [simp_denote] $[$loc]?
  ))

end SSA
