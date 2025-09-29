
theorem ofBool_1_iff_true : BitVec.ofBool b = 1#1 ↔ b = true := by
  cases b <;> simp

theorem ofBool_0_iff_false : BitVec.ofBool b = 0#1 ↔ b = false := by
  cases b <;> simp
