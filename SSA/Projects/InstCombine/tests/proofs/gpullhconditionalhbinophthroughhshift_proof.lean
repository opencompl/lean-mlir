
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gpullhconditionalhbinophthroughhshift_proof
theorem and_signbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:48:17: theorem and_signbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x &&& 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 &&& 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem and_nosignbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:85:17: theorem and_nosignbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x &&& 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 &&& 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem or_signbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:122:17: theorem or_signbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 ||| 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem or_nosignbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:159:17: theorem or_nosignbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 ||| 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem xor_signbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:196:17: theorem xor_signbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ^^^ 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 ^^^ 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem xor_nosignbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:233:17: theorem xor_nosignbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ^^^ 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 ^^^ 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem add_signbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:270:17: theorem add_signbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x + 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 + 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem add_nosignbit_select_shl_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' <<< 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:307:17: theorem add_nosignbit_select_shl_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x + 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' <<< 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x <<< 8 + 4278190080#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x <<< 8) := by bv_compare'

theorem and_signbit_select_lshr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' >>> 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:344:17: theorem and_signbit_select_lshr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x &&& 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' >>> 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x >>> 8 &&& 16776960#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x >>> 8) := by bv_compare'

theorem and_nosignbit_select_lshr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' >>> 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:381:17: theorem and_nosignbit_select_lshr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x &&& 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' >>> 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x >>> 8 &&& 8388352#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x >>> 8) := by bv_compare'

theorem or_signbit_select_lshr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' >>> 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:418:17: theorem or_signbit_select_lshr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' >>> 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x >>> 8 ||| 16776960#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x >>> 8) := by bv_compare'

theorem or_nosignbit_select_lshr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' >>> 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:455:17: theorem or_nosignbit_select_lshr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' >>> 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x >>> 8 ||| 8388352#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x >>> 8) := by bv_compare'

theorem xor_signbit_select_lshr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' >>> 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:492:17: theorem xor_signbit_select_lshr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ^^^ 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' >>> 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x >>> 8 ^^^ 16776960#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x >>> 8) := by bv_compare'

theorem xor_nosignbit_select_lshr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x' >>> 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:529:17: theorem xor_nosignbit_select_lshr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ^^^ 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x' >>> 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x >>> 8 ^^^ 8388352#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x >>> 8) := by bv_compare'

theorem and_signbit_select_ashr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x'.sshiftRight 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:566:17: theorem and_signbit_select_ashr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x &&& 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x'.sshiftRight 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 8 &&& 4294967040#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x.sshiftRight 8) := by bv_compare'

theorem and_nosignbit_select_ashr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x'.sshiftRight 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:603:17: theorem and_nosignbit_select_ashr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x &&& 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x'.sshiftRight 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 8 &&& 8388352#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x.sshiftRight 8) := by bv_compare'

theorem or_signbit_select_ashr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x'.sshiftRight 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:640:17: theorem or_signbit_select_ashr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x'.sshiftRight 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 8 ||| 4294967040#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x.sshiftRight 8) := by bv_compare'

theorem or_nosignbit_select_ashr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x'.sshiftRight 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:677:17: theorem or_nosignbit_select_ashr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x'.sshiftRight 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 8 ||| 8388352#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x.sshiftRight 8) := by bv_compare'

theorem xor_signbit_select_ashr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x'.sshiftRight 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:714:17: theorem xor_signbit_select_ashr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ^^^ 4294901760#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x'.sshiftRight 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 8 ^^^ 4294967040#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x.sshiftRight 8) := by bv_compare'

theorem xor_nosignbit_select_ashr_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun x' => some (x'.sshiftRight 8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gpullhconditionalhbinophthroughhshift.lean:751:17: theorem xor_nosignbit_select_ashr_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (x ^^^ 2147418112#32)
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun x' => some (x'.sshiftRight 8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 8 ^^^ 8388352#32)
      | some { toFin := ⟨0, ⋯⟩ } => some (x.sshiftRight 8) := by bv_compare'

