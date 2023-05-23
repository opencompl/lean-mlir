import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.InstCombineBase

open SSA InstCombine

theorem InstCombineShift279_base : ∀ w : ℕ+, ∀ x C : BitVector w,
  BitVector.shl (BitVector.lshr x C) C = BitVector.and x (BitVector.shl (-1).toBitVector C) :=
  sorry

-- Why do these not get set?
-- Activate to crash @commit a2df44f6 | register_simp_attr SSA.teval
-- Activate to crash @commit a2df44f6 | register_simp_attr EnvU.set
-- Activate to crash @commit a2df44f6 | register_simp_attr Op.const
-- Activate to crash @commit a2df44f6 | register_simp_attr argUserType
-- Activate to crash @commit a2df44f6 | register_simp_attr eval
-- Activate to crash @commit a2df44f6 | register_simp_attr outUserType
-- Activate to crash @commit a2df44f6 | register_simp_attr BitVector.width
-- Activate to crash @commit a2df44f6 | register_simp_attr uncurry

def thingy : TSSA Op ∅ (TSSAIndex.REGION (.base (BaseType.bitvec 32)) (.base (.bitvec 32))) :=
  TSSA.rgn (arg := 'x'.toNat) <|
  TSSA.ret
    (TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign TSSA.nop
      'a'.toNat (TSSA.pair Context.Var.last Context.Var.last))
      'y'.toNat (TSSA.op (Op.and 32) Context.Var.last TSSA.rgn0))
      'b'.toNat (TSSA.pair Context.Var.last Context.Var.last.prev.prev))
      'z'.toNat (TSSA.op (Op.or 32) Context.Var.last TSSA.rgn0))
    Context.Var.last



example : thingy.eval = sorry := by
  simp [TypedUserSemantics.eval, UserType.mkPair]
  admit

def thingy2 : TSSA Op
  ((Context.empty.snoc 'x'.toNat (.base $ .bitvec 32)).snoc
    'Α'.toNat (.base $ .bitvec 16))
  (.TERMINATOR (.base $ .bitvec 32)) :=
  TSSA.ret
    (TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign
      TSSA.nop
      'a'.toNat (TSSA.pair Context.Var.last.prev Context.Var.last.prev))
      'y'.toNat (TSSA.op (Op.and 32) Context.Var.last TSSA.rgn0))
      'b'.toNat (TSSA.pair Context.Var.last Context.Var.last.prev.prev.prev))
      'c'.toNat (TSSA.pair Context.Var.last Context.Var.last.prev.prev.prev))
      'z'.toNat (TSSA.op (Op.or 32) Context.Var.last.prev TSSA.rgn0))
    Context.Var.last

example : thingy2.eval = sorry := by
  simp [TypedUserSemantics.eval, UserType.mkPair]
  admit

open EDSL in 
def example_macro_1 : TSSA Op Context.empty (.TERMINATOR (.unit)) :=
  [dsl_bb|
    ^bb
      %v0 := unit:
      dsl_ret %v0
  ] 

theorem Option.some_eq_pure {α : Type u} : @some α = @pure _ _ _ := rfl
-- @Goens fix this
-- @bollu fix notation
-- theorem InstCombineShift279 : ∀ w : ℕ+, ∀ C : BitVector w,
--   let minus_one : BitVector w := (-1).toBitVector
--   let Γ : Context UserType := List.toAList [⟨42, .unit⟩]
--   ∀ (e : EnvC Γ),  -- for metavariable in typeclass
--   --@SSA.teval BaseType instDecidableEqBaseType instGoedelBaseType SSAIndex.REGION Op TUS
--   SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0  =>
--     %v42 := unit: ;
--     %v1 := op: const C %v42;
--     %v2 := pair: %v0 %v1;
--     %v3 := op: lshr w %v2;
--     %v4 := pair: %v3 %v1;
--     %v5 := op: shl w %v4
--     dsl_ret %v5] (SSA.UserType.base (BaseType.bitvec w))
--     (SSA.UserType.base (BaseType.bitvec w)) =
--   SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0 =>
--     %v42 := unit: ;
--     %v1 := op: const minus_one %v42;
--     %v2 := op: const C %v42;
--     %v3 := pair: %v1 %v2;
--     %v4 := op: shl w %v3;
--     %v5 := pair: %v0 %v4;
--     %v6 := op: and w %v5
--     dsl_ret %v6] (SSA.UserType.base (BaseType.bitvec w))
--     (SSA.UserType.base (BaseType.bitvec w)) := by
--       intros w C minus_one Γ e
--       funext x
--       simp only [SSA.teval]
--       simp only [Function.comp]
--       simp only [id.def]
--       simp only [SSA.teval]
--       simp only [EnvU.set]
--       simp only [if_false]
--       simp only [if_true]
--       simp only [TypedUserSemantics.outUserType]
--       simp only [TypedUserSemantics.argUserType]
--       simp only [TypedUserSemantics.rgnDom]
--       simp only [TypedUserSemantics.rgnCod]
--       simp only [TypedUserSemantics.eval]
--       simp only [outUserType]
--       simp only [eval]
--       simp only [if_true]
--       simp only [argUserType]
--       simp only [Option.some_eq_pure]
--       simp only [EnvC.toEnvU]
--       simp only [uncurry]
--       simp only [Option.elim]
--       simp only [BitVector.width]
--       simp only [pure_bind]
--       simp only [dite_true]
--       simp only [pure_bind]
--       simp only [dite_true]
--       simp only [pure_bind]
--       simp only [dite_true]
--       simp only [pure_bind]
--       simp only [if_true]
--       simp only [pure_bind]
--       simp only [dite_true]
--       congr
--       rw [InstCombineShift279_base]
