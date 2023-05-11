import SSA.WellTypedFramework
import SSA.Examples.InstCombineBase

open SSA InstCombine

theorem InstCombineShift279_base : ∀ w : Width, ∀ x C : BitVector w,
  BitVector.shl (BitVector.lshr x C) C = BitVector.and x (BitVector.shl (-1).toBitVector C) :=
  sorry

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
      simp [SSA.teval, EnvU.set, TypedUserSemantics.argUserType, TypedUserSemantics.outUserType, TypedUserSemantics.eval, Op.const, argUserType, Bind.bind, Option.bind, eval, outUserType, BitVector.width, uncurry]
      rw [InstCombineShift279_base]
