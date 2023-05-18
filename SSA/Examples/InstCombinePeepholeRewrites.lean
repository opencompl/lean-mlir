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
      simp only [SSA.teval]
      simp only [Function.comp]
      simp only [id.def]
      simp only [SSA.teval]
      simp only [EnvU.set]
      simp only [if_false]
      simp only [if_true]
      simp only [TypedUserSemantics.outUserType]
      simp only [TypedUserSemantics.argUserType]
      simp only [TypedUserSemantics.rgnDom]
      simp only [TypedUserSemantics.rgnCod]
      simp only [TypedUserSemantics.eval]
      simp only [outUserType]
      simp only [eval]
      simp only [if_true]
      simp only [argUserType]
      simp only [Option.some_eq_pure]
      simp only [EnvC.toEnvU]
      simp only [uncurry]
      simp only [Option.elim]
      simp only [BitVector.width]
      simp only [pure_bind]
      simp only [dite_true]
      simp only [pure_bind]
      simp only [dite_true]
      simp only [pure_bind]
      simp only [dite_true]
      simp only [pure_bind]
      simp only [if_true]
      simp only [pure_bind]
      simp only [dite_true]
      congr
      rw [InstCombineShift279_base]

/-
Name: 805
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0
-/


/-
Name: SimplifyDivRemOfSelect
; FIXME: applies to *div/*rem
%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y


; FIXME: cannot do the remaining part of SimplifyDivRemOfSelect
-/


/-
Name: 290 & 292
%Op0 = shl 1, %Y
%r = mul %Op0, %Op1
  =>
%r = shl %Op1, %Y
-/


/-
Name: Select:746
%c = icmp slt %A, 0
%minus = sub 0, %A
%abs = select %c, %A, %minus
%c2 = icmp sgt %abs, 0
%minus2 = sub 0, %abs
%abs2 = select %c2, %abs, %minus2
  =>
%c3 = icmp sgt %A, 0
%abs2 = select %c3, %A, %minus
-/
