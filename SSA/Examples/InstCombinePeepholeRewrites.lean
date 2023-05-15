import SSA.WellTypedFramework
import SSA.Examples.InstCombineBase

open SSA InstCombine

theorem InstCombineShift279_base : ∀ w : Width, ∀ x C : BitVector w,
  BitVector.shl (BitVector.lshr x C) C = BitVector.and x (BitVector.shl (-1).toBitVector C) :=
  sorry

-- Why do these not get set?
register_simp_attr SSA.teval
register_simp_attr EnvU.set
register_simp_attr Op.const
register_simp_attr argUserType
register_simp_attr eval
register_simp_attr outUserType
register_simp_attr BitVector.width
register_simp_attr uncurry

theorem Option.some_eq_pure {α : Type u} : @some α = @pure _ _ _ := rfl

theorem InstCombineShift279 : ∀ w : Width, ∀ C : BitVector w,
  let minus_one : BitVector w := (-1).toBitVector
  let Γ : Context UserType := List.toAList [⟨42, .unit⟩]
  ∀ (e : EnvC Γ),  -- for metavariable in typeclass
  --@SSA.teval BaseType instDecidableEqBaseType instGoedelBaseType SSAIndex.REGION Op TUS
  SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0  =>
    %v42 := unit: ;
    %v1 := op: const C %v42;
    %v2 := pair: %v0 %v1;
    %v3 := op: lshr w %v2;
    %v4 := pair: %v3 %v1;
    %v5 := op: shl w %v4
    dsl_ret %v5] (SSA.UserType.base (BaseType.bitvec w))
    (SSA.UserType.base (BaseType.bitvec w)) =
  SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0 =>
    %v42 := unit: ;
    %v1 := op: const minus_one %v42;
    %v2 := op: const C %v42;
    %v3 := pair: %v1 %v2;
    %v4 := op: shl w %v3;
    %v5 := pair: %v0 %v4;
    %v6 := op: and w %v5
    dsl_ret %v6] (SSA.UserType.base (BaseType.bitvec w))
    (SSA.UserType.base (BaseType.bitvec w)) := by
      intros w C minus_one Γ e
      funext x
      simp only [SSA.teval, Function.comp, id.def,
        EnvU.set, if_true, pure_bind,
        TypedUserSemantics.argUserType, argUserType,
        TypedUserSemantics.rgnDom, rgnDom,
        TypedUserSemantics.rgnCod, rgnCod,
        TypedUserSemantics.outUserType, outUserType,
        TypedUserSemantics.eval,
        argUserType, dite_true, if_false,
        eq_self_iff_true, EnvC.toEnvU, Option.elim,
        AList.lookup, List.dlookup, eval, true_and, and_true,
        Option.some_eq_pure,
        BitVector.width, List.foldr, pure_bind, uncurry]
      rw [InstCombineShift279_base]
