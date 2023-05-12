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

theorem InstCombineShift279 : ∀ w : Width, ∀ C : BitVector w,
  let minus_one : BitVector w := (-1).toBitVector
  let Γ : Context UserType := List.toAList [⟨42, .unit⟩]
  ∀ (e : EnvC Γ),  -- for metavariable in typeclass
  --@SSA.teval BaseType instDecidableEqBaseType instGoedelBaseType SSAIndex.REGION Op TUS
  SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0  =>
    %v42 := unit: ;
    %v1 := op: const C %v42
    dsl_ret %v1] (SSA.UserType.base (BaseType.bitvec w))
    (SSA.UserType.base (BaseType.bitvec w)) =
  SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0 =>
    %v42 := unit: ;
    %v1 := op: const C %v42
    dsl_ret %v1] (SSA.UserType.base (BaseType.bitvec w))
    (SSA.UserType.base (BaseType.bitvec w)) := by
      intros w C minus_one Γ e
      funext x
      checkpoint
      simp [TypedUserSemantics.argUserType, TypedUserSemantics.outUserType, TypedUserSemantics.eval, Op.const, Bind.bind, Option.bind]
      rw [InstCombineShift279_base]

#print InstCombineShift279

