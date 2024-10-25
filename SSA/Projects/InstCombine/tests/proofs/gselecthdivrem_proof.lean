
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gselecthdivrem_proof
theorem udiv_common_divisor_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a / x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 then none else some (x_1 / x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a / x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x / x_1)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a / x_1) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:43:17: theorem udiv_common_divisor_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 then none else some (x_2 / x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x / x_1)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a / x_1) := by bv_compare'

theorem urem_common_divisor_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a % x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 then none else some (x_1 % x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a % x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x % x_1)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a % x_1) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:75:17: theorem urem_common_divisor_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 then none else some (x_2 % x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x % x_1)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a % x_1) := by bv_compare'

theorem sdiv_common_divisor_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 ∨ a = intMin 5 ∧ x = 31#5 then none else some (a.sdiv x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 ∨ x_1 = intMin 5 ∧ x = 31#5 then none else some (x_1.sdiv x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 ∨ a = intMin 5 ∧ x = 31#5 then none else some (a.sdiv x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 ∨ x = intMin 5 ∧ x_1 = 31#5 then none else some (x.sdiv x_1)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 ∨ a = intMin 5 ∧ x_1 = 31#5 then none else some (a.sdiv x_1) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:107:17: theorem sdiv_common_divisor_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 ∨ x_2 = intMin 5 ∧ x_1 = 31#5 then none else some (x_2.sdiv x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 ∨ x = intMin 5 ∧ x_1 = 31#5 then none else some (x.sdiv x_1)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 ∨ a = intMin 5 ∧ x_1 = 31#5 then none else some (a.sdiv x_1) := by bv_compare'

theorem srem_common_divisor_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a =>
        Option.map (fun div => a - div * x)
          (if x = 0#5 ∨ a = intMin 5 ∧ x = 31#5 then none else some (a.sdiv x)) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        Option.map (fun div => x_1 - div * x) (if x = 0#5 ∨ x_1 = intMin 5 ∧ x = 31#5 then none else some (x_1.sdiv x))
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a =>
        Option.map (fun div => a - div * x)
          (if x = 0#5 ∨ a = intMin 5 ∧ x = 31#5 then none else some (a.sdiv x)) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        Option.map (fun div => x - div * x_1)
          (if x_1 = 0#5 ∨ x = intMin 5 ∧ x_1 = 31#5 then none else some (x.sdiv x_1))) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a =>
        Option.map (fun div => a - div * x_1)
          (if x_1 = 0#5 ∨ a = intMin 5 ∧ x_1 = 31#5 then none else some (a.sdiv x_1)) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:139:17: theorem srem_common_divisor_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        Option.map (fun div => x_2 - div * x_1)
          (if x_1 = 0#5 ∨ x_2 = intMin 5 ∧ x_1 = 31#5 then none else some (x_2.sdiv x_1))
      | some { toFin := ⟨0, ⋯⟩ } =>
        Option.map (fun div => x - div * x_1)
          (if x_1 = 0#5 ∨ x = intMin 5 ∧ x_1 = 31#5 then none else some (x.sdiv x_1))) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a =>
        Option.map (fun div => a - div * x_1)
          (if x_1 = 0#5 ∨ a = intMin 5 ∧ x_1 = 31#5 then none else some (a.sdiv x_1)) := by bv_compare'

theorem udiv_common_divisor_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a / x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 then none else some (x_1 / x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a / x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x / x_1)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a / x_1) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:171:17: theorem udiv_common_divisor_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 then none else some (x_2 / x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x / x_1)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a / x_1) := by bv_compare'

theorem urem_common_divisor_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a % x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 then none else some (x_1 % x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => if x = 0#5 then none else some (a % x) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x % x_1)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a % x_1) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:203:17: theorem urem_common_divisor_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 then none else some (x_2 % x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x_1 = 0#5 then none else some (x % x_1)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => if x_1 = 0#5 then none else some (a % x_1) := by bv_compare'

theorem sdiv_common_dividend_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' => if y' = 0#5 ∨ x = intMin 5 ∧ y' = 31#5 then none else some (x.sdiv y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 ∨ x_1 = intMin 5 ∧ x = 31#5 then none else some (x_1.sdiv x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' => if y' = 0#5 ∨ x_1 = intMin 5 ∧ y' = 31#5 then none else some (x_1.sdiv y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#5 ∨ x_1 = intMin 5 ∧ x = 31#5 then none else some (x_1.sdiv x)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => if y' = 0#5 ∨ x_1 = intMin 5 ∧ y' = 31#5 then none else some (x_1.sdiv y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:235:17: theorem sdiv_common_dividend_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 ∨ x_2 = intMin 5 ∧ x_1 = 31#5 then none else some (x_2.sdiv x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#5 ∨ x_2 = intMin 5 ∧ x = 31#5 then none else some (x_2.sdiv x)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => if y' = 0#5 ∨ x_2 = intMin 5 ∧ y' = 31#5 then none else some (x_2.sdiv y') := by bv_compare'

theorem srem_common_dividend_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' =>
        Option.map (fun div => x - div * y')
          (if y' = 0#5 ∨ x = intMin 5 ∧ y' = 31#5 then none else some (x.sdiv y')) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        Option.map (fun div => x_1 - div * x) (if x = 0#5 ∨ x_1 = intMin 5 ∧ x = 31#5 then none else some (x_1.sdiv x))
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' =>
        Option.map (fun div => x_1 - div * y')
          (if y' = 0#5 ∨ x_1 = intMin 5 ∧ y' = 31#5 then none else some (x_1.sdiv y')) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        Option.map (fun div => x_1 - div * x)
          (if x = 0#5 ∨ x_1 = intMin 5 ∧ x = 31#5 then none else some (x_1.sdiv x))) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' =>
        Option.map (fun div => x_1 - div * y')
          (if y' = 0#5 ∨ x_1 = intMin 5 ∧ y' = 31#5 then none else some (x_1.sdiv y')) := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:267:17: theorem srem_common_dividend_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        Option.map (fun div => x_2 - div * x_1)
          (if x_1 = 0#5 ∨ x_2 = intMin 5 ∧ x_1 = 31#5 then none else some (x_2.sdiv x_1))
      | some { toFin := ⟨0, ⋯⟩ } =>
        Option.map (fun div => x_2 - div * x)
          (if x = 0#5 ∨ x_2 = intMin 5 ∧ x = 31#5 then none else some (x_2.sdiv x))) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' =>
        Option.map (fun div => x_2 - div * y')
          (if y' = 0#5 ∨ x_2 = intMin 5 ∧ y' = 31#5 then none else some (x_2.sdiv y')) := by bv_compare'

theorem udiv_common_dividend_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' => if y' = 0#5 then none else some (x / y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 then none else some (x_1 / x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' => if y' = 0#5 then none else some (x_1 / y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#5 then none else some (x_1 / x)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => if y' = 0#5 then none else some (x_1 / y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:299:17: theorem udiv_common_dividend_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 then none else some (x_2 / x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#5 then none else some (x_2 / x)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => if y' = 0#5 then none else some (x_2 / y') := by bv_compare'

theorem urem_common_dividend_defined_cond_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  ∀ (x : BitVec 5) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' => if y' = 0#5 then none else some (x % y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x = 0#5 then none else some (x_1 % x)
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun y' => if y' = 0#5 then none else some (x_1 % y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  BitVec 5 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#5 then none else some (x_1 % x)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => if y' = 0#5 then none else some (x_1 % y') := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  BitVec 5 →
    BitVec 5 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthdivrem.lean:331:17: theorem urem_common_dividend_defined_cond_thm :
  ∀ (x x_1 x_2 : BitVec 5) (x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x_1 = 0#5 then none else some (x_2 % x_1)
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#5 then none else some (x_2 % x)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => if y' = 0#5 then none else some (x_2 % y') := by bv_compare'

