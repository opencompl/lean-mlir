import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false

set_option pp.proofs true
set_option pp.analyze true

theorem minimal : ∀ (x : BitVec 32),
  Refinement (α := BitVec 32)
    ((some x).bind fun x =>
      (if False then none else some (x.sshiftRight 1)).bind fun x' =>
        some (x'.sshiftRight 1))
    (some x) := by
  intro x
  simp only [Option.some_bind]

  sorry

-- Reducing/removing the if-then-else removes the error
theorem minimal1 : ∀ (x : BitVec 32),
  Refinement (α := BitVec 32)
    ((some x).bind fun x =>
      (if False then none else some (x.sshiftRight 1)).bind fun x' =>
        some (x'.sshiftRight 1))
    (some x) := by
  intro x
  simp only [Nat.reduceLeDiff, ↓reduceIte]
  simp only [Option.some_bind]

  sorry

-- removing the operation on x removes the error
theorem minimal2 : ∀ (x : BitVec 32),
  Refinement (α := BitVec 32)
    ((some x).bind fun x =>
      (if False then none else some x).bind fun x' =>
        some (x'.sshiftRight 1))
    (some x) := by
  intro x
  simp only [Option.some_bind]

  sorry

-- removing the operation on x' removes the error
theorem minimal3 : ∀ (x : BitVec 32),
  Refinement (α := BitVec 32)
    ((some x).bind fun x =>
      (if False then none else some (x.sshiftRight 1)).bind fun x' =>
        some (x'))
    (some x) := by
  intro x
  simp only [Option.some_bind]

  sorry

-- removing the trivial bind removes the error (note: this is the state in `minimal` after the simp)
theorem minimal4 : ∀ (x : BitVec 32),
  Refinement (α := BitVec 32)
    ((if False then none else some (x.sshiftRight 1)).bind fun x' => some (x'.sshiftRight 1))
    (some x) := by
  intro x
  simp (config:={failIfUnchanged := false}) only [Option.some_bind]

  sorry

-- Changing the type to Nat removes the error
theorem minimal5 : ∀ (x : ℕ),
  Refinement (α := ℕ)
    ((some x).bind fun x =>
      (if False then none else some (x >>> 1)).bind fun x' =>
        some (x' >>> 1))
    (some x) := by
  intro x
  simp only [Option.some_bind]

  sorry
