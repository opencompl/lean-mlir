import SSA.Projects.InstCombine.LLVM.Semantics
import Mathlib.Tactic

/-- Note that this assumes that the input and output bitwidths are the same,
which is by far the common case. -/
@[simp]
theorem LLVM.lshr?_eq_some {a b : BitVec w} (hb : b < w) :
    LLVM.lshr? a b = .some (BitVec.ushiftRight a b.toNat) := by
  simp only [LLVM.lshr?]
  split_ifs
  case pos contra =>
    have hb' : ¬ b ≥ w := by
      simp at hb
      simp only [BitVec.natCast_eq_ofNat, ge_iff_le, BitVec.not_le, hb]
    contradiction
  case neg _ =>
    simp only [HShiftRight.hShiftRight]

/-- Note that this assumes that the input and output bitwidths are the same,
which is by far the common case. -/
@[simp]
theorem LLVM.lshr?_eq_none {a b : BitVec w} (hb : b ≥ w) : LLVM.lshr? a b = .none := by
  simp only [LLVM.lshr?]
  split_ifs; simp

@[simp]
theorem LLVM.select?_eq_none : LLVM.select (w := w) none a b = .none := rfl

@[simp]
theorem LLVM.select?_some_true : LLVM.select (w := w) (.some true) a b = a := rfl

@[simp]
theorem LLVM.select?_some_false : LLVM.select (w := w) (.some false) a b = b := rfl

@[simp]
theorem LLVM.select?_eq_some {w : Nat} {c : BitVec 1} {x y : Option (BitVec w)} :
    LLVM.select (.some c) x y =  if c = 1 then x else y := by
  simp [LLVM.select]

@[simp]
theorem LLVM.sdiv?_denom_zero {w : Nat} {a b : BitVec w} (hb : b = 0) : LLVM.sdiv? a b = none :=
  by simp [LLVM.sdiv?, hb]
