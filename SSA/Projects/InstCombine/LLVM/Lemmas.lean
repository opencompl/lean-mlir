import SSA.Projects.InstCombine.LLVM.Semantics

/-- Note that this assumes that the input and output bitwidths are the same,
which is by far the common case. -/
@[simp]
theorem LLVM.lshr?_eq_value {a b : BitVec w} (hb : b < w) :
    LLVM.lshr? a b = .value (BitVec.ushiftRight a b.toNat) := by
  have : ¬ b ≥ w := by bv_omega
  simp only [LLVM.lshr?, this, reduceIte]
  simp

/-- Note that this assumes that the input and output bitwidths are the same,
which is by far the common case. -/
@[simp]
theorem LLVM.lshr?_eq_poison {a b : BitVec w} (hb : b ≥ w) : LLVM.lshr? a b = .poison := by
  simp only [LLVM.lshr?, hb, reduceIte]

@[simp]
theorem LLVM.select?_eq_poison : LLVM.select (w := w) .poison a b = .poison := rfl

@[simp]
theorem LLVM.select?_value_true : LLVM.select (w := w) (.value true) a b = a := rfl

@[simp]
theorem LLVM.select?_value_false : LLVM.select (w := w) (.value false) a b = b := rfl

@[simp]
theorem LLVM.select?_eq_value {w : Nat} {c : BitVec 1} {x y : LLVM.IntW w} :
    LLVM.select (.value c) x y =  if c = 1 then x else y := by
  simp [LLVM.select]

@[simp]
theorem LLVM.sdiv?_denom_zero {w : Nat} {a b : BitVec w} (hb : b = 0) :
    LLVM.sdiv? a b = .poison := by
  simp [LLVM.sdiv?, hb]
