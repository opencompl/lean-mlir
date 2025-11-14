import Blase
set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
set_option warn.sorry false
set_option linter.all false
set_option linter.unusedSimpArgs false
open BitVec


notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x
notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y

notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x
notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)


theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64), zeroExtend 64 (truncate 32 x) = x &&& 4294967295#64 := by sorry -- bv_multi_width


theorem different_size_sext_sext_eq_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x_1 == signExtend 25 x) = ofBool (x_1 == signExtend 7 x) :=
      by sorry -- bv_generalize ; bv_multi_width +verbose?

theorem different_size_sext_sext_sgt_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x <ₛ signExtend 25 x_1) = ofBool (signExtend 7 x <ₛ x_1) := by
    -- simp only [bv_multi_width_normalize]
    -- bv_multi_width_normalize
    -- bv_multi_width +verbose?
    sorry
theorem different_size_sext_sext_sle_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x_1 ≤ₛ signExtend 25 x) = ofBool (x_1 ≤ₛ signExtend 7 x) :=
      by bv_generalize; sorry -- bv_multi_width -- timeout?
theorem different_size_sext_sext_ule_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x_1 ≤ᵤ signExtend 25 x) = ofBool (x_1 ≤ᵤ signExtend 7 x) :=
      by sorry -- bv_generalize; bv_multi_width
theorem different_size_zext_zext_eq_thm.extracted_1._1 : ∀ (x : BitVec 7) (x_1 : BitVec 4),
  ofBool (zeroExtend 25 x_1 == zeroExtend 25 x) = ofBool (x == zeroExtend 7 x_1) :=
      by bv_generalize ; bv_multi_width
theorem different_size_zext_zext_ne_commute_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (zeroExtend 25 x_1 != zeroExtend 25 x) = ofBool (x_1 != zeroExtend 7 x) :=
      by bv_generalize ; bv_multi_width
theorem different_size_zext_zext_sgt_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (zeroExtend 25 x <ₛ zeroExtend 25 x_1) = ofBool (zeroExtend 7 x <ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem different_size_zext_zext_slt_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (zeroExtend 25 x_1 <ₛ zeroExtend 25 x) = ofBool (x_1 <ᵤ zeroExtend 7 x) :=
      by bv_generalize ; bv_multi_width
theorem different_size_zext_zext_ugt_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (zeroExtend 25 x <ᵤ zeroExtend 25 x_1) = ofBool (zeroExtend 7 x <ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem different_size_zext_zext_ult_thm.extracted_1._1 : ∀ (x : BitVec 7) (x_1 : BitVec 4),
  ofBool (zeroExtend 25 x_1 <ᵤ zeroExtend 25 x) = ofBool (zeroExtend 7 x_1 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem gt_signed_to_large_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 32 (-1024) <ₛ signExtend 32 x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem gt_signed_to_large_signed_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (1024#32 <ₛ signExtend 32 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem gt_signed_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (1024#32 <ᵤ signExtend 32 x) = ofBool (x <ₛ 0#8) :=
      by bv_generalize ; bv_multi_width
theorem gt_signed_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 32 (-17) <ₛ signExtend 32 x) = ofBool (BitVec.ofInt 8 (-17) <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem gt_signed_to_small_signed_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (17#32 <ₛ signExtend 32 x) = ofBool (17#8 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem gt_signed_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (17#32 <ᵤ signExtend 32 x) = ofBool (17#8 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem gt_unsigned_to_large_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 32 (-1024) <ₛ zeroExtend 32 x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem gt_unsigned_to_large_signed_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (1024#32 <ₛ zeroExtend 32 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem gt_unsigned_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (1024#32 <ᵤ zeroExtend 32 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem gt_unsigned_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 32 (-17) <ₛ zeroExtend 32 x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem gt_unsigned_to_small_signed_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (17#32 <ₛ zeroExtend 32 x) = ofBool (17#8 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem gt_unsigned_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (17#32 <ᵤ zeroExtend 32 x) = ofBool (17#8 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem lt_signed_to_large_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ₛ BitVec.ofInt 32 (-1024)) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem lt_signed_to_large_signed_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (signExtend 32 x <ₛ 1024#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem lt_signed_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ᵤ 1024#32) = ofBool (-1#8 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem lt_signed_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ₛ BitVec.ofInt 32 (-17)) = ofBool (x <ₛ BitVec.ofInt 8 (-17)) :=
      by bv_generalize ; bv_multi_width
theorem lt_signed_to_small_signed_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ₛ 17#32) = ofBool (x <ₛ 17#8) :=
      by bv_generalize ; bv_multi_width
theorem lt_signed_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ᵤ 17#32) = ofBool (x <ᵤ 17#8) :=
      by bv_generalize ; bv_multi_width
theorem lt_unsigned_to_large_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ BitVec.ofInt 32 (-1024)) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem lt_unsigned_to_large_signed_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (zeroExtend 32 x <ₛ 1024#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem lt_unsigned_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ᵤ 1024#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem lt_unsigned_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ BitVec.ofInt 32 (-17)) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem lt_unsigned_to_small_signed_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ 17#32) = ofBool (x <ᵤ 17#8) :=
      by bv_generalize ; bv_multi_width
theorem lt_unsigned_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ᵤ 17#32) = ofBool (x <ᵤ 17#8) :=
      by bv_generalize ; bv_multi_width
theorem test_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 → ¬7#8 ≥ ↑8 → (signExtend 32 x).sshiftRight' 8#32 = signExtend 32 (x.sshiftRight' 7#8) :=
      by bv_generalize ; bv_multi_width
theorem test_thm.extracted_1._1 : zeroExtend 32 (ofBool (1#32 == 2#32)) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem eq_signed_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x == 17#32) = ofBool (x == 17#8) :=
      by bv_generalize ; bv_multi_width
theorem foo_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  zeroExtend 64 (truncate 32 x_1 &&& truncate 32 x) = x_1 &&& x &&& 4294967295#64 :=
      by bv_generalize ; bv_multi_width
theorem test_thm.extracted_1._1_1 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem test_thm.extracted_1._1_1 : ∀ (x x_1 : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ zeroExtend 32 x_1) = ofBool (x <ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem test_thm.extracted_1._1_1 : ∀ (x : BitVec 31),
  ¬15#32 ≥ ↑32 → True ∧ (zeroExtend 32 x).uaddOverflow 16384#32 = true ∨ 15#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem test_thm.extracted_1._2 : ∀ (x : BitVec 31),
  ¬15#32 ≥ ↑32 →
    ¬(True ∧ (zeroExtend 32 x).uaddOverflow 16384#32 = true ∨ 15#32 ≥ ↑32) →
      truncate 16 ((signExtend 32 x + 16384#32) >>> 15#32) = truncate 16 ((zeroExtend 32 x + 16384#32) >>> 15#32) :=
      by bv_generalize ; bv_multi_width
-- | TODO: -2^32 - 1 (twoPow more generally)
-- TODO: saddOveflow
theorem test_thm.extracted_1._1_1_1 : ∀ (x x_1 : BitVec 16),
  True ∧ (signExtend 32 x_1).saddOverflow (signExtend 32 x) = true → False :=
      by bv_generalize ; simp [saddOverflow]; bv_multi_width
theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬8#32 ≥ ↑32 →
    ¬8#16 ≥ ↑16 → truncate 16 (zeroExtend 32 x >>> 8#32 ||| zeroExtend 32 x * 5#32) = x >>> 8#16 ||| x * 5#16 :=
      by bv_generalize ; bv_multi_width
-- abstracted boolean: 
-- TODO: → 'setWidth w✝ x✝ <ₛ 1#w✝'
theorem PR2539_A_thm.extracted_1._1_1 : ∀ (x : BitVec 1), ofBool (zeroExtend 32 x <ₛ 1#32) = x ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width +verbose?
theorem main_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) → 5#8 ≥ ↑8 ∨ True ∧ ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem main_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(5#8 ≥ ↑8 ∨ True ∧ ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8).msb = true) →
      zeroExtend 32
          (((truncate 8 x ||| BitVec.ofInt 8 (-17)) ^^^
                ((truncate 8 x &&& 122#8 ^^^ BitVec.ofInt 8 (-17)) <<< 6#8 ^^^
                  (truncate 8 x &&& 122#8 ^^^ BitVec.ofInt 8 (-17)))) >>>
              7#8 *
            64#8) =
        zeroExtend 32 ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8) :=
      by bv_generalize ; bv_multi_width
-- TODO: intMin
theorem test_thm.extracted_1._1' : ∀ (x : BitVec 64),
  ¬(-1#32 == 0 || 32 != 1 && truncate 32 (x ||| 4294967294#64) == intMin 32 && -1#32 == -1) = true →
    (truncate 32 (x ||| 4294967294#64)).srem (-1#32) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem f1_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 8 x != 0#8) = 1#1 →
    ofBool (x &&& 16711680#32 != 0#32) = ofBool (truncate 8 x != 0#8) &&& ofBool (x &&& 16711680#32 != 0#32) :=
      by bv_generalize ; sorry -- bv_multi_width
-- TODO: decide
theorem f1_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 8 x != 0#8) = 1#1 → 0#1 = ofBool (truncate 8 x != 0#8) &&& ofBool (x &&& 16711680#32 != 0#32) :=
      by bv_generalize ; sorry -- bv_multi_width
theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 → zeroExtend 64 x_1 <<< 32#64 + x &&& 123#64 = x &&& 123#64 :=
      by bv_generalize ; bv_multi_width
theorem and1_shl1_is_cmp_eq_0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → 1#8 <<< x &&& 1#8 = zeroExtend 8 (ofBool (x == 0#8)) :=
      by bv_generalize ; bv_multi_width
theorem and_sext_multiuse_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (x_2 <ₛ x_3) = 1#1 →
    (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x_1) + (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x) = x_1 + x :=
      by bv_generalize ; bv_multi_width
theorem and_sext_multiuse_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_2 <ₛ x_3) = 1#1 →
    (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x_1) + (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem and_zext_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → zeroExtend 32 x_1 &&& x = x &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem and_zext_commuted_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → zeroExtend 32 x_1 &&& x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem and_zext_demanded_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬8#16 ≥ ↑16 →
    ¬(8#16 ≥ ↑16 ∨ True ∧ (x >>> 8#16).msb = true) →
      (x_1 ||| 255#32) &&& zeroExtend 32 (x >>> 8#16) = zeroExtend 32 (x >>> 8#16) :=
      by bv_generalize ; bv_multi_width
theorem and_zext_eq_even_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x == 2#32)) &&& x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem and_zext_eq_even_thm.extracted_1._1 : ∀ (x : BitVec 32), x &&& zeroExtend 32 (ofBool (x == 2#32)) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem and_zext_eq_odd_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x == 3#32)) &&& x = zeroExtend 32 (ofBool (x == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem and_zext_eq_odd_thm.extracted_1._1 : ∀ (x : BitVec 32),
  x &&& zeroExtend 32 (ofBool (x == 3#32)) = zeroExtend 32 (ofBool (x == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem and_zext_eq_zero_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (x_1 == 0#32)) &&& (x_1 >>> x ^^^ -1#32) = zeroExtend 32 (ofBool (x_1 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem and_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  x = 1#1 → x_1 &&& zeroExtend 32 x = x_1 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem and_zext_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 : BitVec 32), ¬x = 1#1 → x_1 &&& zeroExtend 32 x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem invert_signbit_splat_mask_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (-1#8 <ₛ x_1) = 1#1 → signExtend 16 (x_1.sshiftRight' 7#8 ^^^ -1#8) &&& x = x :=
      by bv_generalize ; bv_multi_width
theorem invert_signbit_splat_mask_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ¬ofBool (-1#8 <ₛ x_1) = 1#1 → signExtend 16 (x_1.sshiftRight' 7#8 ^^^ -1#8) &&& x = 0#16 :=
      by bv_generalize ; bv_multi_width
theorem lowbitmask_casted_shift_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → ¬1#32 ≥ ↑32 → signExtend 32 (x.sshiftRight' 1#8) &&& 2147483647#32 = signExtend 32 x >>> 1#32 :=
      by bv_generalize ; bv_multi_width
theorem lowmask_add_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  x_1 * x_1 + zeroExtend 32 x &&& 65535#32 = zeroExtend 32 (x + truncate 16 (x_1 * x_1)) :=
      by bv_generalize ; bv_multi_width
theorem lowmask_add_zext_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  zeroExtend 32 x_1 + x &&& 255#32 = zeroExtend 32 (x_1 + truncate 8 x) :=
      by bv_generalize ; bv_multi_width
theorem lowmask_add_zext_wrong_mask_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  zeroExtend 32 x_1 + x &&& 511#32 = x + zeroExtend 32 x_1 &&& 511#32 :=
      by bv_generalize ; bv_multi_width
theorem lowmask_mul_zext_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  zeroExtend 32 x_1 * x &&& 255#32 = zeroExtend 32 (x_1 * truncate 8 x) :=
      by bv_generalize ; bv_multi_width
theorem lowmask_or_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 24),
  (x_1 ||| zeroExtend 24 x) &&& 65535#24 = zeroExtend 24 (x ||| truncate 16 x_1) :=
      by bv_generalize ; bv_multi_width
theorem lowmask_sub_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 5) (x_1 : BitVec 17),
  x_1 - zeroExtend 17 x &&& 31#17 = zeroExtend 17 (truncate 5 x_1 - x) :=
      by bv_generalize ; bv_multi_width
theorem lowmask_xor_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  (x_1 * x_1 ^^^ zeroExtend 32 x) &&& 255#32 = zeroExtend 32 (x ^^^ truncate 8 (x_1 * x_1)) :=
      by bv_generalize ; bv_multi_width
theorem not_invert_signbit_splat_mask1_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 →
    zeroExtend 16 (x_1.sshiftRight' 7#8 ^^^ -1#8) &&& x = x &&& zeroExtend 16 (signExtend 8 (ofBool (-1#8 <ₛ x_1))) :=
      by bv_generalize ; bv_multi_width
theorem not_invert_signbit_splat_mask2_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬6#8 ≥ ↑8 →
    signExtend 16 (x_1.sshiftRight' 6#8 ^^^ -1#8) &&& x = x &&& signExtend 16 (x_1.sshiftRight' 6#8 ^^^ -1#8) :=
      by bv_generalize ; bv_multi_width
theorem not_signbit_splat_mask1_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → zeroExtend 16 (x_1.sshiftRight' 7#8) &&& x = x &&& zeroExtend 16 (x_1.sshiftRight' 7#8) :=
      by bv_generalize ; bv_multi_width
theorem not_signbit_splat_mask2_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬6#8 ≥ ↑8 → signExtend 16 (x_1.sshiftRight' 6#8) &&& x = x &&& signExtend 16 (x_1.sshiftRight' 6#8) :=
      by bv_generalize ; bv_multi_width
theorem signbit_splat_mask_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1 <ₛ 0#8) = 1#1 → signExtend 16 (x_1.sshiftRight' 7#8) &&& x = x :=
      by bv_generalize ; bv_multi_width
theorem signbit_splat_mask_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ¬ofBool (x_1 <ₛ 0#8) = 1#1 → signExtend 16 (x_1.sshiftRight' 7#8) &&& x = 0#16 :=
      by bv_generalize ; bv_multi_width
theorem test29_thm.extracted_1._1 : ∀ (x : BitVec 8), zeroExtend 32 x &&& 255#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test30_thm.extracted_1._1 : ∀ (x : BitVec 1), zeroExtend 32 x &&& 1#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test31_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬4#32 ≥ ↑32 → x = 1#1 → zeroExtend 32 x <<< 4#32 &&& 16#32 = 16#32 :=
      by bv_generalize ; bv_multi_width
theorem test31_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬4#32 ≥ ↑32 → ¬x = 1#1 → zeroExtend 32 x <<< 4#32 &&& 16#32 = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem test35_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (0#32 - x &&& 240#32).msb = true) →
    0#64 - zeroExtend 64 x &&& 240#64 = zeroExtend 64 (0#32 - x &&& 240#32) :=
      by bv_generalize ; bv_multi_width
theorem test36_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (x + 7#32 &&& 240#32).msb = true) →
    zeroExtend 64 x + 7#64 &&& 240#64 = zeroExtend 64 (x + 7#32 &&& 240#32) :=
      by bv_generalize ; bv_multi_width
theorem test37_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (x * 7#32 &&& 240#32).msb = true) →
    zeroExtend 64 x * 7#64 &&& 240#64 = zeroExtend 64 (x * 7#32 &&& 240#32) :=
      by bv_generalize ; bv_multi_width
theorem test38_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 240#32).msb = true) → (zeroExtend 64 x ^^^ 7#64) &&& 240#64 = zeroExtend 64 (x &&& 240#32) :=
      by bv_generalize ; bv_multi_width
theorem test39_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 240#32).msb = true) → (zeroExtend 64 x ||| 7#64) &&& 240#64 = zeroExtend 64 (x &&& 240#32) :=
      by bv_generalize ; bv_multi_width
theorem test_with_1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → 1#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_with_3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → 3#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_with_5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → 5#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_with_neg_5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → BitVec.ofInt 32 (-5) <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem zext_add_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 16 x + 44#16 &&& zeroExtend 16 x = zeroExtend 16 (x + 44#8 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem zext_ashr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬2#16 ≥ ↑16 →
    ¬(2#8 ≥ ↑8 ∨ True ∧ (x >>> 2#8 &&& x).msb = true) →
      (zeroExtend 16 x).sshiftRight' 2#16 &&& zeroExtend 16 x = zeroExtend 16 (x >>> 2#8 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem zext_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 →
    ¬(4#8 ≥ ↑8 ∨ True ∧ (x >>> 4#8 &&& x).msb = true) →
      zeroExtend 16 x >>> 4#16 &&& zeroExtend 16 x = zeroExtend 16 (x >>> 4#8 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem zext_mul_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 16 x * 3#16 &&& zeroExtend 16 x = zeroExtend 16 (x * 3#8 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem zext_shl_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#16 ≥ ↑16 → ¬3#8 ≥ ↑8 → zeroExtend 16 x <<< 3#16 &&& zeroExtend 16 x = zeroExtend 16 (x <<< 3#8 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem zext_sub_thm.extracted_1._1 : ∀ (x : BitVec 8),
  BitVec.ofInt 16 (-5) - zeroExtend 16 x &&& zeroExtend 16 x = zeroExtend 16 (BitVec.ofInt 8 (-5) - x &&& x) :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  (x_1 ||| zeroExtend 32 x) &&& 65536#32 = x_1 &&& 65536#32 :=
      by bv_generalize ; bv_multi_width
theorem ashr_and_icmp_sge_neg1_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → x.sshiftRight' 63#64 &&& zeroExtend 64 (ofBool (-1#64 ≤ₛ x)) = zeroExtend 64 (ofBool (x == -1#64)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_ne_neg2_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 &&& zeroExtend 32 (ofBool (x != BitVec.ofInt 32 (-2))) =
      zeroExtend 32 (ofBool (x <ₛ 0#32) &&& ofBool (x != BitVec.ofInt 32 (-2))) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_sge_neg1_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → x >>> 31#32 &&& zeroExtend 32 (ofBool (-1#32 <ₛ x)) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_sge_neg1_i64_fail_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    ofBool (BitVec.ofInt 64 (-2) <ₛ x) = 1#1 →
      x >>> 62#64 &&& zeroExtend 64 (ofBool (-1#64 ≤ₛ x)) = x >>> 62#64 &&& 1#64 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_sge_neg1_i64_fail_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    ¬ofBool (BitVec.ofInt 64 (-2) <ₛ x) = 1#1 → x >>> 62#64 &&& zeroExtend 64 (ofBool (-1#64 ≤ₛ x)) = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_sge_neg1_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → x >>> 63#64 &&& zeroExtend 64 (ofBool (-1#64 ≤ₛ x)) = zeroExtend 64 (ofBool (x == -1#64)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_sge_neg2_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    x >>> 63#64 &&& zeroExtend 64 (ofBool (BitVec.ofInt 64 (-2) ≤ₛ x)) =
      zeroExtend 64 (ofBool (BitVec.ofInt 64 (-3) <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_and_icmp_sgt_neg1_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → x >>> 63#64 &&& zeroExtend 64 (ofBool (-1#64 <ₛ x)) = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 ||| zeroExtend 32 (ofBool (100#32 ≤ₛ x + 1#32)) =
      zeroExtend 32 (ofBool (x <ₛ 0#32) ||| ofBool (99#32 <ₛ x + 1#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_eq_100_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 ||| zeroExtend 32 (ofBool (x == 100#32)) =
      zeroExtend 32 (ofBool (x <ₛ 0#32) ||| ofBool (x == 100#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_sge_100_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → x >>> 31#32 ||| zeroExtend 32 (ofBool (100#32 ≤ₛ x)) = zeroExtend 32 (ofBool (99#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_sge_neg1_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → x >>> 31#32 ||| zeroExtend 32 (ofBool (-1#32 ≤ₛ x)) = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_sgt_0_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x <ₛ 0#32)) ||| zeroExtend 32 (ofBool (0#32 <ₛ x)) = zeroExtend 32 (ofBool (x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_sgt_0_i64_fail0_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → x >>> 63#64 ||| zeroExtend 64 (ofBool (x <ₛ 0#64)) = x >>> 63#64 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_sgt_0_i64_fail3_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    ¬(62#64 ≥ ↑64 ∨ 63#64 ≥ ↑64) →
      x.sshiftRight' 62#64 ||| zeroExtend 64 (ofBool (x <ₛ 0#64)) = x.sshiftRight' 62#64 ||| x >>> 63#64 :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_or_icmp_sgt_0_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  zeroExtend 64 (ofBool (x <ₛ 0#64)) ||| zeroExtend 64 (ofBool (0#64 <ₛ x)) = zeroExtend 64 (ofBool (x != 0#64)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_xor_icmp_sge_neg2_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 ^^^ zeroExtend 32 (ofBool (BitVec.ofInt 32 (-2) ≤ₛ x)) =
      zeroExtend 32 (ofBool (x <ᵤ BitVec.ofInt 32 (-2))) :=
      by bv_generalize ; bv_multi_width
theorem icmp_slt_0_xor_icmp_sgt_neg2_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 ^^^ zeroExtend 32 (ofBool (BitVec.ofInt 32 (-2) <ₛ x)) = zeroExtend 32 (ofBool (x != -1#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x_1 >>> 31#32 &&& zeroExtend 32 (ofBool (x != BitVec.ofInt 32 (-2))) =
      zeroExtend 32 (ofBool (x_1 <ₛ 0#32) &&& ofBool (x != BitVec.ofInt 32 (-2))) :=
      by bv_generalize ; bv_multi_width
theorem icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x_1 >>> 31#32 &&& zeroExtend 32 (ofBool (-1#32 <ₛ x)) =
      zeroExtend 32 (ofBool (x_1 <ₛ 0#32) &&& ofBool (-1#32 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 → x_1 >>> 31#32 ^^^ zeroExtend 32 (ofBool (-1#32 <ₛ x)) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
      by bv_generalize ; bv_multi_width
theorem PR38781_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) →
    (x_1 >>> 31#32 ^^^ 1#32) &&& (x >>> 31#32 ^^^ 1#32) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem PR56294_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 (ofBool (x == 2#8)) &&& zeroExtend 32 (x &&& 1#8) != 0#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem and_sext_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 4),
  signExtend 16 x_1 &&& signExtend 16 x = signExtend 16 (x &&& signExtend 8 x_1) :=
      by bv_generalize ; bv_multi_width
theorem and_zext_zext_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  True ∧ (x_1 &&& zeroExtend 8 x).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem and_zext_zext_thm.extracted_1._2 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  ¬(True ∧ (x_1 &&& zeroExtend 8 x).msb = true) →
    zeroExtend 16 x_1 &&& zeroExtend 16 x = zeroExtend 16 (x_1 &&& zeroExtend 8 x) :=
      by bv_generalize ; bv_multi_width
theorem or_sext_sext_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  signExtend 16 x_1 ||| signExtend 16 x = signExtend 16 (x_1 ||| signExtend 8 x) :=
      by bv_generalize ; bv_multi_width
theorem or_zext_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 4),
  zeroExtend 16 x_1 ||| zeroExtend 16 x = zeroExtend 16 (x ||| zeroExtend 8 x_1) :=
      by bv_generalize ; bv_multi_width
theorem xor_sext_sext_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  signExtend 16 x_1 ^^^ signExtend 16 x = signExtend 16 (x_1 ^^^ signExtend 8 x) :=
      by bv_generalize ; bv_multi_width
theorem sext_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true ∨
        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == 0 ||
              7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 &&
                zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == -1) =
            true ∨
          (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
              4 != 1 &&
                  truncate 4
                      ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8))) ==
                    intMin 4 &&
                x ^^^ BitVec.ofInt 4 (-8) == -1) =
            true) →
    (signExtend 7 x == 0 || 7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 && signExtend 7 x == -1) =
          true ∨
        (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
            4 != 1 && truncate 4 ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv (signExtend 7 x)) == intMin 4 &&
              x ^^^ BitVec.ofInt 4 (-8) == -1) =
          true →
      False :=
      by bv_generalize ; bv_multi_width
theorem sext_multiuse_thm.extracted_1._2 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true ∨
        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == 0 ||
              7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 &&
                zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == -1) =
            true ∨
          (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
              4 != 1 &&
                  truncate 4
                      ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8))) ==
                    intMin 4 &&
                x ^^^ BitVec.ofInt 4 (-8) == -1) =
            true) →
    ¬((signExtend 7 x == 0 || 7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 && signExtend 7 x == -1) =
            true ∨
          (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
              4 != 1 && truncate 4 ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv (signExtend 7 x)) == intMin 4 &&
                x ^^^ BitVec.ofInt 4 (-8) == -1) =
            true) →
      (truncate 4
              ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8)))).sdiv
          (x ^^^ BitVec.ofInt 4 (-8)) =
        (truncate 4 ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv (signExtend 7 x))).sdiv
          (x ^^^ BitVec.ofInt 4 (-8)) :=
      by bv_generalize ; bv_multi_width
theorem sext_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true) →
    zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) = signExtend 7 x :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 17),
  ¬(8#37 ≥ ↑37 ∨ 8#37 ≥ ↑37) →
    ¬(8#17 ≥ ↑17 ∨ 8#17 ≥ ↑17) →
      truncate 17 (zeroExtend 37 x >>> 8#37 ||| zeroExtend 37 x <<< 8#37) = x >>> 8#17 ||| x <<< 8#17 :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 167),
  ¬(9#577 ≥ ↑577 ∨ 8#577 ≥ ↑577) →
    ¬(9#167 ≥ ↑167 ∨ 8#167 ≥ ↑167) →
      truncate 167 (zeroExtend 577 x >>> 9#577 ||| zeroExtend 577 x <<< 8#577) = x >>> 9#167 ||| x <<< 8#167 :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 61), zeroExtend 61 (truncate 41 x) = x &&& 2199023255551#61 :=
      by bv_generalize ; bv_multi_width
theorem not_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 0#999 = signExtend 999 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem not_sext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → -1#999 = signExtend 999 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem not_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 0#999 = zeroExtend 999 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem not_zext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#999 = zeroExtend 999 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem sext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → -1#41 = signExtend 41 x :=
      by bv_generalize ; bv_multi_width
theorem sext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 0#41 = signExtend 41 x :=
      by bv_generalize ; bv_multi_width
theorem zext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 1#41 = zeroExtend 41 x :=
      by bv_generalize ; bv_multi_width
theorem zext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 0#41 = zeroExtend 41 x :=
      by bv_generalize ; bv_multi_width
theorem test15a_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬zeroExtend 53 3#8 ≥ ↑53 → 64#53 <<< zeroExtend 53 3#8 = 512#53 :=
      by bv_generalize ; bv_multi_width
theorem test15a_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬zeroExtend 53 1#8 ≥ ↑53 → 64#53 <<< zeroExtend 53 1#8 = 128#53 :=
      by bv_generalize ; bv_multi_width
theorem test23_thm.extracted_1._1 : ∀ (x : BitVec 44),
  ¬(33#44 ≥ ↑44 ∨ 33#44 ≥ ↑44) → truncate 11 ((x <<< 33#44).sshiftRight' 33#44) = truncate 11 x :=
      by bv_generalize ; bv_multi_width
theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬zeroExtend 29 x ≥ ↑29 → (-1#29).sshiftRight' (zeroExtend 29 x) = -1#29 :=
      by bv_generalize ; bv_multi_width
theorem ashr_can_be_lshr_2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(34#64 ≥ ↑64 ∨
        True ∧
            (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 >>> 32#64 <<< 32#64 ≠
              (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 ∨
          32#64 ≥ ↑64 ∨
            True ∧
              signExtend 64 (truncate 32 (((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64)) ≠
                ((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64) →
    2#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem ashr_can_be_lshr_2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(34#64 ≥ ↑64 ∨
        True ∧
            (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 >>> 32#64 <<< 32#64 ≠
              (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 ∨
          32#64 ≥ ↑64 ∨
            True ∧
              signExtend 64 (truncate 32 (((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64)) ≠
                ((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64) →
    ¬2#32 ≥ ↑32 →
      truncate 32 (((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64) =
        x <<< 2#32 ||| BitVec.ofInt 32 (-67108864) :=
      by bv_generalize ; bv_multi_width
theorem ashr_can_be_lshr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨
        16#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 16 (x.sshiftRight' 16#32)) ≠ x.sshiftRight' 16#32) →
    True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨ 16#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 16 (x >>> 16#32)) ≠ x >>> 16#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem ashr_can_be_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨
        16#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 16 (x.sshiftRight' 16#32)) ≠ x.sshiftRight' 16#32) →
    ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨ 16#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 16 (x >>> 16#32)) ≠ x >>> 16#32) →
      truncate 16 (x.sshiftRight' 16#32) = truncate 16 (x >>> 16#32) :=
      by bv_generalize ; bv_multi_width
theorem ashr_sub_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 17),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 16#17 ≥ ↑17) →
    (x_1 - x).sshiftRight' 16#17 = signExtend 17 (ofBool (x_1 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem lsb_mask_sign_sext_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ((x ^^^ -1#32) &&& x + -1#32).sshiftRight' 31#32 = signExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem lsb_mask_sign_sext_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (x + -1#32 &&& (x ^^^ -1#32)).sshiftRight' 31#32 = signExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem lsb_mask_sign_zext_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ((x ^^^ -1#32) &&& x + -1#32) >>> 31#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem lsb_mask_sign_zext_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (x + -1#32 &&& (x ^^^ -1#32)) >>> 31#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem lshr_sub_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 31#32 ≥ ↑32) → (x_1 - x) >>> 31#32 = zeroExtend 32 (ofBool (x_1 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem AndZextAnd_thm.extracted_1._2 : ∀ (x : BitVec 3),
  ¬(True ∧ (x &&& 2#3).msb = true) → zeroExtend 5 (x &&& 3#3) &&& 14#5 = zeroExtend 5 (x &&& 2#3) :=
      by bv_generalize ; bv_multi_width
theorem OrZextOr_thm.extracted_1._1 : ∀ (x : BitVec 3), zeroExtend 5 (x ||| 3#3) ||| 8#5 = zeroExtend 5 x ||| 11#5 :=
      by bv_generalize ; bv_multi_width
theorem XorZextXor_thm.extracted_1._1 : ∀ (x : BitVec 3), zeroExtend 5 (x ^^^ 3#3) ^^^ 12#5 = zeroExtend 5 x ^^^ 15#5 :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (x &&& 32767#16).msb = true) →
    zeroExtend 24 (x &&& 32767#16) &&& 8388607#24 = zeroExtend 24 (x &&& 32767#16) :=
      by bv_generalize ; bv_multi_width
theorem and_add_bool_to_select_multi_use_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → (-1#32 + zeroExtend 32 x_1 &&& x) + (-1#32 + zeroExtend 32 x_1) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem and_add_bool_to_select_multi_use_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → (-1#32 + zeroExtend 32 x_1 &&& x) + (-1#32 + zeroExtend 32 x_1) = x + -1#32 :=
      by bv_generalize ; bv_multi_width
theorem and_add_bool_to_select_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → -1#32 + zeroExtend 32 x_1 &&& x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem and_add_bool_to_select_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → -1#32 + zeroExtend 32 x_1 &&& x = x :=
      by bv_generalize ; bv_multi_width
theorem and_sext_to_sel_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 32 x_1 &&& x = x :=
      by bv_generalize ; bv_multi_width
theorem and_sext_to_sel_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 32 x_1 &&& x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem or_sext_to_sel_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 32 x_1 ||| x = -1#32 :=
      by bv_generalize ; bv_multi_width
theorem or_sext_to_sel_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 32 x_1 ||| x = x :=
      by bv_generalize ; bv_multi_width
theorem xor_sext_to_sel_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  signExtend 32 x_1 ^^^ x = x ^^^ signExtend 32 x_1 :=
      by bv_generalize ; bv_multi_width
theorem and_sel_op0_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 25#32 &&& 1#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem and_sel_op0_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 0#32 &&& 1#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem sub_sel_op1_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬(True ∧ (42#32).ssubOverflow 42#32 = true) → 42#32 - 42#32 = zeroExtend 32 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem sub_sel_op1_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬(True ∧ (42#32).ssubOverflow 41#32 = true) → 42#32 - 41#32 = zeroExtend 32 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem add_select_not_sext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → 64#64 + signExtend 64 (x ^^^ 1#1) = 64#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_not_sext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 + signExtend 64 (x ^^^ 1#1) = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_not_zext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → 64#64 + zeroExtend 64 (x ^^^ 1#1) = 64#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_not_zext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 + zeroExtend 64 (x ^^^ 1#1) = 2#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 64#64 + signExtend 64 x = 63#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_sext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 + signExtend 64 x = 1#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 64#64 + zeroExtend 64 x = 65#64 :=
      by bv_generalize ; bv_multi_width
theorem add_select_zext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 + zeroExtend 64 x = 1#64 :=
      by bv_generalize ; bv_multi_width
theorem mul_select_sext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → 64#64 * signExtend 64 x = BitVec.ofInt 64 (-64) :=
      by bv_generalize ; bv_multi_width
theorem mul_select_sext_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 * signExtend 64 x = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem mul_select_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 * zeroExtend 64 x = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem mul_select_zext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → x * zeroExtend 64 x_1 = x :=
      by bv_generalize ; bv_multi_width
theorem mul_select_zext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → 1#64 * zeroExtend 64 x_1 = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem multiuse_add_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 64#64 + zeroExtend 64 x + 1#64 = 66#64 :=
      by bv_generalize ; bv_multi_width
theorem multiuse_add_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 1#64 + zeroExtend 64 x + 1#64 = 2#64 :=
      by bv_generalize ; bv_multi_width
theorem multiuse_select_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 64#64 * (64#64 - zeroExtend 64 x) = 4032#64 :=
      by bv_generalize ; bv_multi_width
theorem multiuse_select_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 0#64 * (0#64 - zeroExtend 64 x) = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem select_non_const_sides_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → x - zeroExtend 64 x_1 = x + -1#64 :=
      by bv_generalize ; bv_multi_width
theorem select_non_const_sides_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → x - zeroExtend 64 x_1 = x :=
      by bv_generalize ; bv_multi_width
theorem select_non_const_sides_thm.extracted_1._3 : ∀ (x x_1 : BitVec 64) (x_2 : BitVec 1),
  x_2 = 1#1 → x_1 - zeroExtend 64 x_2 = x_1 + -1#64 :=
      by bv_generalize ; bv_multi_width
theorem select_non_const_sides_thm.extracted_1._4 : ∀ (x x_1 : BitVec 64) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → x - zeroExtend 64 x_2 = x :=
      by bv_generalize ; bv_multi_width
theorem select_zext_different_condition_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 →
    True ∧ (64#64).saddOverflow (zeroExtend 64 x) = true ∨ True ∧ (64#64).uaddOverflow (zeroExtend 64 x) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem select_zext_different_condition_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    True ∧ (1#64).saddOverflow (zeroExtend 64 x) = true ∨ True ∧ (1#64).uaddOverflow (zeroExtend 64 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem sub_select_not_sext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x = 1#1 → 64#64 - signExtend 64 (x ^^^ 1#1) = 65#64 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_not_sext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → x - signExtend 64 (x_1 ^^^ 1#1) = x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_not_sext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → 64#64 - signExtend 64 (x_1 ^^^ 1#1) = 65#64 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_not_zext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x = 1#1 → 64#64 - zeroExtend 64 (x ^^^ 1#1) = 63#64 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_not_zext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → x - zeroExtend 64 (x_1 ^^^ 1#1) = x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_not_zext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → 64#64 - zeroExtend 64 (x_1 ^^^ 1#1) = 63#64 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_op_swapped_non_const_args_thm.extracted_1._1 : ∀ (x : BitVec 6) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 6 x_1 - x = x ^^^ -1#6 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_op_swapped_non_const_args_thm.extracted_1._2 : ∀ (x : BitVec 6) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 6 x_1 - x = 0#6 - x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_op_swapped_non_const_args_thm.extracted_1._3 : ∀ (x x_1 : BitVec 6) (x_2 : BitVec 1),
  x_2 = 1#1 → signExtend 6 x_2 - x_1 = x_1 ^^^ -1#6 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_op_swapped_non_const_args_thm.extracted_1._4 : ∀ (x x_1 : BitVec 6) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → signExtend 6 x_2 - x = 0#6 - x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 64#64 - signExtend 64 x = 65#64 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → 64#64 - signExtend 64 x_1 = 65#64 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_sext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → x - signExtend 64 x_1 = x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_zext_op_swapped_non_const_args_thm.extracted_1._1 : ∀ (x : BitVec 6) (x_1 : BitVec 1),
  x_1 = 1#1 → zeroExtend 6 x_1 - x = 1#6 - x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_zext_op_swapped_non_const_args_thm.extracted_1._2 : ∀ (x : BitVec 6) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → zeroExtend 6 x_1 - x = 0#6 - x :=
      by bv_generalize ; bv_multi_width
theorem sub_select_zext_op_swapped_non_const_args_thm.extracted_1._3 : ∀ (x x_1 : BitVec 6) (x_2 : BitVec 1),
  x_2 = 1#1 → zeroExtend 6 x_2 - x_1 = 1#6 - x_1 :=
      by bv_generalize ; bv_multi_width
theorem sub_select_zext_op_swapped_non_const_args_thm.extracted_1._4 : ∀ (x x_1 : BitVec 6) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → zeroExtend 6 x_2 - x = 0#6 - x :=
      by bv_generalize ; bv_multi_width
theorem main10_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 == 0#32) = 1#1 →
    ofBool (x &&& 192#32 == 0#32) = 1#1 → ¬ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main10_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 == 0#32) = 1#1 →
    ¬ofBool (x &&& 192#32 == 0#32) = 1#1 → ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main10_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 == 0#32) &&& ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ¬ofBool (x &&& 192#32 == 0#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main10_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 == 0#32) &&& ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ofBool (x &&& 192#32 == 0#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main11_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 == 0#32) = 1#1 →
    ofBool (x &&& 192#32 == 192#32) = 1#1 → ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main11_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 == 0#32) = 1#1 →
    ¬ofBool (x &&& 192#32 == 192#32) = 1#1 → ¬ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main11_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 == 0#32) ||| ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ofBool (x &&& 192#32 == 192#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main11_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 == 0#32) ||| ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ¬ofBool (x &&& 192#32 == 192#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main12_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) = 1#1 → ofBool (x &&& 32896#32 == 0#32) = 1#1 → True → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main12_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) = 1#1 → ofBool (x &&& 32896#32 == 0#32) = 1#1 → ¬True → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main12_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) = 1#1 →
    ofBool (x &&& 32896#32 == 0#32) = 1#1 → ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main12_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 0#32) = 1#1 → ¬ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main12_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) ||| ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ofBool (x &&& 32896#32 == 0#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main12_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) ||| ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 0#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main13_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) = 1#1 →
    ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ¬ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main13_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main13_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) = 1#1 → ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main13_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) = 1#1 → ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → 0#1 = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main13_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) &&& ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main13_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) &&& ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ofBool (x &&& 32896#32 == 32896#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main14_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 →
    ofBool (x &&& 32896#32 == 0#32) = 1#1 → ¬ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main14_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 0#32) = 1#1 → ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main14_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 → ofBool (x &&& 32896#32 == 0#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main14_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 → ¬ofBool (x &&& 32896#32 == 0#32) = 1#1 → 0#1 = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main14_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#16 ≤ₛ truncate 16 x) &&& ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 0#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main14_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) &&& ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ofBool (x &&& 32896#32 == 0#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main15_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 → ofBool (x &&& 32896#32 == 32896#32) = 1#1 → True → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main15_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 → ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ¬True → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main15_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 →
    ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main15_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ¬ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main15_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#16 ≤ₛ truncate 16 x) ||| ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ofBool (x &&& 32896#32 == 32896#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main15_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) ||| ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main2_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem main2_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem main2_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
    ofBool (x &&& 2#32 == 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem main2_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
    ¬ofBool (x &&& 2#32 == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem main2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) ||| ofBool (x &&& 2#32 == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem main2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) ||| ofBool (x &&& 2#32 == 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) = 1#1 →
    ofBool (x &&& 48#32 == 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) = 1#1 →
    ¬ofBool (x &&& 48#32 == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) &&& ofBool (x &&& 48#32 == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) &&& ofBool (x &&& 48#32 == 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3b_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) = 1#1 →
    ofBool (x &&& 16#32 != 16#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3b_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) = 1#1 →
    ¬ofBool (x &&& 16#32 != 16#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3b_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3b_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3b_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) &&& ofBool (x &&& 16#32 != 16#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3b_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) &&& ofBool (x &&& 16#32 != 16#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3c_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 0#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3c_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 0#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3c_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) = 1#1 →
    ofBool (x &&& 48#32 != 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3c_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) = 1#1 →
    ¬ofBool (x &&& 48#32 != 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3c_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 0#32) ||| ofBool (x &&& 48#32 != 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3c_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) ||| ofBool (x &&& 48#32 != 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3d_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 0#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3d_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 0#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3d_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) = 1#1 →
    ofBool (x &&& 16#32 == 16#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3d_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) = 1#1 →
    ¬ofBool (x &&& 16#32 == 16#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3d_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 0#32) ||| ofBool (x &&& 16#32 == 16#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3d_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) ||| ofBool (x &&& 16#32 == 16#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → ofBool (x_1 &&& x != 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 → ofBool (x_2 &&& x_1 != 0#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → ofBool (x_1 &&& x != 0#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ofBool (x_2 &&& x_1 != 0#32) = 1#1 → ofBool (x_2 &&& x == 0#32) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ofBool (x_2 &&& x_1 != 0#32) = 1#1 → ¬ofBool (x_2 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
      ofBool (x_2 &&& x == 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
      ¬ofBool (x_2 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 → ofBool (x_2 &&& x_1 != 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) &&& ofBool (x_2 &&& x == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3e_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == 0#32) &&& ofBool (x_2 &&& x == 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
    ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
      ¬ofBool (x_2 &&& x != 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 → ofBool (x_2 &&& x != 0#32) = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 → ¬ofBool (x_2 &&& x != 0#32) = 1#1 → 1#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != 0#32) = 1#1 → ¬ofBool (x_1 &&& x == 0#32) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != 0#32) = 1#1 → ¬ofBool (x_1 &&& x == 0#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
    ofBool (x_2 &&& x_1 == 0#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
    ofBool (x_2 &&& x_1 == 0#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != 0#32) = 1#1 → ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != 0#32) = 1#1 → ¬ofBool (x_2 &&& x_1 == 0#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
    ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
      ofBool (x_2 &&& x != 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != 0#32) ||| ofBool (x_2 &&& x != 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main3f_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != 0#32) ||| ofBool (x_2 &&& x != 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) = 1#1 →
    ofBool (x &&& 48#32 == 48#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x &&& 48#32 == 48#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) &&& ofBool (x &&& 48#32 == 48#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) &&& ofBool (x &&& 48#32 == 48#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4b_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) = 1#1 →
    ofBool (x &&& 16#32 != 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4b_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x &&& 16#32 != 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4b_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4b_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4b_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) &&& ofBool (x &&& 16#32 != 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4b_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) &&& ofBool (x &&& 16#32 != 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4c_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4c_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4c_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) = 1#1 →
    ofBool (x &&& 48#32 != 48#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4c_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) = 1#1 →
    ¬ofBool (x &&& 48#32 != 48#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4c_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) ||| ofBool (x &&& 48#32 != 48#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4c_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) ||| ofBool (x &&& 48#32 != 48#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 55#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4d_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4d_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4d_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) = 1#1 →
    ofBool (x &&& 16#32 == 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4d_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) = 1#1 →
    ¬ofBool (x &&& 16#32 == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4d_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) ||| ofBool (x &&& 16#32 == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4d_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) ||| ofBool (x &&& 16#32 == 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x) = 1#1 → ofBool (x_1 &&& x != x) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → ofBool (x_2 &&& x_1 != x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != x)) :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != x)) :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x) = 1#1 → ofBool (x_1 &&& x != x) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ofBool (x_2 &&& x_1 != x_1) = 1#1 → ofBool (x_2 &&& x == x) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ofBool (x_2 &&& x_1 != x_1) = 1#1 → ¬ofBool (x_2 &&& x == x) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
      ofBool (x_2 &&& x == x) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != x)) :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
      ¬ofBool (x_2 &&& x == x) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != x)) :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → ofBool (x_2 &&& x_1 != x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) &&& ofBool (x_2 &&& x == x) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) != x_1 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem main4e_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) &&& ofBool (x_2 &&& x == x) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) != x_1 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ofBool (x_2 &&& x_1 == x_1) = 1#1 →
      ¬ofBool (x_2 &&& x != x) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x == x)) :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → ofBool (x_2 &&& x != x) = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → ¬ofBool (x_2 &&& x != x) = 1#1 → 1#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != x) = 1#1 → ¬ofBool (x_1 &&& x == x) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != x) = 1#1 → ¬ofBool (x_1 &&& x == x) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ofBool (x_2 &&& x_1 == x_1) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x)) :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ofBool (x_2 &&& x_1 == x_1) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x)) :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) = 1#1 → ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) = 1#1 → ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ofBool (x_2 &&& x_1 == x_1) = 1#1 →
      ofBool (x_2 &&& x != x) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x)) :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) ||| ofBool (x_2 &&& x != x) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) == x_1 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem main4f_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_1) ||| ofBool (x_2 &&& x != x) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) == x_1 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → ofBool (x &&& 7#32 != 7#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._10 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._11 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 7#32 != 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._12 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 7#32 != 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → ofBool (x &&& 7#32 != 7#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._5 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → ofBool (x &&& 7#32 == 7#32) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._7 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
      ofBool (x &&& 7#32 == 7#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 7#32 != 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._8 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
      ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 7#32 != 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5_like_logical_thm.extracted_1._9 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5_like_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 == 7#32) &&& ofBool (x &&& 7#32 == 7#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& 7#32 != 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5_like_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 == 7#32) &&& ofBool (x &&& 7#32 == 7#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& 7#32 != 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._10 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
      ¬ofBool (x &&& 7#32 != 7#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 7#32 == 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._11 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ofBool (x &&& 7#32 != 7#32) = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._12 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ¬ofBool (x &&& 7#32 != 7#32) = 1#1 → 1#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 → ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 → ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._5 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 7#32 == 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 7#32 == 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._7 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._8 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_logical_thm.extracted_1._9 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
      ofBool (x &&& 7#32 != 7#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 7#32 == 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 != 7#32) ||| ofBool (x &&& 7#32 != 7#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& 7#32 == 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5c_like_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 != 7#32) ||| ofBool (x &&& 7#32 != 7#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& 7#32 == 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x_1) = 1#1 → ofBool (x_1 &&& x != x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x_1) = 1#1 → ofBool (x_1 &&& x != x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ofBool (x_2 &&& x_1 != x_2) = 1#1 → ofBool (x_2 &&& x == x_2) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬ofBool (x_2 &&& x == x_2) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
      ofBool (x_2 &&& x == x_2) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
      ¬ofBool (x_2 &&& x == x_2) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ofBool (x_2 &&& x_1 != x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) &&& ofBool (x_2 &&& x == x_2) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 &&& x) != x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5e_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) &&& ofBool (x_2 &&& x == x_2) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 &&& x) != x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ofBool (x_2 &&& x_1 == x_2) = 1#1 →
      ¬ofBool (x_2 &&& x != x_2) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x == x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ofBool (x_2 &&& x != x_2) = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ¬ofBool (x_2 &&& x != x_2) = 1#1 → 1#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != x_1) = 1#1 → ¬ofBool (x_1 &&& x == x_1) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != x_1) = 1#1 → ¬ofBool (x_1 &&& x == x_1) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ofBool (x_2 &&& x_1 == x_2) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ofBool (x_2 &&& x_1 == x_2) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ¬True → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ofBool (x_2 &&& x_1 == x_2) = 1#1 →
      ofBool (x_2 &&& x != x_2) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_2) ||| ofBool (x_2 &&& x != x_2) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 &&& x) == x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main5f_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_2) ||| ofBool (x_2 &&& x != x_2) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 &&& x) == x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main6_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 3#32) = 1#1 →
    ofBool (x &&& 48#32 == 16#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 3#32) = 1#1 →
    ¬ofBool (x &&& 48#32 == 16#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 3#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 3#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 3#32) &&& ofBool (x &&& 48#32 == 16#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 3#32) &&& ofBool (x &&& 48#32 == 16#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6b_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 3#32) = 1#1 →
    ofBool (x &&& 16#32 != 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6b_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 3#32) = 1#1 →
    ¬ofBool (x &&& 16#32 != 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6b_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 3#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6b_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 3#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6b_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 3#32) &&& ofBool (x &&& 16#32 != 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6b_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 3#32) &&& ofBool (x &&& 16#32 != 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6c_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6c_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6c_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 3#32) = 1#1 →
    ofBool (x &&& 48#32 != 16#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6c_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 3#32) = 1#1 →
    ¬ofBool (x &&& 48#32 != 16#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6c_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) ||| ofBool (x &&& 48#32 != 16#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6c_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 3#32) ||| ofBool (x &&& 48#32 != 16#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6d_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) = 1#1 → True → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6d_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6d_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 3#32) = 1#1 →
    ofBool (x &&& 16#32 == 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6d_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 3#32) = 1#1 →
    ¬ofBool (x &&& 16#32 == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6d_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) ||| ofBool (x &&& 16#32 == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main6d_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 3#32) ||| ofBool (x &&& 16#32 == 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 19#32)) :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x_1) = 1#1 → ofBool (x_1 &&& x != x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& x_1 != x)) :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& x_1 != x)) :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x_1) = 1#1 → ofBool (x_1 &&& x != x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ofBool (x_2 &&& x_1 != x_2) = 1#1 → ofBool (x &&& x_1 == x) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ofBool (x_2 &&& x_1 != x_2) = 1#1 → ¬ofBool (x &&& x_1 == x) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
      ofBool (x &&& x_1 == x) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& x_1 != x)) :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_2) = 1#1 →
      ¬ofBool (x &&& x_1 == x) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& x_1 != x)) :=
      by bv_generalize ; bv_multi_width
theorem main7a_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) = 1#1 → ofBool (x_2 &&& x_1 != x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7a_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_2) &&& ofBool (x &&& x_1 == x) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x) != x_2 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem main7a_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) &&& ofBool (x &&& x_1 == x) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x) != x_2 ||| x)) :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == x &&& x_1) = 1#1 → ofBool (x_1 != x &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1 &&& x_2) = 1#1 → ofBool (x_2 != x_1 &&& x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1 &&& x_2) = 1#1 →
    ¬ofBool (x_2 != x_1 &&& x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1 &&& x_2) = 1#1 →
    ¬ofBool (x_2 != x_1 &&& x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == x &&& x_1) = 1#1 → ofBool (x_1 != x &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1 &&& x_2) = 1#1 →
    ofBool (x_2 != x_1 &&& x_2) = 1#1 → ofBool (x == x_1 &&& x) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1 &&& x_2) = 1#1 →
    ofBool (x_2 != x_1 &&& x_2) = 1#1 → ¬ofBool (x == x_1 &&& x) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1 &&& x_2) = 1#1 →
    ¬ofBool (x_2 != x_1 &&& x_2) = 1#1 →
      ofBool (x == x_1 &&& x) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1 &&& x_2) = 1#1 →
    ¬ofBool (x_2 != x_1 &&& x_2) = 1#1 →
      ¬ofBool (x == x_1 &&& x) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7b_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1 &&& x_2) = 1#1 → ofBool (x_2 != x_1 &&& x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7b_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1 &&& x_2) &&& ofBool (x * 42#32 == x_1 &&& x * 42#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x * 42#32) != x_2 ||| x * 42#32)) :=
      by bv_generalize ; bv_multi_width
theorem main7b_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1 &&& x_2) &&& ofBool (x * 42#32 == x_1 &&& x * 42#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x * 42#32) != x_2 ||| x * 42#32)) :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == x_1 &&& x) = 1#1 → ofBool (x_1 != x_1 &&& x) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_2 &&& x_1) = 1#1 → ofBool (x_2 != x_2 &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_2 &&& x_1) = 1#1 →
    ¬ofBool (x_2 != x_2 &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x != x &&& x_1)) :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_2 &&& x_1) = 1#1 →
    ¬ofBool (x_2 != x_2 &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x != x &&& x_1)) :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == x_1 &&& x) = 1#1 → ofBool (x_1 != x_1 &&& x) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_2 &&& x_1) = 1#1 →
    ofBool (x_2 != x_2 &&& x_1) = 1#1 → ofBool (x == x &&& x_1) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_2 &&& x_1) = 1#1 →
    ofBool (x_2 != x_2 &&& x_1) = 1#1 → ¬ofBool (x == x &&& x_1) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_2 &&& x_1) = 1#1 →
    ¬ofBool (x_2 != x_2 &&& x_1) = 1#1 →
      ofBool (x == x &&& x_1) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x != x &&& x_1)) :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_2 &&& x_1) = 1#1 →
    ¬ofBool (x_2 != x_2 &&& x_1) = 1#1 →
      ¬ofBool (x == x &&& x_1) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x != x &&& x_1)) :=
      by bv_generalize ; bv_multi_width
theorem main7c_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_2 &&& x_1) = 1#1 → ofBool (x_2 != x_2 &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7c_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_2 &&& x_1) &&& ofBool (x * 42#32 == x * 42#32 &&& x_1) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x * 42#32) != x_2 ||| x * 42#32)) :=
      by bv_generalize ; bv_multi_width
theorem main7c_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_2 &&& x_1) &&& ofBool (x * 42#32 == x * 42#32 &&& x_1) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x * 42#32) != x_2 ||| x * 42#32)) :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
    ofBool (x_2 &&& (x_1 &&& x) != x_1 &&& x) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 →
      ¬ofBool (x_4 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 →
      ofBool (x_4 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
        0#32 = zeroExtend 32 (ofBool (x_4 &&& (x_1 &&& x) != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 →
      ¬ofBool (x_4 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
        1#32 = zeroExtend 32 (ofBool (x_4 &&& (x_1 &&& x) != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._13 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._14 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._15 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 →
      0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_4 &&& (x_1 &&& x) != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._16 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 →
      ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_4 &&& (x_1 &&& x) != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
    ofBool (x_2 &&& (x_1 &&& x) != x_1 &&& x) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& (x_2 &&& x_1) == x_2 &&& x_1) = 1#1 →
    ofBool (x_3 &&& (x_2 &&& x_1) != x_2 &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& (x_2 &&& x_1) == x_2 &&& x_1) = 1#1 →
    ofBool (x_3 &&& (x_2 &&& x_1) != x_2 &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 →
      ofBool (x_4 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7d_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) &&& ofBool (x_4 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_4 &&& (x_3 &&& x_2 ||| x_1 &&& x) != x_3 &&& x_2 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7d_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) &&& ofBool (x_4 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_4 &&& (x_3 &&& x_2 ||| x_1 &&& x) != x_3 &&& x_2 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 &&& x == x_2 &&& x_1) = 1#1 →
    ofBool (x_2 &&& x_1 &&& x != x_2 &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      ¬ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ¬ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& x_2 != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ¬ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      ¬ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& x_2 != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._13 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._14 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._15 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ¬ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& x_2 != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._16 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ¬ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& x_2 != x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 &&& x == x_2 &&& x_1) = 1#1 →
    ofBool (x_2 &&& x_1 &&& x != x_2 &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 &&& x_1 == x_3 &&& x_2) = 1#1 →
    ofBool (x_3 &&& x_2 &&& x_1 != x_3 &&& x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 &&& x_1 == x_3 &&& x_2) = 1#1 →
    ofBool (x_3 &&& x_2 &&& x_1 != x_3 &&& x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7e_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) &&& ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_4 &&& x_3 ||| x_1 &&& x) != x_4 &&& x_3 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7e_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) &&& ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_4 &&& x_3 ||| x_1 &&& x) != x_4 &&& x_3 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x &&& (x_2 &&& x_1)) = 1#1 →
    ofBool (x_2 &&& x_1 != x &&& (x_2 &&& x_1)) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 →
      ¬ofBool (x_1 &&& x == x_2 &&& (x_1 &&& x)) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 →
      ofBool (x_1 &&& x == x_2 &&& (x_1 &&& x)) = 1#1 →
        0#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_2 &&& (x_1 &&& x))) :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 →
      ¬ofBool (x_1 &&& x == x_2 &&& (x_1 &&& x)) = 1#1 →
        1#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_2 &&& (x_1 &&& x))) :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._13 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._14 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._15 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 →
      0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_2 &&& (x_1 &&& x))) :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._16 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 →
      ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_2 &&& (x_1 &&& x))) :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x &&& (x_2 &&& x_1)) = 1#1 →
    ofBool (x_2 &&& x_1 != x &&& (x_2 &&& x_1)) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 == x_1 &&& (x_3 &&& x_2)) = 1#1 →
    ofBool (x_3 &&& x_2 != x_1 &&& (x_3 &&& x_2)) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 == x_1 &&& (x_3 &&& x_2)) = 1#1 →
    ofBool (x_3 &&& x_2 != x_1 &&& (x_3 &&& x_2)) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) = 1#1 →
    ofBool (x_4 &&& x_3 != x_2 &&& (x_4 &&& x_3)) = 1#1 →
      ofBool (x_1 &&& x == x_2 &&& (x_1 &&& x)) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7f_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) &&& ofBool (x_1 &&& x == x_2 &&& (x_1 &&& x)) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_4 &&& x_3 ||| x_1 &&& x) != x_4 &&& x_3 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7f_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_2 &&& (x_4 &&& x_3)) &&& ofBool (x_1 &&& x == x_2 &&& (x_1 &&& x)) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_4 &&& x_3 ||| x_1 &&& x) != x_4 &&& x_3 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2 &&& x_1 &&& x) = 1#1 →
    ofBool (x_2 &&& x_1 != x_2 &&& x_1 &&& x) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 →
      ¬ofBool (x_1 &&& x == x_1 &&& x &&& x_2) = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 →
      ofBool (x_1 &&& x == x_1 &&& x &&& x_2) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_1 &&& x &&& x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._12 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 →
      ¬ofBool (x_1 &&& x == x_1 &&& x &&& x_2) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_1 &&& x &&& x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._13 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._14 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._15 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 →
      0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_1 &&& x &&& x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._16 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ¬ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 →
      ¬0#1 = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& x != x_1 &&& x &&& x_2)) :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2 &&& x_1 &&& x) = 1#1 →
    ofBool (x_2 &&& x_1 != x_2 &&& x_1 &&& x) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._5 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 == x_3 &&& x_2 &&& x_1) = 1#1 →
    ofBool (x_3 &&& x_2 != x_3 &&& x_2 &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 == x_3 &&& x_2 &&& x_1) = 1#1 →
    ofBool (x_3 &&& x_2 != x_3 &&& x_2 &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_logical_thm.extracted_1._9 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& x_3 != x_4 &&& x_3 &&& x_2) = 1#1 →
      ofBool (x_1 &&& x == x_1 &&& x &&& x_2) = 1#1 → 0#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem main7g_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) &&& ofBool (x_1 &&& x == x_1 &&& x &&& x_2) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_4 &&& x_3 ||| x_1 &&& x) != x_4 &&& x_3 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main7g_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& x_3 == x_4 &&& x_3 &&& x_2) &&& ofBool (x_1 &&& x == x_1 &&& x &&& x_2) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_4 &&& x_3 ||| x_1 &&& x) != x_4 &&& x_3 ||| x_1 &&& x)) :=
      by bv_generalize ; bv_multi_width
theorem main8_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 != 0#32) = 1#1 →
    ofBool (x &&& 192#32 == 0#32) = 1#1 → ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main8_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 != 0#32) = 1#1 →
    ¬ofBool (x &&& 192#32 == 0#32) = 1#1 → ¬ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 != 0#32) ||| ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ofBool (x &&& 192#32 == 0#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main8_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 != 0#32) ||| ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ¬ofBool (x &&& 192#32 == 0#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main9_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 != 0#32) = 1#1 →
    ofBool (x &&& 192#32 == 192#32) = 1#1 → ¬ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem main9_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 != 0#32) = 1#1 →
    ¬ofBool (x &&& 192#32 == 192#32) = 1#1 → ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main9_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 != 0#32) &&& ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ¬ofBool (x &&& 192#32 == 192#32) = 1#1 → 2#32 = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem main9_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 64#32 != 0#32) &&& ofBool (truncate 8 x <ₛ 0#8) = 1#1 →
    ofBool (x &&& 192#32 == 192#32) = 1#1 → 1#32 = 2#32 :=
      by bv_generalize ; bv_multi_width
theorem rev8_mul_and_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (zeroExtend 64 x).smulOverflow 2050#64 = true ∨
        True ∧ (zeroExtend 64 x).umulOverflow 2050#64 = true ∨
          True ∧ (zeroExtend 64 x).smulOverflow 32800#64 = true ∨
            True ∧ (zeroExtend 64 x).umulOverflow 32800#64 = true ∨
              True ∧
                  (zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64).smulOverflow
                      65793#64 =
                    true ∨
                True ∧
                    (zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64).umulOverflow
                        65793#64 =
                      true ∨
                  16#64 ≥ ↑64) →
    True ∧ (zeroExtend 64 x).smulOverflow 2050#64 = true ∨
        True ∧ (zeroExtend 64 x).umulOverflow 2050#64 = true ∨
          True ∧ (zeroExtend 64 x).smulOverflow 32800#64 = true ∨
            True ∧ (zeroExtend 64 x).umulOverflow 32800#64 = true ∨
              True ∧
                  (zeroExtend 64 x * 2050#64 &&& 139536#64 &&& (zeroExtend 64 x * 32800#64 &&& 558144#64) != 0) = true ∨
                True ∧
                    (zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64).smulOverflow
                        65793#64 =
                      true ∨
                  True ∧
                      (zeroExtend 64 x * 2050#64 &&& 139536#64 |||
                              zeroExtend 64 x * 32800#64 &&& 558144#64).umulOverflow
                          65793#64 =
                        true ∨
                    16#64 ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem PR39793_bswap_u32_as_u16_trunc_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬8#32 ≥ ↑32 → truncate 8 (x >>> 8#32 &&& 255#32 ||| x <<< 8#32 &&& 65280#32) = truncate 8 (x >>> 8#32) :=
      by bv_generalize ; bv_multi_width
theorem PR39793_bswap_u64_as_u16_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(8#64 ≥ ↑64 ∨ 8#64 ≥ ↑64) →
    ¬8#64 ≥ ↑64 → truncate 8 (x >>> 8#64 &&& 255#64 ||| x <<< 8#64 &&& 65280#64) = truncate 8 (x >>> 8#64) :=
      by bv_generalize ; bv_multi_width
theorem test1_trunc_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    24#32 ≥ ↑32 ∨
        8#32 ≥ ↑32 ∨
          True ∧ (x >>> 24#32 &&& (x >>> 8#32 &&& 65280#32) != 0) = true ∨
            True ∧
              zeroExtend 32 (truncate 16 (x >>> 24#32 ||| x >>> 8#32 &&& 65280#32)) ≠
                x >>> 24#32 ||| x >>> 8#32 &&& 65280#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem PR23309_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 + BitVec.ofInt 32 (-4)).ssubOverflow x = true) →
    truncate 1 (x_1 + BitVec.ofInt 32 (-4) - x) = truncate 1 (x_1 - x) :=
      by bv_generalize ; bv_multi_width
theorem PR23309v2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 + BitVec.ofInt 32 (-4)).uaddOverflow x = true) →
    truncate 1 (x_1 + BitVec.ofInt 32 (-4) + x) = truncate 1 (x_1 + x) :=
      by bv_generalize ; bv_multi_width
theorem PR24763_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#32 ≥ ↑32 → ¬1#8 ≥ ↑8 → truncate 16 (signExtend 32 x >>> 1#32) = signExtend 16 (x.sshiftRight' 1#8) :=
      by bv_generalize ; bv_multi_width
theorem pr33078_1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬8#16 ≥ ↑16 → ¬7#8 ≥ ↑8 → truncate 8 (signExtend 16 x >>> 8#16) = x.sshiftRight' 7#8 :=
      by bv_generalize ; bv_multi_width
theorem pr33078_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 → ¬4#8 ≥ ↑8 → truncate 12 (signExtend 16 x >>> 4#16) = signExtend 12 (x.sshiftRight' 4#8) :=
      by bv_generalize ; bv_multi_width
theorem pr33078_3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬12#16 ≥ ↑16 →
    12#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 4 (signExtend 16 x >>> 12#16)) ≠ signExtend 16 x >>> 12#16 → False :=
      by bv_generalize ; bv_multi_width
theorem pr33078_4_thm.extracted_1._1 : ∀ (x : BitVec 3),
  ¬13#16 ≥ ↑16 →
    13#16 ≥ ↑16 ∨
        True ∧ signExtend 16 (truncate 8 (signExtend 16 x >>> 13#16)) ≠ signExtend 16 x >>> 13#16 ∨
          True ∧ zeroExtend 16 (truncate 8 (signExtend 16 x >>> 13#16)) ≠ signExtend 16 x >>> 13#16 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 16), truncate 16 (signExtend 32 x) = x :=
      by bv_generalize ; bv_multi_width
theorem test17_thm.extracted_1._1 : ∀ (x : BitVec 1), truncate 16 (zeroExtend 32 x) = zeroExtend 16 x :=
      by bv_generalize ; bv_multi_width
theorem test18_thm.extracted_1._1 : ∀ (x : BitVec 8), truncate 16 (signExtend 32 x) = signExtend 16 x :=
      by bv_generalize ; bv_multi_width
theorem test19_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (signExtend 64 x <ₛ 12345#64) = ofBool (x <ₛ 12345#32) :=
      by bv_generalize ; bv_multi_width
theorem test20_thm.extracted_1._1 : ∀ (x : BitVec 1), ofBool (zeroExtend 32 x <ₛ -1#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test21_thm.extracted_1._1 : ∀ (x : BitVec 32), signExtend 32 (truncate 8 x) &&& 255#32 = x &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem test22_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → signExtend 32 (truncate 8 x) <<< 24#32 = x <<< 24#32 :=
      by bv_generalize ; bv_multi_width
theorem test23_thm.extracted_1._1 : ∀ (x : BitVec 32), zeroExtend 32 (truncate 16 x) = x &&& 65535#32 :=
      by bv_generalize ; bv_multi_width
theorem test29_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (truncate 8 x_1 ||| truncate 8 x) = (x_1 ||| x) &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 64 (zeroExtend 32 (zeroExtend 16 x)) = zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem test31_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (truncate 32 x &&& 42#32 == 10#32) = ofBool (x &&& 42#64 == 10#64) :=
      by bv_generalize ; bv_multi_width
theorem test34_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬8#32 ≥ ↑32 → ¬8#16 ≥ ↑16 → truncate 16 (zeroExtend 32 x >>> 8#32) = x >>> 8#16 :=
      by bv_generalize ; bv_multi_width
theorem test36_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 31#32) == 0#8) = ofBool (-1#32 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem test37_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 31#32 ||| 512#32) == 11#8) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test38_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 64 (zeroExtend 8 (ofBool (x == BitVec.ofInt 32 (-2))) ^^^ 1#8) =
    zeroExtend 64 (ofBool (x != BitVec.ofInt 32 (-2))) :=
      by bv_generalize ; bv_multi_width
theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 64), zeroExtend 64 (truncate 8 x) = x &&& 255#64 :=
      by bv_generalize ; bv_multi_width
theorem test40_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(9#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(9#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ True ∧ (x >>> 9#16 &&& x <<< 8#16 != 0) = true) →
      truncate 16 (zeroExtend 32 x >>> 9#32 ||| zeroExtend 32 x <<< 8#32) = x >>> 9#16 ||| x <<< 8#16 :=
      by bv_generalize ; bv_multi_width
theorem test42_thm.extracted_1._1 : ∀ (x : BitVec 32), zeroExtend 32 (truncate 8 x) = x &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem test43_thm.extracted_1._1 : ∀ (x : BitVec 8), True ∧ (zeroExtend 32 x).saddOverflow (-1#32) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test44_thm.extracted_1._1 : ∀ (x : BitVec 8), True ∧ (zeroExtend 16 x ||| 1234#16).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem test46_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → 8#32 ≥ ↑32 ∨ True ∧ (truncate 32 x <<< 8#32 &&& 10752#32).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem test46_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 →
    ¬(8#32 ≥ ↑32 ∨ True ∧ (truncate 32 x <<< 8#32 &&& 10752#32).msb = true) →
      zeroExtend 64 ((truncate 32 x &&& 42#32) <<< 8#32) = zeroExtend 64 (truncate 32 x <<< 8#32 &&& 10752#32) :=
      by bv_generalize ; bv_multi_width
theorem test47_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 64 (signExtend 32 x ||| 42#32) = zeroExtend 64 (signExtend 32 (x ||| 42#8)) :=
      by bv_generalize ; bv_multi_width
theorem test48_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x <<< 8#32).sshiftRight' 8#32 ≠ zeroExtend 32 x ∨
        True ∧ zeroExtend 32 x <<< 8#32 >>> 8#32 ≠ zeroExtend 32 x ∨
          8#32 ≥ ↑32 ∨
            True ∧ (zeroExtend 32 x <<< 8#32 &&& zeroExtend 32 x != 0) = true ∨
              True ∧ (zeroExtend 32 x <<< 8#32 ||| zeroExtend 32 x).msb = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (zeroExtend 8 (ofBool (x_1 <ₛ x))) = zeroExtend 32 (ofBool (x_1 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem test51_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → True ∧ (truncate 32 x &&& BitVec.ofInt 32 (-2) &&& zeroExtend 32 (x_1 ^^^ 1#1) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test51_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬(True ∧ (truncate 32 x &&& BitVec.ofInt 32 (-2) &&& zeroExtend 32 (x_1 ^^^ 1#1) != 0) = true) →
      signExtend 64 (truncate 32 x &&& BitVec.ofInt 32 (-2)) =
        signExtend 64 (truncate 32 x &&& BitVec.ofInt 32 (-2) ||| zeroExtend 32 (x_1 ^^^ 1#1)) :=
      by bv_generalize ; bv_multi_width
theorem test51_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → True ∧ (truncate 32 x &&& BitVec.ofInt 32 (-2) &&& zeroExtend 32 (x_1 ^^^ 1#1) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test51_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (truncate 32 x &&& BitVec.ofInt 32 (-2) &&& zeroExtend 32 (x_1 ^^^ 1#1) != 0) = true) →
      signExtend 64 (truncate 32 x ||| 1#32) =
        signExtend 64 (truncate 32 x &&& BitVec.ofInt 32 (-2) ||| zeroExtend 32 (x_1 ^^^ 1#1)) :=
      by bv_generalize ; bv_multi_width
theorem test52_thm.extracted_1._1 : ∀ (x : BitVec 64),
  True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test52_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true) →
    zeroExtend 32 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350)) =
      zeroExtend 32 (truncate 16 x &&& 7224#16 ||| BitVec.ofInt 16 (-32574)) :=
      by bv_generalize ; bv_multi_width
theorem test53_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test53_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true) →
    zeroExtend 64 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350)) =
      zeroExtend 64 (truncate 16 x &&& 7224#16 ||| BitVec.ofInt 16 (-32574)) :=
      by bv_generalize ; bv_multi_width
theorem test54_thm.extracted_1._1 : ∀ (x : BitVec 64),
  True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test54_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true) →
    signExtend 32 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350)) =
      signExtend 32 (truncate 16 x &&& 7224#16 ||| BitVec.ofInt 16 (-32574)) :=
      by bv_generalize ; bv_multi_width
theorem test55_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test55_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true) →
    signExtend 64 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350)) =
      signExtend 64 (truncate 16 x &&& 7224#16 ||| BitVec.ofInt 16 (-32574)) :=
      by bv_generalize ; bv_multi_width
theorem test56_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬5#32 ≥ ↑32 → 5#32 ≥ ↑32 ∨ True ∧ (signExtend 32 x >>> 5#32).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem test57_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → 8#32 ≥ ↑32 ∨ True ∧ (truncate 32 x >>> 8#32).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem test58_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → 8#32 ≥ ↑32 ∨ True ∧ (truncate 32 x >>> 8#32 ||| 128#32).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem test59_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    True ∧ (zeroExtend 32 x <<< 4#32).sshiftRight' 4#32 ≠ zeroExtend 32 x ∨
        True ∧ zeroExtend 32 x <<< 4#32 >>> 4#32 ≠ zeroExtend 32 x ∨
          4#32 ≥ ↑32 ∨
            4#8 ≥ ↑8 ∨
              True ∧ (x_1 >>> 4#8).msb = true ∨
                True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 &&& zeroExtend 32 (x_1 >>> 4#8) != 0) = true ∨
                  True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)).msb = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test59_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    ¬(True ∧ (zeroExtend 32 x <<< 4#32).sshiftRight' 4#32 ≠ zeroExtend 32 x ∨
          True ∧ zeroExtend 32 x <<< 4#32 >>> 4#32 ≠ zeroExtend 32 x ∨
            4#32 ≥ ↑32 ∨
              4#8 ≥ ↑8 ∨
                True ∧ (x_1 >>> 4#8).msb = true ∨
                  True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 &&& zeroExtend 32 (x_1 >>> 4#8) != 0) = true ∨
                    True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)).msb = true) →
      zeroExtend 64 (zeroExtend 32 x_1 >>> 4#32 ||| zeroExtend 32 x <<< 4#32 &&& 48#32) =
        zeroExtend 64 (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)) :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 1), zeroExtend 32 (zeroExtend 8 x) = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test67_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& (zeroExtend 32 x ^^^ 1#32)) <<< 24#32).sshiftRight' 24#32 ≠ x_1 &&& (zeroExtend 32 x ^^^ 1#32) ∨
        True ∧ (x_1 &&& (zeroExtend 32 x ^^^ 1#32)) <<< 24#32 >>> 24#32 ≠ x_1 &&& (zeroExtend 32 x ^^^ 1#32) ∨
          24#32 ≥ ↑32 ∨
            True ∧
                ((x_1 &&& (zeroExtend 32 x ^^^ 1#32)) <<< 24#32 ^^^ BitVec.ofInt 32 (-16777216)) >>> 24#32 <<< 24#32 ≠
                  (x_1 &&& (zeroExtend 32 x ^^^ 1#32)) <<< 24#32 ^^^ BitVec.ofInt 32 (-16777216) ∨
              24#32 ≥ ↑32) →
    ofBool
        (truncate 8
            (((x_1 &&& (zeroExtend 32 x ^^^ 1#32)) <<< 24#32 ^^^ BitVec.ofInt 32 (-16777216)).sshiftRight' 24#32) ==
          0#8) =
      0#1 :=
      by bv_generalize ; bv_multi_width
theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 1), signExtend 64 (zeroExtend 32 x) = zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem test82_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(8#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    ¬1#32 ≥ ↑32 →
      zeroExtend 64 (truncate 32 x >>> 8#32 <<< 9#32) =
        zeroExtend 64 (truncate 32 x <<< 1#32 &&& BitVec.ofInt 32 (-512)) :=
      by bv_generalize ; bv_multi_width
theorem test83_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 16),
  ¬(True ∧ x.saddOverflow (-1#64) = true ∨ truncate 32 (x + -1#64) ≥ ↑32) → truncate 32 x + -1#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem test83_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 16),
  ¬(True ∧ x.saddOverflow (-1#64) = true ∨ truncate 32 (x + -1#64) ≥ ↑32) →
    ¬truncate 32 x + -1#32 ≥ ↑32 →
      zeroExtend 64 (signExtend 32 x_1 <<< truncate 32 (x + -1#64)) =
        zeroExtend 64 (signExtend 32 x_1 <<< (truncate 32 x + -1#32)) :=
      by bv_generalize ; bv_multi_width
theorem test84_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-16777216)) = true ∨
        True ∧ (x + BitVec.ofInt 32 (-16777216)) >>> 23#32 <<< 23#32 ≠ x + BitVec.ofInt 32 (-16777216) ∨ 23#32 ≥ ↑32) →
    ¬23#32 ≥ ↑32 →
      truncate 8 ((x + BitVec.ofInt 32 (-16777216)) >>> 23#32) = truncate 8 ((x + 2130706432#32) >>> 23#32) :=
      by bv_generalize ; bv_multi_width
theorem test85_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow (BitVec.ofInt 32 (-16777216)) = true ∨
        True ∧ (x + BitVec.ofInt 32 (-16777216)) >>> 23#32 <<< 23#32 ≠ x + BitVec.ofInt 32 (-16777216) ∨ 23#32 ≥ ↑32) →
    ¬23#32 ≥ ↑32 →
      truncate 8 ((x + BitVec.ofInt 32 (-16777216)) >>> 23#32) = truncate 8 ((x + 2130706432#32) >>> 23#32) :=
      by bv_generalize ; bv_multi_width
theorem test86_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬4#32 ≥ ↑32 → ¬4#16 ≥ ↑16 → truncate 16 ((signExtend 32 x).sshiftRight' 4#32) = x.sshiftRight' 4#16 :=
      by bv_generalize ; bv_multi_width
theorem test87_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (signExtend 32 x).smulOverflow 16#32 = true ∨ 16#32 ≥ ↑32) → 12#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem test87_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ (signExtend 32 x).smulOverflow 16#32 = true ∨ 16#32 ≥ ↑32) →
    ¬12#16 ≥ ↑16 → truncate 16 ((signExtend 32 x * 16#32).sshiftRight' 16#32) = x.sshiftRight' 12#16 :=
      by bv_generalize ; bv_multi_width
theorem test88_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬18#32 ≥ ↑32 → ¬15#16 ≥ ↑16 → truncate 16 ((signExtend 32 x).sshiftRight' 18#32) = x.sshiftRight' 15#16 :=
      by bv_generalize ; bv_multi_width
theorem test91_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬48#96 ≥ ↑96 →
    48#96 ≥ ↑96 ∨
        True ∧ signExtend 96 (truncate 64 (signExtend 96 x >>> 48#96)) ≠ signExtend 96 x >>> 48#96 ∨
          True ∧ zeroExtend 96 (truncate 64 (signExtend 96 x >>> 48#96)) ≠ signExtend 96 x >>> 48#96 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test92_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#96 ≥ ↑96 → ¬32#64 ≥ ↑64 → truncate 64 (signExtend 96 x >>> 32#96) = x.sshiftRight' 32#64 :=
      by bv_generalize ; bv_multi_width
theorem test93_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬64#96 ≥ ↑96 → ¬31#32 ≥ ↑32 → truncate 32 (signExtend 96 x >>> 64#96) = x.sshiftRight' 31#32 :=
      by bv_generalize ; bv_multi_width
theorem test94_thm.extracted_1._1 : ∀ (x : BitVec 32),
  signExtend 64 (signExtend 8 (ofBool (x == BitVec.ofInt 32 (-2))) ^^^ -1#8) =
    signExtend 64 (ofBool (x != BitVec.ofInt 32 (-2))) :=
      by bv_generalize ; bv_multi_width
theorem test95_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬6#8 ≥ ↑8 →
    6#8 ≥ ↑8 ∨
        True ∧ (truncate 8 x >>> 6#8 &&& 2#8 &&& 40#8 != 0) = true ∨
          True ∧ (truncate 8 x >>> 6#8 &&& 2#8 ||| 40#8).msb = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 16), truncate 16 (signExtend 32 x) = x :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ signExtend 32 x >>> 6#32 <<< 6#32 ≠ signExtend 32 x ∨ 6#32 ≥ ↑32) →
    True ∧ x >>> 6#8 <<< 6#8 ≠ x ∨ 6#8 ≥ ↑8 → False :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_exact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ signExtend 32 x >>> 6#32 <<< 6#32 ≠ signExtend 32 x ∨ 6#32 ≥ ↑32) →
    ¬(True ∧ x >>> 6#8 <<< 6#8 ≠ x ∨ 6#8 ≥ ↑8) → truncate 8 (signExtend 32 x >>> 6#32) = x.sshiftRight' 6#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_narrow_input_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬6#32 ≥ ↑32 → ¬6#8 ≥ ↑8 → truncate 16 (signExtend 32 x >>> 6#32) = signExtend 16 (x.sshiftRight' 6#8) :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬6#32 ≥ ↑32 → ¬6#8 ≥ ↑8 → truncate 8 (signExtend 32 x >>> 6#32) = x.sshiftRight' 6#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_wide_input_exact_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ signExtend 32 x >>> 9#32 <<< 9#32 ≠ signExtend 32 x ∨ 9#32 ≥ ↑32) →
    True ∧ x >>> 9#16 <<< 9#16 ≠ x ∨
        9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_wide_input_exact_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ signExtend 32 x >>> 9#32 <<< 9#32 ≠ signExtend 32 x ∨ 9#32 ≥ ↑32) →
    ¬(True ∧ x >>> 9#16 <<< 9#16 ≠ x ∨
          9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16) →
      truncate 8 (signExtend 32 x >>> 9#32) = truncate 8 (x.sshiftRight' 9#16) :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_wide_input_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬9#32 ≥ ↑32 → 9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16 → False :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_sext_wide_input_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬9#32 ≥ ↑32 →
    ¬(9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16) →
      truncate 8 (signExtend 32 x >>> 9#32) = truncate 8 (x.sshiftRight' 9#16) :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_zext_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ zeroExtend 32 x >>> 6#32 <<< 6#32 ≠ zeroExtend 32 x ∨ 6#32 ≥ ↑32) → 6#8 ≥ ↑8 → False :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_zext_exact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ zeroExtend 32 x >>> 6#32 <<< 6#32 ≠ zeroExtend 32 x ∨ 6#32 ≥ ↑32) →
    ¬6#8 ≥ ↑8 → truncate 8 (zeroExtend 32 x >>> 6#32) = x >>> 6#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_zext_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬6#32 ≥ ↑32 → ¬6#8 ≥ ↑8 → truncate 8 (zeroExtend 32 x >>> 6#32) = x >>> 6#8 :=
      by bv_generalize ; bv_multi_width
theorem eval_sext_multi_use_in_one_inst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true) →
    True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true ∨
          True ∧ ((truncate 16 x &&& 14#16) * (truncate 16 x &&& 14#16) &&& BitVec.ofInt 16 (-32768) != 0) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem eval_zext_multi_use_in_one_inst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 5#16).smulOverflow (truncate 16 x &&& 5#16) = true ∨
        True ∧ (truncate 16 x &&& 5#16).umulOverflow (truncate 16 x &&& 5#16) = true) →
    True ∧ (truncate 16 x &&& 5#16).smulOverflow (truncate 16 x &&& 5#16) = true ∨
        True ∧ (truncate 16 x &&& 5#16).umulOverflow (truncate 16 x &&& 5#16) = true ∨
          True ∧ ((truncate 16 x &&& 5#16) * (truncate 16 x &&& 5#16)).msb = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem mul_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (truncate 8 x_1 * truncate 8 x) = x_1 * x &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem select1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → zeroExtend 32 (truncate 8 x) = x &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem select1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  x_2 = 1#1 → zeroExtend 32 (truncate 8 x_1) = x_1 &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem select1_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → zeroExtend 32 (truncate 8 x_1 + truncate 8 x) = x_1 + x &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem select1_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
  x_3 = 1#1 → zeroExtend 32 (truncate 8 x_2) = x_2 &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem select1_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
  ¬x_3 = 1#1 → zeroExtend 32 (truncate 8 x_1 + truncate 8 x) = x_1 + x &&& 255#32 :=
      by bv_generalize ; bv_multi_width
theorem select2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1), x_1 = 1#1 → truncate 8 (zeroExtend 32 x) = x :=
      by bv_generalize ; bv_multi_width
theorem select2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 → truncate 8 (zeroExtend 32 x_1) = x_1 :=
      by bv_generalize ; bv_multi_width
theorem select2_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → truncate 8 (zeroExtend 32 x_1 + zeroExtend 32 x) = x_1 + x :=
      by bv_generalize ; bv_multi_width
theorem select2_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
  x_3 = 1#1 → truncate 8 (zeroExtend 32 x_2) = x_2 :=
      by bv_generalize ; bv_multi_width
theorem select2_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
  ¬x_3 = 1#1 → truncate 8 (zeroExtend 32 x_1 + zeroExtend 32 x) = x_1 + x :=
      by bv_generalize ; bv_multi_width
theorem trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32), ofBool (x_1 <ᵤ x) = 1#1 → truncate 16 42#32 = 42#16 :=
      by bv_generalize ; bv_multi_width
theorem trunc_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32), ofBool (x_2 <ᵤ x_1) = 1#1 → truncate 16 42#32 = 42#16 :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 16), truncate 16 (signExtend 32 x &&& 15#32) = x &&& 15#16 :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 1), ofBool (zeroExtend 32 x != 0#32) = x :=
      by bv_generalize ; bv_multi_width
theorem test6a_thm.extracted_1._1 : ∀ (x : BitVec 1), ofBool (zeroExtend 32 x != -1#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem shift_trunc_signbit_test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 24#32) <ₛ 0#8) = ofBool (x <ₛ 0#32) :=
      by bv_generalize ; bv_multi_width
theorem shift_trunc_wrong_cmp_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → 24#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 8 (x >>> 24#32)) ≠ x >>> 24#32 → False :=
      by bv_generalize ; bv_multi_width
theorem shift_trunc_wrong_shift_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬23#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 23#32) <ₛ 0#8) = ofBool (x &&& 1073741824#32 != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (ofBool (x_1 <ₛ 0#32) ^^^ ofBool (-1#32 <ₛ x)) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬3#32 ≥ ↑32 → zeroExtend 32 (ofBool (x_1 &&& 8#32 == x &&& 8#32)) = (x_1 ^^^ x) >>> 3#32 &&& 1#32 ^^^ 1#32 :=
      by bv_generalize ; bv_multi_width
theorem test3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) →
    zeroExtend 32 (ofBool (x_1 >>> 31#32 == x >>> 31#32)) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
      by bv_generalize ; bv_multi_width
theorem test3i_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(29#32 ≥ ↑32 ∨ 29#32 ≥ ↑32) →
    zeroExtend 32 (ofBool (x_1 >>> 29#32 ||| 35#32 == x >>> 29#32 ||| 35#32)) =
      zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
      by bv_generalize ; bv_multi_width
theorem test4c_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(63#64 ≥ ↑64 ∨ 63#64 ≥ ↑64) →
    ofBool (truncate 32 (x.sshiftRight' 63#64 ||| (0#64 - x) >>> 63#64) <ₛ 1#32) = ofBool (x <ₛ 1#64) :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = 0#8 - x :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = x :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = 0#8 - x :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = x :=
      by bv_generalize ; bv_multi_width
theorem t2_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8) (x_2 : BitVec 1),
  signExtend 8 x_2 + x_1 ^^^ signExtend 8 x = x_1 + signExtend 8 x_2 ^^^ signExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem t3_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 2),
  signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = x + signExtend 8 x_1 ^^^ signExtend 8 x_1 :=
      by bv_generalize ; bv_multi_width
theorem test_cast_select_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → zeroExtend 32 3#16 = 3#32 :=
      by bv_generalize ; bv_multi_width
theorem test_cast_select_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 32 5#16 = 5#32 :=
      by bv_generalize ; bv_multi_width
theorem test_sext_zext_thm.extracted_1._1 : ∀ (x : BitVec 16), signExtend 64 (zeroExtend 32 x) = zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem PR28476_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x != 0#32) = 1#1 → ofBool (x == 0#32) = 1#1 → zeroExtend 32 0#1 ^^^ 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem PR28476_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 != 0#32) = 1#1 →
    ofBool (x_1 == 0#32) = 1#1 → zeroExtend 32 (ofBool (x != 0#32)) ^^^ 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem PR28476_logical_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 != 0#32) = 1#1 →
    ¬ofBool (x_1 == 0#32) = 1#1 → zeroExtend 32 (ofBool (x != 0#32)) ^^^ 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem PR28476_logical_thm.extracted_1._5 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 != 0#32) = 1#1 → ofBool (x_1 == 0#32) = 1#1 → zeroExtend 32 0#1 ^^^ 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem PR28476_logical_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 != 0#32) = 1#1 →
    ¬ofBool (x_1 == 0#32) = 1#1 → zeroExtend 32 0#1 ^^^ 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem PR28476_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (ofBool (x_1 != 0#32) &&& ofBool (x != 0#32)) ^^^ 1#32 =
    zeroExtend 32 (ofBool (x_1 == 0#32) ||| ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem demorgan_and_zext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  (zeroExtend 32 x_1 ^^^ 1#32) &&& (zeroExtend 32 x ^^^ 1#32) = zeroExtend 32 ((x_1 ||| x) ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem demorgan_or_zext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  zeroExtend 32 x_1 ^^^ 1#32 ||| zeroExtend 32 x ^^^ 1#32 = zeroExtend 32 (x_1 &&& x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(x ≥ ↑32 ∨ (2#32 <<< x == 0 || 32 != 1 && zeroExtend 32 x_1 == intMin 32 && 2#32 <<< x == -1) = true) →
    x + 1#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(x ≥ ↑32 ∨ (2#32 <<< x == 0 || 32 != 1 && zeroExtend 32 x_1 == intMin 32 && 2#32 <<< x == -1) = true) →
    ¬x + 1#32 ≥ ↑32 → (zeroExtend 32 x_1).sdiv (2#32 <<< x) = zeroExtend 32 x_1 >>> (x + 1#32) :=
      by bv_generalize ; bv_multi_width
theorem t2_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) → True ∧ x.msb = true ∨ zeroExtend 64 x ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem t2_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    ¬(True ∧ x.msb = true ∨ zeroExtend 64 x ≥ ↑64) → x_1 / zeroExtend 64 (1#32 <<< x) = x_1 >>> zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem t3_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (4#32 <<< x) = 0) → True ∧ (x + 2#32).msb = true ∨ zeroExtend 64 (x + 2#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem t3_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (4#32 <<< x) = 0) →
    ¬(True ∧ (x + 2#32).msb = true ∨ zeroExtend 64 (x + 2#32) ≥ ↑64) →
      x_1 / zeroExtend 64 (4#32 <<< x) = x_1 >>> zeroExtend 64 (x + 2#32) :=
      by bv_generalize ; bv_multi_width
theorem eq_10_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 x_1 == truncate 8 x) &&& ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32)) =
      ofBool (truncate 16 x_1 == truncate 16 x) :=
      by bv_generalize ; bv_multi_width
theorem eq_210_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) &&&
        (ofBool (truncate 8 x_1 == truncate 8 x) &&& ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32))) =
      ofBool (truncate 24 x_1 == truncate 24 x) :=
      by bv_generalize ; bv_multi_width
theorem eq_21_comm_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32)) &&&
          ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem eq_21_comm_eq2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) &&&
          ofBool (truncate 8 (x >>> 8#32) == truncate 8 (x_1 >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem eq_21_comm_eq_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) &&&
          ofBool (truncate 8 (x >>> 8#32) == truncate 8 (x_1 >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem eq_21_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) = 1#1 →
      ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
        ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32)) =
          ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem eq_21_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ¬ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) = 1#1 → 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem eq_21_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ¬ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) = 1#1 →
      ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) → 0#1 = ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem eq_21_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) &&&
          ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem eq_3210_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ 24#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 24#32) == truncate 8 (x >>> 24#32)) &&&
        (ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) &&&
          (ofBool (truncate 8 x_1 == truncate 8 x) &&& ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32)))) =
      ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem eq_irregular_bit_widths_thm.extracted_1._2 : ∀ (x x_1 : BitVec 31),
  ¬(13#31 ≥ ↑31 ∨ 13#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
    ¬(7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
      ofBool (truncate 5 (x_1 >>> 13#31) == truncate 5 (x >>> 13#31)) &&&
          ofBool (truncate 6 (x_1 >>> 7#31) == truncate 6 (x >>> 7#31)) =
        ofBool (truncate 11 (x_1 >>> 7#31) == truncate 11 (x >>> 7#31)) :=
      by bv_generalize ; bv_multi_width
theorem eq_optimized_highbits_cmp_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ^^^ x <ᵤ 33554432#32) &&& ofBool (truncate 25 x == truncate 25 x_1) = ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem eq_shift_in_zeros_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 24 (x_1 >>> 16#32) == truncate 24 (x >>> 16#32)) &&&
        ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32)) =
      ofBool (x_1 ^^^ x <ᵤ 256#32) :=
      by bv_generalize ; bv_multi_width
theorem ne_10_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 x_1 != truncate 8 x) ||| ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) =
      ofBool (truncate 16 x_1 != truncate 16 x) :=
      by bv_generalize ; bv_multi_width
theorem ne_210_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) |||
        (ofBool (truncate 8 x_1 != truncate 8 x) ||| ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32))) =
      ofBool (truncate 24 x_1 != truncate 24 x) :=
      by bv_generalize ; bv_multi_width
theorem ne_21_comm_ne2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) |||
          ofBool (truncate 8 (x >>> 8#32) != truncate 8 (x_1 >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem ne_21_comm_ne_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) |||
          ofBool (truncate 8 (x >>> 8#32) != truncate 8 (x_1 >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem ne_21_comm_or_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) |||
          ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem ne_21_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) = 1#1 → 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem ne_21_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) = 1#1 →
      ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) → 1#1 = ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem ne_21_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ¬ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) = 1#1 →
      ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
        ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) =
          ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem ne_21_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) |||
          ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
      by bv_generalize ; bv_multi_width
theorem ne_3210_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ 24#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 24#32) != truncate 8 (x >>> 24#32)) |||
        (ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) |||
          (ofBool (truncate 8 x_1 != truncate 8 x) ||| ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)))) =
      ofBool (x_1 != x) :=
      by bv_generalize ; bv_multi_width
theorem ne_irregular_bit_widths_thm.extracted_1._2 : ∀ (x x_1 : BitVec 31),
  ¬(13#31 ≥ ↑31 ∨ 13#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
    ¬(7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
      ofBool (truncate 5 (x_1 >>> 13#31) != truncate 5 (x >>> 13#31)) |||
          ofBool (truncate 6 (x_1 >>> 7#31) != truncate 6 (x >>> 7#31)) =
        ofBool (truncate 11 (x_1 >>> 7#31) != truncate 11 (x >>> 7#31)) :=
      by bv_generalize ; bv_multi_width
theorem ne_optimized_highbits_cmp_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (16777215#32 <ᵤ x_1 ^^^ x) ||| ofBool (truncate 24 x != truncate 24 x_1) = ofBool (x_1 != x) :=
      by bv_generalize ; bv_multi_width
theorem ne_shift_in_zeros_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 24 (x_1 >>> 16#32) != truncate 24 (x >>> 16#32)) |||
        ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) =
      ofBool (255#32 <ᵤ x_1 ^^^ x) :=
      by bv_generalize ; bv_multi_width
theorem pr9998_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ True ∧ x <<< 31#32 >>> 31#32 <<< 31#32 ≠ x <<< 31#32 ∨ 31#32 ≥ ↑32) →
    ofBool (7297771788697658747#64 <ᵤ signExtend 64 ((x <<< 31#32).sshiftRight' 31#32)) = ofBool (x &&& 1#32 != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nsw_false_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ signExtend 8 (truncate 1 x) ≠ x ∨ truncate 1 x = 1#1) → x = 0#8 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nsw_false_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ signExtend 8 (truncate 1 x_1) ≠ x_1) → ¬truncate 1 x_1 = 1#1 → x_1 = 0#8 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nsw_true_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(True ∧ signExtend 128 (truncate 1 x) ≠ x) → truncate 1 x = 1#1 → x = -1#128 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nsw_true_thm.extracted_1._2 : ∀ (x x_1 : BitVec 128),
  ¬(True ∧ signExtend 128 (truncate 1 x_1) ≠ x_1) → truncate 1 x_1 = 1#1 → x_1 = -1#128 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nuw_false_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ zeroExtend 8 (truncate 1 x) ≠ x ∨ truncate 1 x = 1#1) → x = 0#8 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nuw_false_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ zeroExtend 8 (truncate 1 x_1) ≠ x_1) → ¬truncate 1 x_1 = 1#1 → x_1 = 0#8 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nuw_true_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ zeroExtend 8 (truncate 1 x) ≠ x) → truncate 1 x = 1#1 → x = 1#8 :=
      by bv_generalize ; bv_multi_width
theorem fold_select_trunc_nuw_true_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ zeroExtend 8 (truncate 1 x_1) ≠ x_1) → truncate 1 x_1 = 1#1 → x_1 = 1#8 :=
      by bv_generalize ; bv_multi_width
theorem n10_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → 1#64 - x >>> 63#64 = zeroExtend 64 (ofBool (-1#64 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem n10_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    63#64 ≥ ↑64 ∨
        True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64 ∨
          True ∧ (truncate 32 (x.sshiftRight' 63#64)).saddOverflow 1#32 = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem n10_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    ¬(63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64 ∨
            True ∧ (truncate 32 (x.sshiftRight' 63#64)).saddOverflow 1#32 = true) →
      1#32 - truncate 32 (x >>> 63#64) = truncate 32 (x.sshiftRight' 63#64) + 1#32 :=
      by bv_generalize ; bv_multi_width
theorem n9_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    62#64 ≥ ↑64 ∨
        True ∧ signExtend 64 (truncate 32 (x >>> 62#64)) ≠ x >>> 62#64 ∨
          True ∧ zeroExtend 64 (truncate 32 (x >>> 62#64)) ≠ x >>> 62#64 ∨
            True ∧ (0#32).ssubOverflow (truncate 32 (x >>> 62#64)) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    63#64 ≥ ↑64 ∨ True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    ¬(63#64 ≥ ↑64 ∨ True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64) →
      0#32 - truncate 32 (x >>> 63#64) = truncate 32 (x.sshiftRight' 63#64) :=
      by bv_generalize ; bv_multi_width
theorem t1_exact_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) →
    True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨
        63#64 ≥ ↑64 ∨ True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem t1_exact_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) →
    ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨
          63#64 ≥ ↑64 ∨ True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64) →
      0#32 - truncate 32 (x >>> 63#64) = truncate 32 (x.sshiftRight' 63#64) :=
      by bv_generalize ; bv_multi_width
theorem t2_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    63#64 ≥ ↑64 ∨
        True ∧ signExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 ∨
          True ∧ zeroExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem t2_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    ¬(63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 ∨
            True ∧ zeroExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64) →
      0#32 - truncate 32 (x.sshiftRight' 63#64) = truncate 32 (x >>> 63#64) :=
      by bv_generalize ; bv_multi_width
theorem t3_exact_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) →
    True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨
        63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 ∨
            True ∧ zeroExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem t3_exact_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) →
    ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨
          63#64 ≥ ↑64 ∨
            True ∧ signExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 ∨
              True ∧ zeroExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64) →
      0#32 - truncate 32 (x.sshiftRight' 63#64) = truncate 32 (x >>> 63#64) :=
      by bv_generalize ; bv_multi_width
theorem src_is_mask_sext_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ¬(x_1 ≥ ↑8 ∨ True ∧ (31#8 >>> x_1).msb = true) →
      ofBool ((signExtend 16 (31#8 >>> x_1) ^^^ -1#16) &&& (x ^^^ 123#16) == 0#16) =
        ofBool (x ^^^ 123#16 ≤ᵤ zeroExtend 16 (31#8 >>> x_1)) :=
      by bv_generalize ; bv_multi_width
theorem src_is_mask_zext_fail_not_mask_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬x ≥ ↑8 →
    ofBool ((x_1 ^^^ 123#16) &&& zeroExtend 16 (BitVec.ofInt 8 (-2) >>> x) == x_1 ^^^ 123#16) =
      ofBool (x_1 ^^^ BitVec.ofInt 16 (-124) ||| zeroExtend 16 (BitVec.ofInt 8 (-2) >>> x) == -1#16) :=
      by bv_generalize ; bv_multi_width
theorem src_is_mask_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬x ≥ ↑8 →
    ofBool ((x_1 ^^^ 123#16) &&& zeroExtend 16 ((-1#8) >>> x) == x_1 ^^^ 123#16) =
      ofBool (x_1 ^^^ 123#16 ≤ᵤ zeroExtend 16 ((-1#8) >>> x)) :=
      by bv_generalize ; bv_multi_width
theorem src_is_notmask_ashr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8) (x_2 : BitVec 16),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑16) →
    ofBool
        (x_2 ^^^ 123#16 ==
          (x_2 ^^^ 123#16) &&& ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ^^^ -1#16)) =
      ofBool ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ≤ᵤ x_2 ^^^ BitVec.ofInt 16 (-124)) :=
      by bv_generalize ; bv_multi_width
theorem src_is_notmask_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬x ≥ ↑8 →
    ofBool (x_1 ^^^ 123#16 ≤ᵤ (signExtend 16 (BitVec.ofInt 8 (-8) <<< x) ^^^ -1#16) &&& (x_1 ^^^ 123#16)) =
      ofBool (signExtend 16 (BitVec.ofInt 8 (-8) <<< x) ≤ᵤ x_1 ^^^ BitVec.ofInt 16 (-128)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and1_lshr_pow2_minus_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (7#32 >>> x &&& 1#32 == 0#32)) = zeroExtend 32 (ofBool (2#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and1_lshr_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (8#32 >>> x &&& 1#32 == 0#32)) = zeroExtend 32 (ofBool (x != 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_lshr_pow2_case2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (4#32 >>> x &&& 8#32 == 0#32)) = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_lshr_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (8#32 >>> x &&& 4#32 == 0#32)) = zeroExtend 32 (ofBool (x != 1#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_minus1_shl1_negative2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (32#32 <<< x &&& 15#32 == 0#32)) = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_minus1_shl1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x &&& 15#32 == 0#32)) = zeroExtend 32 (ofBool (3#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_minus1_shl_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (2#32 <<< x &&& 15#32 == 0#32)) = zeroExtend 32 (ofBool (2#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_shl1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x &&& 16#32 == 0#32)) = zeroExtend 32 (ofBool (x != 4#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_shl_pow2_negative1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    ¬(x ≥ ↑32 ∨ 4#32 ≥ ↑32) →
      zeroExtend 32 (ofBool (11#32 <<< x &&& 16#32 == 0#32)) = 11#32 <<< x >>> 4#32 &&& 1#32 ^^^ 1#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_shl_pow2_negative2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (2#32 <<< x &&& 14#32 == 0#32)) = zeroExtend 32 (ofBool (2#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_shl_pow2_negative3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (32#32 <<< x &&& 16#32 == 0#32)) = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_and_pow2_shl_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (2#32 <<< x &&& 16#32 == 0#32)) = zeroExtend 32 (ofBool (x != 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and1_lshr_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (8#32 >>> x &&& 1#32 == 0#32)) = zeroExtend 32 (ofBool (x != 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and_pow2_lshr_pow2_case2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (4#32 >>> x &&& 8#32 == 0#32)) = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and_pow2_lshr_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (8#32 >>> x &&& 4#32 == 0#32)) = zeroExtend 32 (ofBool (x != 1#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and_pow2_minus1_shl1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x &&& 15#32 != 0#32)) = zeroExtend 32 (ofBool (x <ᵤ 4#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and_pow2_minus1_shl_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (2#32 <<< x &&& 15#32 != 0#32)) = zeroExtend 32 (ofBool (x <ᵤ 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and_pow2_shl1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x &&& 16#32 != 0#32)) = zeroExtend 32 (ofBool (x == 4#32)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_and_pow2_shl_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (2#32 <<< x &&& 16#32 != 0#32)) = zeroExtend 32 (ofBool (x == 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem sext_sext_ne_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x_1 != signExtend 32 x) = ofBool (x_1 != x) :=
      by bv_generalize ; bv_multi_width
theorem sext_sext_sge_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 5),
  ofBool (signExtend 32 x ≤ₛ signExtend 32 x_1) = ofBool (x ≤ₛ signExtend 8 x_1) :=
      by bv_generalize ; bv_multi_width
theorem sext_sext_slt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x_1 <ₛ signExtend 32 x) = ofBool (x_1 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem sext_sext_ult_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x_1 <ᵤ signExtend 32 x) = ofBool (x_1 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_ne_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬6#8 = 0 → ofBool (signExtend 32 x_1 != zeroExtend 32 (x / 6#8)) = ofBool (x_1 != x / 6#8) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_nneg_sge_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 5),
  ¬(True ∧ x.msb = true) → ofBool (zeroExtend 32 x ≤ₛ signExtend 32 x_1) = ofBool (x ≤ₛ signExtend 8 x_1) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_nneg_slt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x.msb = true) → ofBool (signExtend 32 x_1 <ₛ zeroExtend 32 x) = ofBool (x_1 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_nneg_uge_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬(True ∧ x.msb = true) → ofBool (zeroExtend 32 x ≤ᵤ signExtend 32 x_1) = ofBool (signExtend 16 x ≤ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_nneg_ult_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x.msb = true) → ofBool (signExtend 32 x_1 <ᵤ zeroExtend 32 x) = ofBool (x_1 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_slt_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x_1 <ₛ zeroExtend 32 (x &&& 126#8)) = ofBool (x_1 <ₛ x &&& 126#8) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_uge_known_nonneg_op0_wide_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬(True ∧ (x &&& 12#8).msb = true) →
    ofBool (zeroExtend 32 (x &&& 12#8) ≤ᵤ signExtend 32 x_1) = ofBool (zeroExtend 16 (x &&& 12#8) ≤ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_ult_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬6#8 ≥ ↑8 → ofBool (signExtend 32 x_1 <ᵤ zeroExtend 32 (x >>> 6#8)) = ofBool (x_1 <ᵤ x >>> 6#8) :=
      by bv_generalize ; bv_multi_width
theorem zext_eq_sext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 32 x_1 == signExtend 32 x) = (x_1 ||| x) ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_sext_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (zeroExtend 32 x_1 == signExtend 32 x) = ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_sext_sgt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (signExtend 32 x <ₛ zeroExtend 32 x_1) = ofBool (x <ₛ x_1) :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_sext_sle_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (zeroExtend 32 x_1 ≤ₛ signExtend 32 x) = ofBool (signExtend 16 x_1 ≤ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_sext_ugt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (signExtend 32 x <ᵤ zeroExtend 32 x_1) = ofBool (x <ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_sext_ule_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 9),
  ¬(True ∧ x_1.msb = true) → ofBool (zeroExtend 32 x_1 ≤ᵤ signExtend 32 x) = ofBool (x_1 ≤ᵤ signExtend 9 x) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_eq_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬1#8 ≥ ↑8 → ofBool (zeroExtend 32 (x_1 >>> 1#8) == signExtend 32 x) = ofBool (x_1 >>> 1#8 == x) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_sgt_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 = 0 → ofBool (signExtend 32 x <ₛ zeroExtend 32 (127#8 / x_1)) = ofBool (x <ₛ 127#8 / x_1) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_sle_known_nonneg_op0_narrow_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬(True ∧ (x_1 &&& 12#8).msb = true) →
    ofBool (zeroExtend 32 (x_1 &&& 12#8) ≤ₛ signExtend 32 x) = ofBool (zeroExtend 16 (x_1 &&& 12#8) ≤ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_ugt_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x <ᵤ zeroExtend 32 (x_1 &&& 127#8)) = ofBool (x <ᵤ x_1 &&& 127#8) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_ule_known_nonneg_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 9),
  ¬254#9 = 0 → ofBool (zeroExtend 32 (x_1 % 254#9) ≤ᵤ signExtend 32 x) = ofBool (x_1 % 254#9 ≤ᵤ signExtend 9 x) :=
      by bv_generalize ; bv_multi_width
theorem zext_zext_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (zeroExtend 32 x_1 == zeroExtend 32 x) = ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem zext_zext_sgt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ zeroExtend 32 x_1) = ofBool (x <ᵤ x_1) :=
      by bv_generalize ; bv_multi_width
theorem zext_zext_sle_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ofBool (zeroExtend 32 x_1 ≤ₛ zeroExtend 32 x) = ofBool (zeroExtend 16 x_1 ≤ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem zext_zext_ule_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 9),
  ofBool (zeroExtend 32 x_1 ≤ᵤ zeroExtend 32 x) = ofBool (x_1 ≤ᵤ zeroExtend 9 x) :=
      by bv_generalize ; bv_multi_width
theorem mul_of_bool_no_lz_other_op_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& 1#32).smulOverflow (signExtend 32 x) = true ∨
        True ∧ (x_1 &&& 1#32).umulOverflow (signExtend 32 x) = true) →
    ofBool (127#32 <ₛ (x_1 &&& 1#32) * signExtend 32 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem mul_of_bool_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ofBool (255#32 <ᵤ (x_1 &&& 1#32) * zeroExtend 32 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem mul_of_pow2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ofBool (510#32 <ᵤ (x_1 &&& 2#32) * zeroExtend 32 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem not_mul_of_bool_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  True ∧ (x_1 &&& 3#32).smulOverflow (zeroExtend 32 x) = true ∨
      True ∧ (x_1 &&& 3#32).umulOverflow (zeroExtend 32 x) = true →
    False :=
      by bv_generalize ; bv_multi_width
theorem not_mul_of_pow2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  True ∧ (x_1 &&& 6#32).smulOverflow (zeroExtend 32 x) = true ∨
      True ∧ (x_1 &&& 6#32).umulOverflow (zeroExtend 32 x) = true →
    False :=
      by bv_generalize ; bv_multi_width
theorem splat_mul_known_lz_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬96#128 ≥ ↑128 → ofBool ((zeroExtend 128 x * 18446744078004518913#128) >>> 96#128 == 0#128) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem splat_mul_unknown_lz_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬95#128 ≥ ↑128 → ofBool ((zeroExtend 128 x * 18446744078004518913#128) >>> 95#128 == 0#128) = ofBool (-1#32 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem pr51551_neg2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-7)).smulOverflow x = true) →
    truncate 1 x_1 ^^^ 1#1 = 1#1 → ofBool ((x_1 &&& BitVec.ofInt 32 (-7)) * x &&& 7#32 == 0#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem pr51551_neg2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-7)).smulOverflow x = true) →
    ¬truncate 1 x_1 ^^^ 1#1 = 1#1 →
      ofBool ((x_1 &&& BitVec.ofInt 32 (-7)) * x &&& 7#32 == 0#32) = ofBool (x &&& 7#32 == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem test_eq1_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem test_eq2_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 32 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == truncate 16 x) :=
      by bv_generalize ; bv_multi_width
theorem test_slt_nuw_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 32 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem test_slt_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem test_ult_nuw_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 32 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem test_ult_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_both_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1 ∨ True ∧ zeroExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 != signExtend 16 x) = ofBool (x_1 != signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_both_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_nsw_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 != signExtend 16 x) = ofBool (x_1 != signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_nsw_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 != zeroExtend 16 x) = ofBool (x_1 != zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_equality_nuw_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ zeroExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 != zeroExtend 16 x) = ofBool (x_1 != zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_signed_both_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_signed_nsw_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 <ₛ signExtend 16 x) = ofBool (x_1 <ₛ signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_signed_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_signed_nsw_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 <ₛ zeroExtend 16 x) = ofBool (x_1 <ₛ zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_unsigned_both_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_unsigned_nsw_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 <ᵤ signExtend 16 x) = ofBool (x_1 <ᵤ signExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_unsigned_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_unsigned_nsw_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 <ᵤ zeroExtend 16 x) = ofBool (x_1 <ᵤ zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_unsigned_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_unsigned_nuw_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ zeroExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 <ᵤ zeroExtend 16 x) = ofBool (x_1 <ᵤ zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_sext_eq_allones_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == -1#32)) == x) = ofBool (x + 1#32 <ᵤ 2#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_sext_eq_otherwise_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == 2#32)) == x) = ofBool (x == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_sext_eq_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == 0#32)) == x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_sext_ne_allones_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != -1#32)) == x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_sext_ne_otherwise_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != 2#32)) == x) = ofBool (x == -1#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_sext_ne_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != 0#32)) == x) = ofBool (x + 1#32 <ᵤ 2#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_zext_eq_non_boolean_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 2#32)) == x) = ofBool (x == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_zext_eq_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 1#32)) == x) = ofBool (x <ᵤ 2#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_zext_eq_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 0#32)) == x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_zext_ne_non_boolean_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 2#32)) == x) = ofBool (x == 1#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_zext_ne_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 1#32)) == x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_eq_zext_ne_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 0#32)) == x) = ofBool (x <ᵤ 2#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_eq_allones_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == -1#32)) != x) = ofBool (x + -1#32 <ᵤ BitVec.ofInt 32 (-2)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_eq_otherwise_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == 2#32)) != x) = ofBool (x != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_eq_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == 0#32)) != x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_ne_allones_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != -1#32)) != x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_ne_otherwise_i128_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ofBool (signExtend 128 (ofBool (x != 2#128)) != x) = ofBool (x != -1#128) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_ne_otherwise_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != 2#32)) != x) = ofBool (x != -1#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_ne_zero_i128_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ofBool (signExtend 128 (ofBool (x != 0#128)) != x) = ofBool (x + -1#128 <ᵤ BitVec.ofInt 128 (-2)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_ne_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != 0#32)) != x) = ofBool (x + -1#32 <ᵤ BitVec.ofInt 32 (-2)) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_sgt_zero_nofold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (0#32 <ₛ x)) != x) = ofBool (x != signExtend 32 (ofBool (0#32 <ₛ x))) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_slt_allones_nofold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x <ₛ -1#32)) != x) = ofBool (x != signExtend 32 (ofBool (x <ₛ -1#32))) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_sext_slt_otherwise_nofold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x <ₛ 2#32)) != x) = ofBool (x != signExtend 32 (ofBool (x <ₛ 2#32))) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_zext_eq_non_boolean_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 2#32)) != x) = ofBool (x != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_zext_eq_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 1#32)) != x) = ofBool (1#32 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_zext_eq_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 0#32)) != x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_zext_ne_non_boolean_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 2#32)) != x) = ofBool (x != 1#32) :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_zext_ne_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 1#32)) != x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem icmp_ne_zext_ne_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 0#32)) != x) = ofBool (1#32 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem sext_ule_sext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ofBool (signExtend 16 (x_1 * x_1) ≤ᵤ signExtend 16 x) = ofBool (x_1 * x_1 == 0#8) ||| x :=
      by bv_generalize ; bv_multi_width
theorem sub_ule_sext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 8),
  ofBool (x_2 - x_1 ≤ᵤ signExtend 8 x) = ofBool (x_2 == x_1) ||| x :=
      by bv_generalize ; bv_multi_width
theorem sub_ult_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 8),
  ofBool (x_2 - x_1 <ᵤ zeroExtend 8 x) = ofBool (x_2 == x_1) &&& x :=
      by bv_generalize ; bv_multi_width
theorem uge_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ofBool (x ≤ᵤ signExtend 8 x_1) = ofBool (x == 0#8) ||| x_1 :=
      by bv_generalize ; bv_multi_width
theorem ugt_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ofBool (x <ᵤ zeroExtend 8 x_1) = ofBool (x == 0#8) &&& x_1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_eq_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x == 1#8) = x_1 &&& (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_eq_minus1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x == -1#8) = x &&& (x_1 ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_i128_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (9223372036854775808#128 <ₛ zeroExtend 128 x_1 + signExtend 128 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_ne_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x != 1#8) = x ||| x_1 ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_ne_minus1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x != -1#8) = x_1 ||| x ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_sgt_0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (0#8 <ₛ zeroExtend 8 x_1 + signExtend 8 x) = x_1 &&& (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_sgt_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (1#8 <ₛ zeroExtend 8 x_1 + signExtend 8 x) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_sgt_minus1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (-1#8 <ₛ zeroExtend 8 x_1 + signExtend 8 x) = x_1 ||| x ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_sgt_minus2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (BitVec.ofInt 8 (-2) <ₛ zeroExtend 8 x_1 + signExtend 8 x) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_slt_0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x <ₛ 0#8) = x &&& (x_1 ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_slt_1_rhs_not_const_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 x_2 : BitVec 1),
  True ∧ (zeroExtend 8 x_2).saddOverflow (signExtend 8 x_1) = true → False :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_slt_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x <ₛ 1#8) = x ||| x_1 ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_slt_1_type_not_i1_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 2),
  True ∧ (zeroExtend 8 x_1).saddOverflow (signExtend 8 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_slt_2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x <ₛ 2#8) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_slt_minus1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x <ₛ -1#8) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_ugt_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (1#8 <ᵤ zeroExtend 8 x_1 + signExtend 8 x) = x &&& (x_1 ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem zext_sext_add_icmp_ult_minus1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x <ᵤ -1#8) = x_1 ||| x ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem zext_ult_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ofBool (zeroExtend 16 (x_1 * x_1) <ᵤ zeroExtend 16 x) = ofBool (x_1 * x_1 == 0#8) &&& x :=
      by bv_generalize ; bv_multi_width
theorem exactly_one_set_signbit_signed_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1.sshiftRight' 7#8 == signExtend 8 (ofBool (-1#8 <ₛ x))) = ofBool (x_1 ^^^ x <ₛ 0#8) :=
      by bv_generalize ; bv_multi_width
theorem exactly_one_set_signbit_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1 >>> 7#8 == zeroExtend 8 (ofBool (-1#8 <ₛ x))) = ofBool (x_1 ^^^ x <ₛ 0#8) :=
      by bv_generalize ; bv_multi_width
theorem exactly_one_set_signbit_wrong_pred_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (zeroExtend 8 (ofBool (-1#8 <ₛ x)) <ₛ x_1 >>> 7#8) = ofBool (x &&& x_1 <ₛ 0#8) :=
      by bv_generalize ; bv_multi_width
theorem same_signbit_wrong_type_signed_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 →
    ofBool (x_1.sshiftRight' 7#8 != signExtend 8 (ofBool (-1#32 <ₛ x))) = ofBool (x_1 <ₛ 0#8) ^^^ ofBool (-1#32 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem same_signbit_wrong_type_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 →
    ofBool (x_1 >>> 7#8 != zeroExtend 8 (ofBool (-1#32 <ₛ x))) = ofBool (x_1 <ₛ 0#8) ^^^ ofBool (-1#32 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_i1_fail_signed_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (signExtend 32 x_1 == x >>> 31#32) = ofBool (x >>> 31#32 == signExtend 32 x_1) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_i1_signed_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (signExtend 32 x_1 == x.sshiftRight' 31#32) = ofBool (-1#32 <ₛ x) ^^^ x_1 :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_slt_i1_fail_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 x_1 <ₛ x >>> 31#32) = ofBool (x <ₛ 0#32) &&& (x_1 ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_ult_i1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 x_1 <ᵤ x >>> 31#32) = ofBool (x <ₛ 0#32) &&& (x_1 ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem slt_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(31#32 ≥ ↑32 ∨ 32#64 ≥ ↑64) →
    31#32 ≥ ↑32 ∨ 32#64 ≥ ↑64 ∨ True ∧ zeroExtend 64 (truncate 32 (x >>> 32#64)) ≠ x >>> 32#64 → False :=
      by bv_generalize ; bv_multi_width
theorem testi16i8_com_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(8#16 ≥ ↑16 ∨ 7#8 ≥ ↑8) →
    ofBool (truncate 8 (x >>> 8#16) == (truncate 8 x).sshiftRight' 7#8) = ofBool (x + 128#16 <ᵤ 256#16) :=
      by bv_generalize ; bv_multi_width
theorem testi16i8_ne_com_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(8#16 ≥ ↑16 ∨ 7#8 ≥ ↑8) →
    ofBool (truncate 8 (x >>> 8#16) != (truncate 8 x).sshiftRight' 7#8) =
      ofBool (x + BitVec.ofInt 16 (-128) <ᵤ BitVec.ofInt 16 (-256)) :=
      by bv_generalize ; bv_multi_width
theorem testi16i8_ne_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 != truncate 8 (x >>> 8#16)) =
      ofBool (x + BitVec.ofInt 16 (-128) <ᵤ BitVec.ofInt 16 (-256)) :=
      by bv_generalize ; bv_multi_width
theorem testi16i8_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = ofBool (x + 128#16 <ᵤ 256#16) :=
      by bv_generalize ; bv_multi_width
theorem testi64i32_ne_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(31#32 ≥ ↑32 ∨ 32#64 ≥ ↑64) →
    ofBool ((truncate 32 x).sshiftRight' 31#32 != truncate 32 (x >>> 32#64)) =
      ofBool (x + BitVec.ofInt 64 (-2147483648) <ᵤ BitVec.ofInt 64 (-4294967296)) :=
      by bv_generalize ; bv_multi_width
theorem testi64i32_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(31#32 ≥ ↑32 ∨ 32#64 ≥ ↑64) →
    ofBool ((truncate 32 x).sshiftRight' 31#32 == truncate 32 (x >>> 32#64)) =
      ofBool (x + 2147483648#64 <ᵤ 4294967296#64) :=
      by bv_generalize ; bv_multi_width
theorem wrongimm2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16 → False :=
      by bv_generalize ; bv_multi_width
theorem sgt_n1_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (-1#8 <ₛ truncate 8 x) = ofBool (x &&& 128#32 == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem shl1_trunc_eq0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (truncate 16 (1#32 <<< x) == 0#16) = ofBool (15#32 <ᵤ x) :=
      by bv_generalize ; bv_multi_width
theorem slt_0_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (truncate 8 x <ₛ 0#8) = ofBool (x &&& 128#32 != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem ugt_253_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (BitVec.ofInt 8 (-3) <ᵤ truncate 8 x) = ofBool (x &&& 254#32 == 254#32) :=
      by bv_generalize ; bv_multi_width
theorem ugt_3_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (3#8 <ᵤ truncate 8 x) = ofBool (x &&& 252#32 != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem ult_192_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 8 x <ᵤ BitVec.ofInt 8 (-64)) = ofBool (x &&& 192#32 != 192#32) :=
      by bv_generalize ; bv_multi_width
theorem ult_2_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (truncate 8 x <ᵤ 2#8) = ofBool (x &&& 254#32 == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_i1_fail_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 →
    ofBool (zeroExtend 32 x_1 == x.sshiftRight' 31#32) = ofBool (x.sshiftRight' 31#32 == zeroExtend 32 x_1) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_i1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 x_1 == x >>> 31#32) = ofBool (-1#32 <ₛ x) ^^^ x_1 :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_ne_0_fail1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    ofBool (zeroExtend 32 (ofBool (x != 0#32)) == x.sshiftRight' 31#32) =
      ofBool (x.sshiftRight' 31#32 == zeroExtend 32 (ofBool (x != 0#32))) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_ne_0_fail2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬30#32 ≥ ↑32 →
    ofBool (zeroExtend 32 (ofBool (x != 0#32)) == x >>> 30#32) =
      ofBool (x >>> 30#32 == zeroExtend 32 (ofBool (x != 0#32))) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_eq_ne_0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 (ofBool (x != 0#32)) == x >>> 31#32) = ofBool (x <ₛ 1#32) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_ne_ne_0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 (ofBool (x != 0#32)) != x >>> 31#32) = ofBool (0#32 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem slt_zero_ne_ne_b_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 →
    ofBool (zeroExtend 32 (ofBool (x_1 != x)) != x_1 >>> 31#32) = ofBool (x_1 <ₛ 0#32) ^^^ ofBool (x_1 != x) :=
      by bv_generalize ; bv_multi_width
theorem bar_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (x_2 <ₛ x_1) = 1#1 →
    x_3 &&& (signExtend 32 (ofBool (x_2 <ₛ x_1)) ^^^ -1#32) ||| x &&& signExtend 32 (ofBool (x_2 <ₛ x_1)) = x :=
      by bv_generalize ; bv_multi_width
theorem bar_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_2 <ₛ x_1) = 1#1 →
    x_3 &&& (signExtend 32 (ofBool (x_2 <ₛ x_1)) ^^^ -1#32) ||| x &&& signExtend 32 (ofBool (x_2 <ₛ x_1)) = x_3 :=
      by bv_generalize ; bv_multi_width
theorem foo_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (x_2 <ₛ x_1) = 1#1 →
    x_3 &&& signExtend 32 (ofBool (x_2 <ₛ x_1)) ||| x &&& (signExtend 32 (ofBool (x_2 <ₛ x_1)) ^^^ -1#32) = x_3 :=
      by bv_generalize ; bv_multi_width
theorem foo_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_2 <ₛ x_1) = 1#1 →
    x_3 &&& signExtend 32 (ofBool (x_2 <ₛ x_1)) ||| x &&& (signExtend 32 (ofBool (x_2 <ₛ x_1)) ^^^ -1#32) = x :=
      by bv_generalize ; bv_multi_width
theorem bool_add_ashr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 → True ∧ (zeroExtend 2 x_1).uaddOverflow (zeroExtend 2 x) = true ∨ 1#2 ≥ ↑2 → False :=
      by bv_generalize ; bv_multi_width
theorem bool_add_lshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 → (zeroExtend 2 x_1 + zeroExtend 2 x) >>> 1#2 = zeroExtend 2 (x_1 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem bool_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬15#16 ≥ ↑16 → signExtend 16 x >>> 15#16 = zeroExtend 16 x :=
      by bv_generalize ; bv_multi_width
theorem fake_sext_thm.extracted_1._2 : ∀ (x : BitVec 3),
  ¬17#18 ≥ ↑18 → ¬(2#3 ≥ ↑3 ∨ True ∧ (x >>> 2#3).msb = true) → signExtend 18 x >>> 17#18 = zeroExtend 18 (x >>> 2#3) :=
      by bv_generalize ; bv_multi_width
theorem lshr_sext_i1_to_i128_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬42#128 ≥ ↑128 → x = 1#1 → signExtend 128 x >>> 42#128 = 77371252455336267181195263#128 :=
      by bv_generalize ; bv_multi_width
theorem lshr_sext_i1_to_i128_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬42#128 ≥ ↑128 → ¬x = 1#1 → signExtend 128 x >>> 42#128 = 0#128 :=
      by bv_generalize ; bv_multi_width
theorem lshr_sext_i1_to_i16_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬4#16 ≥ ↑16 → x = 1#1 → signExtend 16 x >>> 4#16 = 4095#16 :=
      by bv_generalize ; bv_multi_width
theorem lshr_sext_i1_to_i16_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬4#16 ≥ ↑16 → ¬x = 1#1 → signExtend 16 x >>> 4#16 = 0#16 :=
      by bv_generalize ; bv_multi_width
theorem not_bool_add_lshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 2),
  ¬2#4 ≥ ↑4 → (zeroExtend 4 x_1 + zeroExtend 4 x) >>> 2#4 = zeroExtend 4 (ofBool (x_1 ^^^ -1#2 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem not_signbit_alt_xor_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → (x ^^^ BitVec.ofInt 8 (-2)) >>> 7#8 = zeroExtend 8 (ofBool (-1#8 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem not_signbit_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → (x ^^^ -1#8) >>> 7#8 = zeroExtend 8 (ofBool (-1#8 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem not_signbit_trunc_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬15#16 ≥ ↑16 → truncate 8 ((x ^^^ -1#16) >>> 15#16) = zeroExtend 8 (ofBool (-1#16 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem not_signbit_zext_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬15#16 ≥ ↑16 → zeroExtend 32 ((x ^^^ -1#16) >>> 15#16) = zeroExtend 32 (ofBool (-1#16 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem smear_sign_and_widen_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬24#32 ≥ ↑32 → ¬7#8 ≥ ↑8 → signExtend 32 x >>> 24#32 = zeroExtend 32 (x.sshiftRight' 7#8) :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_big_sum_shift1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(21#32 ≥ ↑32 ∨ 11#12 ≥ ↑12) → truncate 12 (x >>> 21#32) >>> 11#12 = 0#12 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_big_sum_shift2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) → truncate 12 (x >>> 31#32) >>> 1#12 = 0#12 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_max_sum_shift2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(30#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    31#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_max_sum_shift2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(30#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(31#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32) →
      truncate 12 (x >>> 30#32) >>> 1#12 = truncate 12 (x >>> 31#32) :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_max_sum_shift_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 11#12 ≥ ↑12) →
    31#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_max_sum_shift_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 11#12 ≥ ↑12) →
    ¬(31#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32) →
      truncate 12 (x >>> 20#32) >>> 11#12 = truncate 12 (x >>> 31#32) :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_min_shift1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    21#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_min_shift1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(21#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32) →
      truncate 12 (x >>> 20#32) >>> 1#12 = truncate 12 (x >>> 21#32) :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_small_shift1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(19#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) → 20#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 12 (x >>> 20#32)) ≠ x >>> 20#32 → False :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_small_shift1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(19#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(20#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 12 (x >>> 20#32)) ≠ x >>> 20#32) →
      truncate 12 (x >>> 19#32) >>> 1#12 = truncate 12 (x >>> 20#32) &&& 2047#12 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 2#12 ≥ ↑12) →
    30#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 30#32)) ≠ x >>> 30#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 30#32)) ≠ x >>> 30#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_sandwich_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 2#12 ≥ ↑12) →
    ¬(30#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 30#32)) ≠ x >>> 30#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 30#32)) ≠ x >>> 30#32) →
      truncate 12 (x >>> 28#32) >>> 2#12 = truncate 12 (x >>> 30#32) :=
      by bv_generalize ; bv_multi_width
theorem same_source_shifted_signbit_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → signExtend 32 (truncate 8 (x >>> 24#32)) = x.sshiftRight' 24#32 :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 → signExtend 16 (truncate 4 (x >>> 4#8)) = signExtend 16 (x.sshiftRight' 4#8) :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → signExtend 16 (truncate 3 (x >>> 5#8)) = signExtend 16 (x.sshiftRight' 5#8) :=
      by bv_generalize ; bv_multi_width
theorem t2_thm.extracted_1._1 : ∀ (x : BitVec 7),
  ¬3#7 ≥ ↑7 → signExtend 16 (truncate 4 (x >>> 3#7)) = signExtend 16 (x.sshiftRight' 3#7) :=
      by bv_generalize ; bv_multi_width
theorem foo_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (zeroExtend 32 (x &&& 255#16) <ᵤ 255#32) = 1#1 →
    truncate 16 (zeroExtend 32 (x &&& 255#16)) &&& 255#16 = x &&& 255#16 :=
      by bv_generalize ; bv_multi_width
theorem foo_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬ofBool (zeroExtend 32 (x &&& 255#16) <ᵤ 255#32) = 1#1 → truncate 16 255#32 &&& 255#16 = x &&& 255#16 :=
      by bv_generalize ; bv_multi_width
theorem or_basic_commuted_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (x &&& BitVec.ofInt 16 (-256) != 32512#16) ||| ofBool (truncate 8 x != 69#8) = ofBool (x != 32581#16) :=
      by bv_generalize ; bv_multi_width
theorem or_basic_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& BitVec.ofInt 16 (-256) != 17664#16) = ofBool (x != 17791#16) :=
      by bv_generalize ; bv_multi_width
theorem or_nontrivial_mask1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& 3840#16 != 1280#16) = ofBool (x &&& 4095#16 != 1407#16) :=
      by bv_generalize ; bv_multi_width
theorem or_nontrivial_mask2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& BitVec.ofInt 16 (-4096) != 20480#16) =
    ofBool (x &&& BitVec.ofInt 16 (-3841) != 20607#16) :=
      by bv_generalize ; bv_multi_width
theorem or_wrong_const1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& BitVec.ofInt 16 (-256) != 17665#16) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem cast_test_2002h08h02_thm.extracted_1._1 : ∀ (x : BitVec 64), zeroExtend 64 (truncate 8 x) = x &&& 255#64 :=
      by bv_generalize ; bv_multi_width
theorem shrink_and_thm.extracted_1._1 : ∀ (x : BitVec 64),
  True ∧ signExtend 64 (truncate 31 (x &&& 42#64)) ≠ x &&& 42#64 ∨
      True ∧ zeroExtend 64 (truncate 31 (x &&& 42#64)) ≠ x &&& 42#64 →
    False :=
      by bv_generalize ; bv_multi_width
theorem shrink_or_thm.extracted_1._1 : ∀ (x : BitVec 6),
  truncate 3 (x ||| BitVec.ofInt 6 (-31)) = truncate 3 x ||| 1#3 :=
      by bv_generalize ; bv_multi_width
theorem shrink_xor_thm.extracted_1._1 : ∀ (x : BitVec 64), truncate 32 (x ^^^ 1#64) = truncate 32 x ^^^ 1#32 :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  truncate 1 (zeroExtend 32 (ofBool (x_1 <ₛ x)) &&& zeroExtend 32 (ofBool (x <ₛ x_1))) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem sext_sext_add_mismatched_types_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(7#16 ≥ ↑16 ∨ 9#32 ≥ ↑32) →
    7#16 ≥ ↑16 ∨
        9#32 ≥ ↑32 ∨
          True ∧ (signExtend 64 (x_1.sshiftRight' 7#16)).saddOverflow (signExtend 64 (x.sshiftRight' 9#32)) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem sext_sext_add_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 7#32).saddOverflow (x.sshiftRight' 9#32) = true) →
      signExtend 64 (x.sshiftRight' 7#32) + signExtend 64 (x.sshiftRight' 9#32) =
        signExtend 64 (x.sshiftRight' 7#32 + x.sshiftRight' 9#32) :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_add_mismatched_exts_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    7#32 ≥ ↑32 ∨
        9#32 ≥ ↑32 ∨
          True ∧ (x >>> 9#32).msb = true ∨
            True ∧ (signExtend 64 (x.sshiftRight' 7#32)).saddOverflow (zeroExtend 64 (x >>> 9#32)) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test10_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ (x >>> 16#32).umulOverflow 65535#32 = true) →
      zeroExtend 64 (x >>> 16#32) * 65535#64 = zeroExtend 64 (x >>> 16#32 * 65535#32) :=
      by bv_generalize ; bv_multi_width
theorem test15_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (8#32).ssubOverflow (x.sshiftRight' 1#32) = true) →
      8#64 - signExtend 64 (x.sshiftRight' 1#32) = signExtend 64 (8#32 - x.sshiftRight' 1#32) :=
      by bv_generalize ; bv_multi_width
theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (BitVec.ofInt 32 (-2)).usubOverflow (x >>> 1#32) = true) →
      4294967294#64 - zeroExtend 64 (x >>> 1#32) = zeroExtend 64 (BitVec.ofInt 32 (-2) - x >>> 1#32) :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 1#32).saddOverflow 1073741823#32 = true) →
      signExtend 64 (x.sshiftRight' 1#32) + 1073741823#64 = signExtend 64 (x.sshiftRight' 1#32 + 1073741823#32) :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 1#32).saddOverflow (BitVec.ofInt 32 (-1073741824)) = true) →
      signExtend 64 (x.sshiftRight' 1#32) + BitVec.ofInt 64 (-1073741824) =
        signExtend 64 (x.sshiftRight' 1#32 + BitVec.ofInt 32 (-1073741824)) :=
      by bv_generalize ; bv_multi_width
theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (x >>> 1#32).uaddOverflow 2147483647#32 = true) →
      zeroExtend 64 (x >>> 1#32) + 2147483647#64 = zeroExtend 64 (x >>> 1#32 + 2147483647#32) :=
      by bv_generalize ; bv_multi_width
theorem test8_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 16#32).smulOverflow 32767#32 = true) →
      signExtend 64 (x.sshiftRight' 16#32) * 32767#64 = signExtend 64 (x.sshiftRight' 16#32 * 32767#32) :=
      by bv_generalize ; bv_multi_width
theorem test9_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 16#32).smulOverflow (BitVec.ofInt 32 (-32767)) = true) →
      signExtend 64 (x.sshiftRight' 16#32) * BitVec.ofInt 64 (-32767) =
        signExtend 64 (x.sshiftRight' 16#32 * BitVec.ofInt 32 (-32767)) :=
      by bv_generalize ; bv_multi_width
theorem neg_mask_const_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ofBool (x <ₛ 0#16) = 1#1 → True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem neg_mask_const_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ofBool (x <ₛ 0#16) = 1#1 →
      ¬(True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true) →
        1000#32 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = 1000#32 - signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem neg_mask_const_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ¬ofBool (x <ₛ 0#16) = 1#1 → 1000#32 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem neg_mask_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ofBool (x <ₛ 0#16) = 1#1 → True ∧ x_1.ssubOverflow (signExtend 32 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem neg_mask_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ofBool (x <ₛ 0#16) = 1#1 →
      ¬(True ∧ x_1.ssubOverflow (signExtend 32 x) = true) →
        x_1 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = x_1 - signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem neg_mask_thm.extracted_1._3 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ¬ofBool (x <ₛ 0#16) = 1#1 → x_1 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem neg_not_signbit1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → 1#32 - zeroExtend 32 (x >>> 7#8) = zeroExtend 32 (ofBool (-1#8 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem neg_not_signbit2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬6#8 ≥ ↑8 →
    6#8 ≥ ↑8 ∨ True ∧ (x >>> 6#8).msb = true ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 6#8)) = true → False :=
      by bv_generalize ; bv_multi_width
theorem neg_not_signbit3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → 7#8 ≥ ↑8 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x.sshiftRight' 7#8)) = true → False :=
      by bv_generalize ; bv_multi_width
theorem neg_signbit_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → 0#32 - zeroExtend 32 (x >>> 7#8) = signExtend 32 (x.sshiftRight' 7#8) :=
      by bv_generalize ; bv_multi_width
theorem sub_mask1_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    48#64 ≥ ↑64 ∨
        63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)) ≠ (x <<< 48#64).sshiftRight' 63#64 ∨
            True ∧ (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)).saddOverflow 10#8 = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem sub_mask1_trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    ¬(48#64 ≥ ↑64 ∨
          63#64 ≥ ↑64 ∨
            True ∧ signExtend 64 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)) ≠ (x <<< 48#64).sshiftRight' 63#64 ∨
              True ∧ (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)).saddOverflow 10#8 = true) →
      10#8 - (truncate 8 (x >>> 15#64) &&& 1#8) = truncate 8 ((x <<< 48#64).sshiftRight' 63#64) + 10#8 :=
      by bv_generalize ; bv_multi_width
theorem sub_sext_mask1_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    48#64 ≥ ↑64 ∨
        63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)) ≠ (x <<< 48#64).sshiftRight' 63#64 ∨
            True ∧ (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)).saddOverflow 10#8 = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem sub_sext_mask1_trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    ¬(48#64 ≥ ↑64 ∨
          63#64 ≥ ↑64 ∨
            True ∧ signExtend 64 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)) ≠ (x <<< 48#64).sshiftRight' 63#64 ∨
              True ∧ (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)).saddOverflow 10#8 = true) →
      10#32 - signExtend 32 (truncate 8 (x >>> 15#64) &&& 1#8) =
        zeroExtend 32 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64) + 10#8) :=
      by bv_generalize ; bv_multi_width
theorem sub_zext_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    16#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 ∨ True ∧ ((truncate 32 x <<< 16#32).sshiftRight' 31#32).saddOverflow 10#32 = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem sub_zext_trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    ¬(16#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 ∨ True ∧ ((truncate 32 x <<< 16#32).sshiftRight' 31#32).saddOverflow 10#32 = true) →
      10#32 - zeroExtend 32 (truncate 1 (x >>> 15#64)) = (truncate 32 x <<< 16#32).sshiftRight' 31#32 + 10#32 :=
      by bv_generalize ; bv_multi_width
theorem test_sext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  x_1 + signExtend 32 (ofBool (x == 0#32)) ^^^ -1#32 = signExtend 32 (ofBool (x != 0#32)) - x_1 :=
      by bv_generalize ; bv_multi_width
theorem test_trunc_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (zeroExtend 32 x).saddOverflow (-1#32) = true ∨ 31#32 ≥ ↑32) →
    truncate 8 ((zeroExtend 32 x + -1#32).sshiftRight' 31#32) ^^^ -1#8 = signExtend 8 (ofBool (x != 0#8)) :=
      by bv_generalize ; bv_multi_width
theorem test_zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(True ∧ (x_1 ^^^ -1#32).msb = true) →
    x_2 + BitVec.ofInt 64 (-5) - (zeroExtend 64 (x_1 ^^^ -1#32) + x) =
      x_2 + BitVec.ofInt 64 (-4) + (signExtend 64 x_1 - x) :=
      by bv_generalize ; bv_multi_width
theorem mul_may_overflow_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (ofBool (zeroExtend 34 x_1 * zeroExtend 34 x ≤ᵤ 4294967295#34)) =
    zeroExtend 32 (ofBool (zeroExtend 34 x_1 * zeroExtend 34 x <ᵤ 4294967296#34)) :=
      by bv_generalize ; bv_multi_width
theorem pr4917_3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (4294967295#64 <ᵤ zeroExtend 64 x_1 * zeroExtend 64 x) = 1#1 →
    True ∧ (zeroExtend 64 x_1).umulOverflow (zeroExtend 64 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem pr4917_3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (4294967295#64 <ᵤ zeroExtend 64 x_1 * zeroExtend 64 x) = 1#1 →
    True ∧ (zeroExtend 64 x_1).umulOverflow (zeroExtend 64 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem PR51351_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(zeroExtend 64 x_1 ≥ ↑64 ∨ zeroExtend 64 x_1 ≥ ↑64 ∨ x_1 + BitVec.ofInt 32 (-33) ≥ ↑32) →
    x_1 + BitVec.ofInt 32 (-33) ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem PR51351_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(zeroExtend 64 x_1 ≥ ↑64 ∨ zeroExtend 64 x_1 ≥ ↑64 ∨ x_1 + BitVec.ofInt 32 (-33) ≥ ↑32) →
    ¬x_1 + BitVec.ofInt 32 (-33) ≥ ↑32 →
      truncate 32 (((-1#64) <<< zeroExtend 64 x_1).sshiftRight' (zeroExtend 64 x_1) &&& x) <<<
          (x_1 + BitVec.ofInt 32 (-33)) =
        truncate 32 x <<< (x_1 + BitVec.ofInt 32 (-33)) :=
      by bv_generalize ; bv_multi_width
theorem fast_div_201_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ 1#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
        True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
          8#16 ≥ ↑16 ∨
            True ∧
                signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠ (zeroExtend 16 x * 71#16) >>> 8#16 ∨
              True ∧
                  zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠ (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                1#8 ≥ ↑8 ∨
                  True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
                    True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
                      8#16 ≥ ↑16 ∨
                        True ∧
                            signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                              (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                          True ∧
                              zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                                (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                            True ∧
                                ((x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8).uaddOverflow
                                    (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) =
                                  true ∨
                              7#8 ≥ ↑8 →
      False :=
      by bv_generalize ; bv_multi_width
theorem fast_div_201_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ 1#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
          True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
            8#16 ≥ ↑16 ∨
              True ∧
                  signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠ (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                True ∧
                    zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                      (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                  1#8 ≥ ↑8 ∨
                    True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
                      True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
                        8#16 ≥ ↑16 ∨
                          True ∧
                              signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                                (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                            True ∧
                                zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                                  (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                              True ∧
                                  ((x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8).uaddOverflow
                                      (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) =
                                    true ∨
                                7#8 ≥ ↑8) →
      (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16) +
            (x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8) >>>
          7#8 =
        ((x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8 +
            truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>>
          7#8 :=
      by bv_generalize ; bv_multi_width
theorem f2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ 0#32) = 1#1 →
    ¬x ≥ ↑32 → zeroExtend 32 (ofBool ((7#32).sshiftRight' x <ₛ x_1)) = zeroExtend 32 (ofBool (7#32 >>> x <ₛ x_1)) :=
      by bv_generalize ; bv_multi_width
theorem widget_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (20#32 <<< zeroExtend 32 (ofBool (x != 0#32))).sshiftRight' (zeroExtend 32 (ofBool (x != 0#32))) ≠ 20#32 ∨
      True ∧ 20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) >>> zeroExtend 32 (ofBool (x != 0#32)) ≠ 20#32 ∨
        zeroExtend 32 (ofBool (x != 0#32)) ≥ ↑32 ∨
          True ∧ (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) &&& zeroExtend 32 (ofBool (x != 0#32)) != 0) = true ∨
            True ∧
                ((20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
                        zeroExtend 32 (ofBool (x != 0#32))).sshiftRight'
                    (zeroExtend 32 (ofBool (x != 0#32))) ≠
                  20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32)) ∨
              True ∧
                  (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
                        zeroExtend 32 (ofBool (x != 0#32)) >>>
                      zeroExtend 32 (ofBool (x != 0#32)) ≠
                    20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32)) ∨
                zeroExtend 32 (ofBool (x != 0#32)) ≥ ↑32 →
    False :=
      by bv_generalize ; bv_multi_width
theorem widget_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (20#32 <<< zeroExtend 32 (ofBool (x != 0#32))).sshiftRight' (zeroExtend 32 (ofBool (x != 0#32))) ≠ 20#32 ∨
        True ∧ 20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) >>> zeroExtend 32 (ofBool (x != 0#32)) ≠ 20#32 ∨
          zeroExtend 32 (ofBool (x != 0#32)) ≥ ↑32 ∨
            True ∧ (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) &&& zeroExtend 32 (ofBool (x != 0#32)) != 0) = true ∨
              True ∧
                  ((20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
                          zeroExtend 32 (ofBool (x != 0#32))).sshiftRight'
                      (zeroExtend 32 (ofBool (x != 0#32))) ≠
                    20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32)) ∨
                True ∧
                    (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
                          zeroExtend 32 (ofBool (x != 0#32)) >>>
                        zeroExtend 32 (ofBool (x != 0#32)) ≠
                      20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32)) ∨
                  zeroExtend 32 (ofBool (x != 0#32)) ≥ ↑32) →
    (20#32 * (2#32 - zeroExtend 32 (ofBool (x == 0#32))) + (zeroExtend 32 (ofBool (x == 0#32)) ^^^ 1#32)) *
        (2#32 - zeroExtend 32 (ofBool (x == 0#32))) =
      (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
        zeroExtend 32 (ofBool (x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem src_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬(zeroExtend 32 x ≥ ↑32 ∨ zeroExtend 32 x ≥ ↑32) →
    True ∧ ((-1#32) <<< zeroExtend 32 x).sshiftRight' (zeroExtend 32 x) ≠ -1#32 ∨
        zeroExtend 32 x ≥ ↑32 ∨
          True ∧
              ((((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x) <<< zeroExtend 32 x).sshiftRight'
                  (zeroExtend 32 x) ≠
                ((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x ∨
            True ∧
                (((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x) <<< zeroExtend 32 x >>> zeroExtend 32 x ≠
                  ((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x ∨
              zeroExtend 32 x ≥ ↑32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#64 = 0 → truncate 32 (signExtend 64 (zeroExtend 32 x * 4#32) % 4#64) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 ∨ True ∧ (zeroExtend 64 (1#32 <<< x)).saddOverflow (-1#64) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test14_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 ∨ True ∧ (zeroExtend 64 (1#32 <<< x)).saddOverflow (-1#64) = true) →
      x_1 % zeroExtend 64 (1#32 <<< x) = x_1 &&& zeroExtend 64 (1#32 <<< x) + -1#64 :=
      by bv_generalize ; bv_multi_width
theorem test15_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    True ∧ ((-1#32) <<< x).sshiftRight' x ≠ -1#32 ∨ x ≥ ↑32 ∨ True ∧ (x_1 &&& ((-1#32) <<< x ^^^ -1#32)).msb = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test15_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    ¬(True ∧ ((-1#32) <<< x).sshiftRight' x ≠ -1#32 ∨ x ≥ ↑32 ∨ True ∧ (x_1 &&& ((-1#32) <<< x ^^^ -1#32)).msb = true) →
      zeroExtend 64 x_1 % zeroExtend 64 (1#32 <<< x) = zeroExtend 64 (x_1 &&& ((-1#32) <<< x ^^^ -1#32)) :=
      by bv_generalize ; bv_multi_width
theorem test17_thm.extracted_1._1 : ∀ (x : BitVec 32), ¬x = 0 → 1#32 % x = zeroExtend 32 (ofBool (x != 1#32)) :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(zeroExtend 32 x ≥ ↑32 ∨ 32#32 <<< zeroExtend 32 x = 0) →
    True ∧ x.msb = true ∨ True ∧ 32#32 <<< zeroExtend 32 x >>> zeroExtend 32 x ≠ 32#32 ∨ zeroExtend 32 x ≥ ↑32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(zeroExtend 32 x ≥ ↑32 ∨ 32#32 <<< zeroExtend 32 x = 0) →
    ¬(True ∧ x.msb = true ∨ True ∧ 32#32 <<< zeroExtend 32 x >>> zeroExtend 32 x ≠ 32#32 ∨ zeroExtend 32 x ≥ ↑32) →
      x_1 % 32#32 <<< zeroExtend 32 x = x_1 &&& 32#32 <<< zeroExtend 32 x + -1#32 :=
      by bv_generalize ; bv_multi_width
theorem rotateleft_9_neg_mask_wide_amount_commute_thm.extracted_1._1 : ∀ (x : BitVec 33) (x_1 : BitVec 9),
  ¬(x &&& 8#33 ≥ ↑33 ∨ 0#33 - x &&& 8#33 ≥ ↑33) →
    True ∧ (zeroExtend 33 x_1 <<< (x &&& 8#33)).sshiftRight' (x &&& 8#33) ≠ zeroExtend 33 x_1 ∨
        True ∧ zeroExtend 33 x_1 <<< (x &&& 8#33) >>> (x &&& 8#33) ≠ zeroExtend 33 x_1 ∨
          x &&& 8#33 ≥ ↑33 ∨ 0#33 - x &&& 8#33 ≥ ↑33 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_simplify_decrement_invalid_ne_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != 0#8) = 1#1 → 0#8 = signExtend 8 (ofBool (x == 0#8)) :=
      by bv_generalize ; bv_multi_width
theorem test_simplify_decrement_invalid_ne_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (x != 0#8) = 1#1 → x - 1#8 = signExtend 8 (ofBool (x == 0#8)) :=
      by bv_generalize ; bv_multi_width
theorem n2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(BitVec.ofInt 8 (-128) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-128) == -1) = true →
    x.sdiv (BitVec.ofInt 8 (-128)) = zeroExtend 8 (ofBool (x == BitVec.ofInt 8 (-128))) :=
      by bv_generalize ; bv_multi_width
theorem shrink_select_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → truncate 8 42#32 = 42#8 :=
      by bv_generalize ; bv_multi_width
theorem shrink_select_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1), ¬x_1 = 1#1 → truncate 8 42#32 = 42#8 :=
      by bv_generalize ; bv_multi_width
theorem sel_sext_constants_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → signExtend 16 (-1#8) = -1#16 :=
      by bv_generalize ; bv_multi_width
theorem sel_sext_constants_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → signExtend 16 42#8 = 42#16 :=
      by bv_generalize ; bv_multi_width
theorem sel_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → signExtend 64 42#32 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem sel_sext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1), ¬x_1 = 1#1 → signExtend 64 42#32 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem sel_zext_constants_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → zeroExtend 16 (-1#8) = 255#16 :=
      by bv_generalize ; bv_multi_width
theorem sel_zext_constants_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 16 42#8 = 42#16 :=
      by bv_generalize ; bv_multi_width
theorem sel_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 64 42#32 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem sel_zext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1), ¬x_1 = 1#1 → zeroExtend 64 42#32 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem sext_false_val_must_be_zero_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → signExtend 32 x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem sext_true_val_must_be_all_ones_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → signExtend 32 x = -1#32 :=
      by bv_generalize ; bv_multi_width
theorem test_sext1_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → 0#32 = signExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1), ¬x_1 = 1#1 → 0#32 = signExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext2_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → -1#32 = signExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1), x_1 = 1#1 → -1#32 = signExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext3_thm.extracted_1._2 : ∀ (x : BitVec 1), x = 1#1 → ¬x ^^^ 1#1 = 1#1 → 0#32 = signExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext3_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1), x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → 0#32 = signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test_sext3_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → 0#32 = signExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext3_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → signExtend 32 x = signExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext4_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → x ^^^ 1#1 = 1#1 → -1#32 = signExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext4_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → signExtend 32 x = signExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext4_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → -1#32 = signExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_sext4_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → -1#32 = signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test_zext1_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1), ¬x_1 = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext2_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1), x_1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext3_thm.extracted_1._2 : ∀ (x : BitVec 1), x = 1#1 → ¬x ^^^ 1#1 = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext3_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1), x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → 0#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test_zext3_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → 0#32 = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext3_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → zeroExtend 32 x = zeroExtend 32 0#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext4_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → x ^^^ 1#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext4_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → zeroExtend 32 x = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext4_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test_zext4_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → 1#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_equal_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → signExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_equal_sext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ x <<< 16#32 >>> 16#32 <<< 16#32 ≠ x <<< 16#32 ∨ 16#32 ≥ ↑32) →
      signExtend 32 (truncate 16 x) = (x <<< 16#32).sshiftRight' 16#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_equal_sext_thm.extracted_1._4 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_equal_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_equal_zext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → zeroExtend 32 (truncate 16 x) = x &&& 65535#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_equal_zext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → zeroExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_larger_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → signExtend 64 42#16 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_larger_sext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 64 42#16 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_larger_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 64 42#16 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_larger_zext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → ¬(True ∧ (x &&& 65535#32).msb = true) → zeroExtend 64 (truncate 16 x) = zeroExtend 64 (x &&& 65535#32) :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_larger_zext_thm.extracted_1._4 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → zeroExtend 64 42#16 = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_smaller_sext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → signExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_smaller_sext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_smaller_zext_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_smaller_zext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → zeroExtend 32 (truncate 16 x) = truncate 32 x &&& 65535#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_sel_smaller_zext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → zeroExtend 32 42#16 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem zext_false_val_must_be_zero_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 32 x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem zext_true_val_must_be_one_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → zeroExtend 32 x = 1#32 :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
          zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ofBool ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32 == 0#32) = 1#1 →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ofBool ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x = x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ¬ofBool ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
        2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
          False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ¬ofBool ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
        ¬(2#32 ≥ ↑32 ∨
              True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
                zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
          x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32)) =
            x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ofBool ((x_1 &&& 60#32) >>> 2#32 == 0#32) = 1#1 →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val2_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ofBool ((x_1 &&& 60#32) >>> 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val2_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ¬ofBool ((x_1 &&& 60#32) >>> 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
        2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 →
          False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_lshr_of_true_val2_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ¬ofBool ((x_1 &&& 60#32) >>> 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
        ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
          x.sshiftRight' (zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32)) =
            x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val1_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val1_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
          True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val1_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
          True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
        True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨ 2#32 ≥ ↑32) →
    ofBool ((x_1 &&& 15#32) <<< 2#32 == 0#32) = 1#1 →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val2_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
        True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨ 2#32 ≥ ↑32) →
    ofBool ((x_1 &&& 15#32) <<< 2#32 == 0#32) = 1#1 →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val2_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
        True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨ 2#32 ≥ ↑32) →
    ¬ofBool ((x_1 &&& 15#32) <<< 2#32 == 0#32) = 1#1 →
      ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
            True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
              2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
        2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 →
          False :=
      by bv_generalize ; bv_multi_width
theorem sel_false_val_is_a_masked_shl_of_true_val2_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
        True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨ 2#32 ≥ ↑32) →
    ¬ofBool ((x_1 &&& 15#32) <<< 2#32 == 0#32) = 1#1 →
      ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
            True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
              2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
        ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
          x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
            x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test35_with_trunc_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (0#32 ≤ₛ truncate 32 x) = 1#1 → ¬ofBool (x &&& 2147483648#64 == 0#64) = 1#1 → 60#32 = 100#32 :=
      by bv_generalize ; bv_multi_width
theorem test35_with_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬ofBool (0#32 ≤ₛ truncate 32 x) = 1#1 → ofBool (x &&& 2147483648#64 == 0#64) = 1#1 → 100#32 = 60#32 :=
      by bv_generalize ; bv_multi_width
theorem test73_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → ¬ofBool (x &&& 128#32 == 0#32) = 1#1 → 40#32 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem test73_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → ofBool (x &&& 128#32 == 0#32) = 1#1 → 42#32 = 40#32 :=
      by bv_generalize ; bv_multi_width
theorem thisdoesnotloop_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ BitVec.ofInt 32 (-128)) = 1#1 → truncate 8 128#32 = BitVec.ofInt 8 (-128) :=
      by bv_generalize ; bv_multi_width
theorem thisdoesnotloop_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ₛ BitVec.ofInt 32 (-128)) = 1#1 → truncate 8 128#32 = BitVec.ofInt 8 (-128) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
          zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_unsafe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
          zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_unsafe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_unsafe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr__exact_is_unsafe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
          zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2147483588)) >>> 2#32 <<< 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2147483588) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2147483588)) >>> 2#32 <<< 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2147483588) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_unsafe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
          zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_unsafe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_unsafe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2147483585)) >>> 2#32 <<< 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2147483585) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_ashr_exact__exact_is_unsafe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2147483585)) >>> 2#32 <<< 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2147483585) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_unsafe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_unsafe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_unsafe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr__exact_is_unsafe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 60#32) >>> 2#32 <<< 2#32 ≠ x_1 &&& 60#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 60#32) >>> 2#32 <<< 2#32 ≠ x_1 &&& 60#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_unsafe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_unsafe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_unsafe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 63#32) >>> 2#32 <<< 2#32 ≠ x_1 &&& 63#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_lshr_exact__exact_is_unsafe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 63#32) >>> 2#32 <<< 2#32 ≠ x_1 &&& 63#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl__all_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl__all_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl__all_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl__all_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl__none_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl__none_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl__none_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl__nuw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl__nuw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl__nuw_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__all_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__all_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__all_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__all_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__none_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__none_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__none_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__nuw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__nuw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 1073741822#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 1073741822#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nsw__nuw_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 1073741822#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 1073741822#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__all_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__all_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__all_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__all_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__none_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__none_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32 >>> 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__none_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32 >>> 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__nuw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__nuw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 1073741822#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 1073741822#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw__nuw_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 1073741822#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 1073741822#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__all_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__all_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__all_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
          True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__all_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 15#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 15#32 ∨
          True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__none_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__none_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          True ∧ (x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32 >>> 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__none_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          True ∧ (x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32 >>> 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__nuw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    2#32 ≥ ↑32 ∨
        True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
          zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__nuw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 1073741822#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 1073741822#32 ∨
          True ∧ (x_1 &&& 1073741822#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 1073741822#32 ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
      by bv_generalize ; bv_multi_width
theorem test_shl_nuw_nsw__nuw_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 1073741822#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 1073741822#32 ∨
          True ∧ (x_1 &&& 1073741822#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 1073741822#32 ∨
            2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
      by bv_generalize ; bv_multi_width
theorem and_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 2#32 == 0#32) = 1#1 → x &&& 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem and_and_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2#32 == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem and_lshr_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) = 1#1 → ¬1#32 ≥ ↑32 → x >>> 1#32 &&& 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem and_lshr_and_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var0_commutative_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 →
    ¬1#32 ≥ ↑32 → x >>> 1#32 &&& 1#32 = zeroExtend 32 (ofBool (x &&& (x_1 ||| 2#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var0_commutative_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& (x_1 ||| 2#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 →
    ¬1#32 ≥ ↑32 → x_1 >>> 1#32 &&& 1#32 = zeroExtend 32 (ofBool (x_1 &&& (x ||| 2#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var0_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& (x ||| 2#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var1_commutative_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 → x &&& 1#32 = zeroExtend 32 (ofBool (x &&& (x_1 ||| 1#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var1_commutative_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& (x_1 ||| 1#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 → x_1 &&& 1#32 = zeroExtend 32 (ofBool (x_1 &&& (x ||| 1#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem f_var1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& (x ||| 1#32) != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_eq_0_and_1_or_1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ofBool (x_1 &&& 1#64 == 0#64) = 1#1 → x = x ||| truncate 32 x_1 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_eq_0_and_1_or_1_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬ofBool (x_1 &&& 1#64 == 0#64) = 1#1 → x ||| 1#32 = x ||| truncate 32 x_1 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_eq_0_and_1_xor_1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ofBool (x_1 &&& 1#64 == 0#64) = 1#1 → x = x ^^^ truncate 32 x_1 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_eq_0_and_1_xor_1_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬ofBool (x_1 &&& 1#64 == 0#64) = 1#1 → x ^^^ 1#32 = x ^^^ truncate 32 x_1 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_x_and_8_eq_0_y_xor_8_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 8#32 == 0#32) = 1#1 → ¬(True ∧ (x_1 &&& 8#32).msb = true) → x = x ^^^ zeroExtend 64 (x_1 &&& 8#32) :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_x_and_8_eq_0_y_xor_8_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 8#32).msb = true) → x ^^^ 8#64 = x ^^^ zeroExtend 64 (x_1 &&& 8#32) :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_x_and_8_ne_0_y_or_8_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 8#32 ^^^ 8#32).msb = true) → x ||| 8#64 = x ||| zeroExtend 64 (x_1 &&& 8#32 ^^^ 8#32) :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_x_and_8_ne_0_y_or_8_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 8#32 ^^^ 8#32).msb = true) → x = x ||| zeroExtend 64 (x_1 &&& 8#32 ^^^ 8#32) :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_x_and_8_ne_0_y_xor_8_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 8#32 ^^^ 8#32).msb = true) → x ^^^ 8#64 = x ^^^ zeroExtend 64 (x_1 &&& 8#32 ^^^ 8#32) :=
      by bv_generalize ; bv_multi_width
theorem select_icmp_x_and_8_ne_0_y_xor_8_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 8#32 ^^^ 8#32).msb = true) → x = x ^^^ zeroExtend 64 (x_1 &&& 8#32 ^^^ 8#32) :=
      by bv_generalize ; bv_multi_width
theorem xor_i8_to_i64_shl_save_and_ne_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 8),
  ofBool (x_1 &&& 1#8 != 0#8) = 1#1 →
    ¬63#64 ≥ ↑64 → x ^^^ BitVec.ofInt 64 (-9223372036854775808) = x ^^^ zeroExtend 64 x_1 <<< 63#64 :=
      by bv_generalize ; bv_multi_width
theorem xor_i8_to_i64_shl_save_and_ne_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 8),
  ¬ofBool (x_1 &&& 1#8 != 0#8) = 1#1 → ¬63#64 ≥ ↑64 → x = x ^^^ zeroExtend 64 x_1 <<< 63#64 :=
      by bv_generalize ; bv_multi_width
theorem PR2844_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) = 1#1 →
    True → 0#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem PR2844_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) = 1#1 →
    ¬True → 0#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem PR2844_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x == 0#32) = 1#1 →
    ofBool (x <ₛ BitVec.ofInt 32 (-638208501)) = 1#1 →
      0#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem PR2844_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x == 0#32) = 1#1 →
    ¬ofBool (x <ₛ BitVec.ofInt 32 (-638208501)) = 1#1 →
      1#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem PR2844_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) ||| ofBool (x <ₛ BitVec.ofInt 32 (-638208501)) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem PR2844_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x == 0#32) ||| ofBool (x <ₛ BitVec.ofInt 32 (-638208501)) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem test19_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 32 x_1 == zeroExtend 32 x) = x_1 ^^^ x ^^^ 1#1 :=
      by bv_generalize ; bv_multi_width
theorem test20_thm.extracted_1._1 : ∀ (x : BitVec 32), zeroExtend 32 (ofBool (x &&& 1#32 != 0#32)) = x &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem test21_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬2#32 ≥ ↑32 → zeroExtend 32 (ofBool (x &&& 4#32 != 0#32)) = x >>> 2#32 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem test23_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x &&& 1#32 == 0#32)) = x &&& 1#32 ^^^ 1#32 :=
      by bv_generalize ; bv_multi_width
theorem test24_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬2#32 ≥ ↑32 → zeroExtend 32 (ofBool ((x &&& 4#32) >>> 2#32 == 0#32)) = x >>> 2#32 &&& 1#32 ^^^ 1#32 :=
      by bv_generalize ; bv_multi_width
theorem smear_set_bit_different_dest_type_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    24#32 ≥ ↑32 ∨
        31#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 16 ((x <<< 24#32).sshiftRight' 31#32)) ≠ (x <<< 24#32).sshiftRight' 31#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem smear_set_bit_different_dest_type_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨
          31#32 ≥ ↑32 ∨
            True ∧ signExtend 32 (truncate 16 ((x <<< 24#32).sshiftRight' 31#32)) ≠ (x <<< 24#32).sshiftRight' 31#32) →
      signExtend 16 ((truncate 8 x).sshiftRight' 7#8) = truncate 16 ((x <<< 24#32).sshiftRight' 31#32) :=
      by bv_generalize ; bv_multi_width
theorem smear_set_bit_different_dest_type_wider_dst_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) →
      signExtend 64 ((truncate 8 x).sshiftRight' 7#8) = signExtend 64 ((x <<< 24#32).sshiftRight' 31#32) :=
      by bv_generalize ; bv_multi_width
theorem smear_set_bit_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → signExtend 32 ((truncate 8 x).sshiftRight' 7#8) = (x <<< 24#32).sshiftRight' 31#32 :=
      by bv_generalize ; bv_multi_width
theorem test10_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 6#8 ≥ ↑8) →
    ¬(30#32 ≥ ↑32 ∨ True ∧ x <<< 30#32 >>> 30#32 <<< 30#32 ≠ x <<< 30#32 ∨ 30#32 ≥ ↑32) →
      signExtend 32 ((truncate 8 x <<< 6#8).sshiftRight' 6#8) = (x <<< 30#32).sshiftRight' 30#32 :=
      by bv_generalize ; bv_multi_width
theorem test13_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ True ∧ (x >>> 3#32 &&& 1#32).saddOverflow (-1#32) = true) →
    signExtend 32 (ofBool (x &&& 8#32 == 0#32)) = (x >>> 3#32 &&& 1#32) + -1#32 :=
      by bv_generalize ; bv_multi_width
theorem test14_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(4#16 ≥ ↑16 ∨ True ∧ (x >>> 4#16 &&& 1#16).saddOverflow (-1#16) = true) →
    signExtend 32 (ofBool (x &&& 16#16 != 16#16)) = signExtend 32 ((x >>> 4#16 &&& 1#16) + -1#16) :=
      by bv_generalize ; bv_multi_width
theorem test15_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(27#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → signExtend 32 (ofBool (x &&& 16#32 != 0#32)) = (x <<< 27#32).sshiftRight' 31#32 :=
      by bv_generalize ; bv_multi_width
theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(12#16 ≥ ↑16 ∨ 15#16 ≥ ↑16) →
    signExtend 32 (ofBool (x &&& 8#16 == 8#16)) = signExtend 32 ((x <<< 12#16).sshiftRight' 15#16) :=
      by bv_generalize ; bv_multi_width
theorem test17_thm.extracted_1._1 : ∀ (x : BitVec 1), 0#32 - signExtend 32 x = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test19_thm.extracted_1._1 : ∀ (x : BitVec 10),
  ¬(2#3 ≥ ↑3 ∨ 2#3 ≥ ↑3) → True ∧ (0#3).ssubOverflow (truncate 3 x &&& 1#3) = true → False :=
      by bv_generalize ; bv_multi_width
theorem test19_thm.extracted_1._2 : ∀ (x : BitVec 10),
  ¬(2#3 ≥ ↑3 ∨ 2#3 ≥ ↑3) →
    ¬(True ∧ (0#3).ssubOverflow (truncate 3 x &&& 1#3) = true) →
      signExtend 10 ((truncate 3 x <<< 2#3).sshiftRight' 2#3) = signExtend 10 (0#3 - (truncate 3 x &&& 1#3)) :=
      by bv_generalize ; bv_multi_width
theorem test4_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬3#32 = 0 → ¬(3#32 = 0 ∨ True ∧ (x / 3#32).msb = true) → signExtend 64 (x / 3#32) = zeroExtend 64 (x / 3#32) :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬30000#32 = 0 →
    ¬(30000#32 = 0 ∨ True ∧ (x % 30000#32).msb = true) → signExtend 64 (x % 30000#32) = zeroExtend 64 (x % 30000#32) :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬3#32 ≥ ↑32 →
    ¬(3#32 ≥ ↑32 ∨
          True ∧ (x >>> 3#32).smulOverflow 3#32 = true ∨
            True ∧ (x >>> 3#32).umulOverflow 3#32 = true ∨ True ∧ (x >>> 3#32 * 3#32).msb = true) →
      signExtend 64 (x >>> 3#32 * 3#32) = zeroExtend 64 (x >>> 3#32 * 3#32) :=
      by bv_generalize ; bv_multi_width
theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (20000#32).ssubOverflow (x &&& 511#32) = true ∨
        True ∧ (20000#32).usubOverflow (x &&& 511#32) = true ∨ True ∧ (20000#32 - (x &&& 511#32)).msb = true) →
    signExtend 64 (20000#32 - (x &&& 511#32)) = zeroExtend 64 (20000#32 - (x &&& 511#32)) :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) != 1#32) = ofBool (x &&& BitVec.ofInt 8 (-127) != 1#8) :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 1073741826#32 == 2#32) = ofBool (x &&& BitVec.ofInt 8 (-126) == 2#8) :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 1073741826#32 != 2#32) = ofBool (x &&& BitVec.ofInt 8 (-126) != 2#8) :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) == 1#32) = ofBool (x &&& BitVec.ofInt 8 (-127) == 1#8) :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-256) != 1#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) == 128#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 128#32 == BitVec.ofInt 32 (-2147483648)) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong4_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 128#32 == 1#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong5_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-256) == 1#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong6_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) != -1#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong7_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) != 128#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 128#32 != BitVec.ofInt 32 (-2147483648)) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong9_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 128#32 != 1#32) = 1#1 :=
      by bv_generalize ; bv_multi_width
theorem fold_sext_to_and_wrong_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) == -1#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem narrow_source_matching_signbits_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨ x &&& 7#32 ≥ ↑32) →
    signExtend 64 (truncate 8 ((-1#32) <<< (x &&& 7#32))) = signExtend 64 ((-1#32) <<< (x &&& 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem same_source_matching_signbits_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨ x &&& 7#32 ≥ ↑32) →
    signExtend 32 (truncate 8 ((-1#32) <<< (x &&& 7#32))) = (-1#32) <<< (x &&& 7#32) :=
      by bv_generalize ; bv_multi_width
theorem same_source_not_matching_signbits_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 8#32)).sshiftRight' (x &&& 8#32) ≠ -1#32 ∨ x &&& 8#32 ≥ ↑32) →
    ¬(x &&& 8#32 ≥ ↑32 ∨
          True ∧
              BitVec.ofInt 32 (-16777216) <<< (x &&& 8#32) >>> 24#32 <<< 24#32 ≠
                BitVec.ofInt 32 (-16777216) <<< (x &&& 8#32) ∨
            24#32 ≥ ↑32) →
      signExtend 32 (truncate 8 ((-1#32) <<< (x &&& 8#32))) =
        (BitVec.ofInt 32 (-16777216) <<< (x &&& 8#32)).sshiftRight' 24#32 :=
      by bv_generalize ; bv_multi_width
theorem wide_source_matching_signbits_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨ x &&& 7#32 ≥ ↑32) →
    True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨
        x &&& 7#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 ((-1#32) <<< (x &&& 7#32))) ≠ (-1#32) <<< (x &&& 7#32) →
      False :=
      by bv_generalize ; bv_multi_width
theorem wide_source_matching_signbits_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨ x &&& 7#32 ≥ ↑32) →
    ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨
          x &&& 7#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 ((-1#32) <<< (x &&& 7#32))) ≠ (-1#32) <<< (x &&& 7#32)) →
      signExtend 24 (truncate 8 ((-1#32) <<< (x &&& 7#32))) = truncate 24 ((-1#32) <<< (x &&& 7#32)) :=
      by bv_generalize ; bv_multi_width
theorem ashr_16_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 → (zeroExtend 32 x_1 + zeroExtend 32 x) >>> 16#32 = zeroExtend 32 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem ashr_16_to_64_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#64 ≥ ↑64 →
    (zeroExtend 64 x_1 + zeroExtend 64 x).sshiftRight' 16#64 = zeroExtend 64 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem ashr_2_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 → True ∧ (zeroExtend 2 x_1).uaddOverflow (zeroExtend 2 x) = true ∨ 1#2 ≥ ↑2 → False :=
      by bv_generalize ; bv_multi_width
theorem ashr_32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 →
    (zeroExtend 64 x_1 + zeroExtend 64 x).sshiftRight' 32#64 = zeroExtend 64 (ofBool (x_1 ^^^ -1#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem lshr_16_add_zext_basic_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x_1).saddOverflow (zeroExtend 32 x) = true ∨
        True ∧ (zeroExtend 32 x_1).uaddOverflow (zeroExtend 32 x) = true ∨ 16#32 ≥ ↑32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem lshr_16_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 → (zeroExtend 32 x_1 + zeroExtend 32 x) >>> 16#32 = zeroExtend 32 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem lshr_16_to_64_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#64 ≥ ↑64 → (zeroExtend 64 x_1 + zeroExtend 64 x) >>> 16#64 = zeroExtend 64 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem lshr_2_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 → (zeroExtend 2 x_1 + zeroExtend 2 x) >>> 1#2 = zeroExtend 2 (x_1 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem lshr_31_i32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#64 ≥ ↑64 →
    True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
        True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true ∨ 31#64 ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem lshr_32_add_zext_basic_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 →
    True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
        True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true ∨ 32#64 ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem lshr_32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 → (zeroExtend 64 x_1 + zeroExtend 64 x) >>> 32#64 = zeroExtend 64 (ofBool (x_1 ^^^ -1#32 <ᵤ x)) :=
      by bv_generalize ; bv_multi_width
theorem lshr_32_add_zext_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 →
    truncate 32 (zeroExtend 64 x_1 + zeroExtend 64 x) + truncate 32 ((zeroExtend 64 x_1 + zeroExtend 64 x) >>> 32#64) =
      x_1 + x + zeroExtend 32 (ofBool (x_1 + x <ᵤ x_1)) :=
      by bv_generalize ; bv_multi_width
theorem lshr_33_i32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬33#64 ≥ ↑64 → (zeroExtend 64 x_1 + zeroExtend 64 x) >>> 33#64 = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem shl_C1_add_A_C2_i32_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬zeroExtend 32 x + 5#32 ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem shl_C1_add_A_C2_i32_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬zeroExtend 32 x + 5#32 ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) → 6#32 <<< (zeroExtend 32 x + 5#32) = 192#32 <<< zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem shl_C1_add_A_C2_i32_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬zeroExtend 32 x + 5#32 ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem shl_C1_add_A_C2_i32_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬zeroExtend 32 x + 5#32 ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) → 6#32 <<< (zeroExtend 32 x + 5#32) = 192#32 <<< zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem n0_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    32#32 - x_1 ≥ ↑32 ∨
        True ∧ (x_1 + BitVec.ofInt 32 (-16)).msb = true ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem n2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    32#32 - x_1 ≥ ↑32 ∨
        True ∧ (x_1 + BitVec.ofInt 32 (-16)).msb = true ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem n4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    32#32 - x ≥ ↑32 ∨
        True ∧ (x + BitVec.ofInt 32 (-16)).msb = true ∨
          zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64 ∨
            True ∧
                signExtend 64 (truncate 32 (262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)))) ≠
                  262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ∨
              True ∧
                zeroExtend 64 (truncate 32 (262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)))) ≠
                  262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)) →
      False :=
      by bv_generalize ; bv_multi_width
theorem rawspeed_signbit_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(True ∧ x_1.saddOverflow (-1#32) = true ∨
        x_1 + -1#32 ≥ ↑32 ∨ True ∧ (64#32).ssubOverflow x_1 = true ∨ zeroExtend 64 (64#32 - x_1) ≥ ↑64) →
    ofBool (1#32 <<< (x_1 + -1#32) &&& truncate 32 (x >>> zeroExtend 64 (64#32 - x_1)) == 0#32) = ofBool (-1#64 <ₛ x) :=
      by bv_generalize ; bv_multi_width
theorem t10_almost_highest_bit_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-2)) ≥ ↑64) →
    64#32 - x_1 ≥ ↑32 ∨
        True ∧ (x_1 + BitVec.ofInt 32 (-2)).msb = true ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-2)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem t10_shift_by_one_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-63)) ≥ ↑64) →
    64#32 - x_1 ≥ ↑32 ∨
        True ∧ (x_1 + BitVec.ofInt 32 (-63)).msb = true ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-63)) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem t11_no_shift_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-64)) ≥ ↑64) →
    ofBool (x_2 <<< (64#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-64))) != 0#32) =
      ofBool (x &&& zeroExtend 64 x_2 != 0#64) :=
      by bv_generalize ; bv_multi_width
theorem t13_x_is_one_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (1#32 <<< (32#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x &&& 65536#64 != 0#64) :=
      by bv_generalize ; bv_multi_width
theorem t14_x_is_one_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (x_1 <<< (32#32 - x) &&& truncate 32 (1#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16))) != 0#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem t1_single_bit_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (32768#32 <<< (32#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x &&& 2147483648#64 != 0#64) :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (65535#32 <<< (32#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x &&& 4294901760#64 != 0#64) :=
      by bv_generalize ; bv_multi_width
theorem t3_singlebit_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (x_1 <<< (32#32 - x) &&& truncate 32 (65536#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x_1 &&& 1#32 != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem t3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (x_1 <<< (32#32 - x) &&& truncate 32 (131071#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x_1 &&& 1#32 != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem t9_highest_bit_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + -1#32) ≥ ↑64) → 63#64 ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem t9_highest_bit_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + -1#32) ≥ ↑64) →
    ¬63#64 ≥ ↑64 →
      ofBool (x_2 <<< (64#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + -1#32)) != 0#32) =
        ofBool (x >>> 63#64 &&& zeroExtend 64 x_2 != 0#64) :=
      by bv_generalize ; bv_multi_width
theorem n13_overshift_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + 32#32) ≥ ↑64) →
    32#32 - x_1 ≥ ↑32 ∨ True ∧ (x_1 + 32#32).msb = true ∨ zeroExtend 64 (x_1 + 32#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem n14_trunc_of_lshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(zeroExtend 64 (32#32 - x_1) ≥ ↑64 ∨ x_1 + -1#32 ≥ ↑32) →
    x_1 + -1#32 ≥ ↑32 ∨ True ∧ (32#32 - x_1).msb = true ∨ zeroExtend 64 (32#32 - x_1) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem n14_trunc_of_lshr_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(zeroExtend 64 (32#32 - x_1) ≥ ↑64 ∨ x_1 + -1#32 ≥ ↑32) →
    ¬(x_1 + -1#32 ≥ ↑32 ∨ True ∧ (32#32 - x_1).msb = true ∨ zeroExtend 64 (32#32 - x_1) ≥ ↑64) →
      ofBool (truncate 32 (x_2 >>> zeroExtend 64 (32#32 - x_1)) &&& x <<< (x_1 + -1#32) != 0#32) =
        ofBool (x <<< (x_1 + -1#32) &&& truncate 32 (x_2 >>> zeroExtend 64 (32#32 - x_1)) != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem n15_variable_shamts_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 64),
  ¬(x_2 ≥ ↑64 ∨ x ≥ ↑32) →
    ¬(x ≥ ↑32 ∨ x_2 ≥ ↑64) →
      ofBool (truncate 32 (x_3 <<< x_2) &&& x_1 >>> x != 0#32) =
        ofBool (x_1 >>> x &&& truncate 32 (x_3 <<< x_2) != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem t0_const_after_fold_lshr_shl_ne_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + -1#32) ≥ ↑64) → 31#32 ≥ ↑32 ∨ True ∧ (x_2 >>> 31#32).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem t0_const_after_fold_lshr_shl_ne_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + -1#32) ≥ ↑64) →
    ¬(31#32 ≥ ↑32 ∨ True ∧ (x_2 >>> 31#32).msb = true) →
      ofBool (x_2 >>> (32#32 - x_1) &&& truncate 32 (x <<< zeroExtend 64 (x_1 + -1#32)) != 0#32) =
        ofBool (x &&& zeroExtend 64 (x_2 >>> 31#32) != 0#64) :=
      by bv_generalize ; bv_multi_width
theorem t10_constants_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 14#64 ≥ ↑64) →
    ¬26#32 ≥ ↑32 →
      ofBool (x_1 >>> 12#32 &&& truncate 32 (x <<< 14#64) != 0#32) = ofBool (x_1 >>> 26#32 &&& truncate 32 x != 0#32) :=
      by bv_generalize ; bv_multi_width
theorem n10_lshr_ashr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    True ∧ (32#16 - x).msb = true ∨ zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    31#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 16 (x_1.sshiftRight' 31#32)) ≠ x_1.sshiftRight' 31#32 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    ¬(31#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 16 (x_1.sshiftRight' 31#32)) ≠ x_1.sshiftRight' 31#32) →
      (truncate 16 (x_1.sshiftRight' (zeroExtend 32 (32#16 - x)))).sshiftRight' (x + -1#16) =
        truncate 16 (x_1.sshiftRight' 31#32) :=
      by bv_generalize ; bv_multi_width
theorem t9_ashr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-2) ≥ ↑16) →
    True ∧ (32#16 - x).msb = true ∨ zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-2) ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem n10_ashr_lshr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    True ∧ (32#16 - x).msb = true ∨ zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    31#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 16 (x_1 >>> 31#32)) ≠ x_1 >>> 31#32 ∨
          True ∧ zeroExtend 32 (truncate 16 (x_1 >>> 31#32)) ≠ x_1 >>> 31#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    ¬(31#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 16 (x_1 >>> 31#32)) ≠ x_1 >>> 31#32 ∨
            True ∧ zeroExtend 32 (truncate 16 (x_1 >>> 31#32)) ≠ x_1 >>> 31#32) →
      truncate 16 (x_1 >>> zeroExtend 32 (32#16 - x)) >>> (x + -1#16) = truncate 16 (x_1 >>> 31#32) :=
      by bv_generalize ; bv_multi_width
theorem t9_lshr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-2) ≥ ↑16) →
    True ∧ (32#16 - x).msb = true ∨ zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-2) ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem n11_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16) →
    True ∧ (30#16 - x).msb = true ∨ zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-24) ≥ ↑16) → 8#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-24) ≥ ↑16) →
    ¬8#16 ≥ ↑16 →
      truncate 16 (x_1 <<< zeroExtend 32 (32#16 - x)) <<< (x + BitVec.ofInt 16 (-24)) = truncate 16 x_1 <<< 8#16 :=
      by bv_generalize ; bv_multi_width
theorem t0_shl_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_shl_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) → x_1 <<< signExtend 32 x = x_1 <<< zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem t1_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem t1_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) → x_1 >>> signExtend 32 x = x_1 >>> zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem t2_ashr_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem t2_ashr_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) →
      x_1.sshiftRight' (signExtend 32 x) = x_1.sshiftRight' (zeroExtend 32 x) :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_bigger_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 3#24 ≥ ↑24) →
    9#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 (x.sshiftRight' 9#32)) ≠ x.sshiftRight' 9#32 → False :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_bigger_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 3#24 ≥ ↑24) →
    ¬(9#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 (x.sshiftRight' 9#32)) ≠ x.sshiftRight' 9#32) →
      truncate 24 (x.sshiftRight' 12#32) <<< 3#24 = truncate 24 (x.sshiftRight' 9#32) &&& BitVec.ofInt 24 (-8) :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_bigger_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 3#8 ≥ ↑8) →
    ¬2#32 ≥ ↑32 → truncate 8 (x >>> 5#32) <<< 3#8 = truncate 8 (x >>> 2#32) &&& BitVec.ofInt 8 (-8) :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_bigger_shl_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(4#32 ≥ ↑32 ∨ 2#8 ≥ ↑8) → ¬6#8 ≥ ↑8 → truncate 8 (x <<< 4#32) <<< 2#8 = truncate 8 x <<< 6#8 :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_smaller_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(10#32 ≥ ↑32 ∨ 13#24 ≥ ↑24) →
    ¬3#24 ≥ ↑24 → truncate 24 (x.sshiftRight' 10#32) <<< 13#24 = truncate 24 x <<< 3#24 &&& BitVec.ofInt 24 (-8192) :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_smaller_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 5#8 ≥ ↑8) →
    ¬2#8 ≥ ↑8 → truncate 8 (x >>> 3#32) <<< 5#8 = truncate 8 x <<< 2#8 &&& BitVec.ofInt 8 (-32) :=
      by bv_generalize ; bv_multi_width
theorem shl_trunc_smaller_shl_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ 4#8 ≥ ↑8) → ¬6#8 ≥ ↑8 → truncate 8 (x <<< 2#32) <<< 4#8 = truncate 8 x <<< 6#8 :=
      by bv_generalize ; bv_multi_width
theorem hoist_ashr_ahead_of_sext_1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#32 ≥ ↑32 → ¬3#8 ≥ ↑8 → (signExtend 32 x).sshiftRight' 3#32 = signExtend 32 (x.sshiftRight' 3#8) :=
      by bv_generalize ; bv_multi_width
theorem hoist_ashr_ahead_of_sext_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 → ¬7#8 ≥ ↑8 → (signExtend 32 x).sshiftRight' 8#32 = signExtend 32 (x.sshiftRight' 7#8) :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬zeroExtend 32 x ≥ ↑32 → True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬zeroExtend 32 x ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) →
      x_1.sshiftRight' (zeroExtend 32 x) &&& 1#32 = x_1 >>> zeroExtend 32 x &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x).saddOverflow 7#32 = true ∨ True ∧ (zeroExtend 32 x).uaddOverflow 7#32 = true ∨ 3#32 ≥ ↑32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#32 ≥ ↑32 →
    ¬(True ∧ (zeroExtend 32 x).saddOverflow 7#32 = true ∨
          True ∧ (zeroExtend 32 x).uaddOverflow 7#32 = true ∨ 3#32 ≥ ↑32) →
      (zeroExtend 32 x + 7#32).sshiftRight' 3#32 = (zeroExtend 32 x + 7#32) >>> 3#32 :=
      by bv_generalize ; bv_multi_width
theorem f_t15_t01_t09_thm.extracted_1._1 : ∀ (x : BitVec 40),
  ¬(31#40 ≥ ↑40 ∨ 16#32 ≥ ↑32) →
    15#40 ≥ ↑40 ∨ True ∧ signExtend 40 (truncate 32 (x.sshiftRight' 15#40)) ≠ x.sshiftRight' 15#40 → False :=
      by bv_generalize ; bv_multi_width
theorem f_t15_t01_t09_thm.extracted_1._2 : ∀ (x : BitVec 40),
  ¬(31#40 ≥ ↑40 ∨ 16#32 ≥ ↑32) →
    ¬(15#40 ≥ ↑40 ∨ True ∧ signExtend 40 (truncate 32 (x.sshiftRight' 15#40)) ≠ x.sshiftRight' 15#40) →
      truncate 32 (x.sshiftRight' 31#40) <<< 16#32 = truncate 32 (x.sshiftRight' 15#40) &&& BitVec.ofInt 32 (-65536) :=
      by bv_generalize ; bv_multi_width
theorem must_drop_poison_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& 255#32) <<< x).sshiftRight' x ≠ x_1 &&& 255#32 ∨
        True ∧ (x_1 &&& 255#32) <<< x >>> x ≠ x_1 &&& 255#32 ∨ x ≥ ↑32) →
    ¬x ≥ ↑32 → truncate 8 ((x_1 &&& 255#32) <<< x) = truncate 8 (x_1 <<< x) :=
      by bv_generalize ; bv_multi_width
theorem sext_shl_mask_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬x ≥ ↑32 → signExtend 32 x_1 <<< x &&& 65535#32 = zeroExtend 32 x_1 <<< x &&& 65535#32 :=
      by bv_generalize ; bv_multi_width
theorem sext_shl_trunc_same_size_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬x ≥ ↑32 → truncate 16 (signExtend 32 x_1 <<< x) = truncate 16 (zeroExtend 32 x_1 <<< x) :=
      by bv_generalize ; bv_multi_width
theorem sext_shl_trunc_smaller_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬x ≥ ↑32 → truncate 5 (signExtend 32 x_1 <<< x) = truncate 5 (zeroExtend 32 x_1 <<< x) :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), truncate 8 (zeroExtend 64 x_1 + zeroExtend 64 x) = x_1 + x :=
      by bv_generalize ; bv_multi_width
theorem test2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16), truncate 16 (zeroExtend 64 x_1 + zeroExtend 64 x) = x_1 + x :=
      by bv_generalize ; bv_multi_width
theorem test3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32), truncate 32 (zeroExtend 64 x_1 + zeroExtend 64 x) = x_1 + x :=
      by bv_generalize ; bv_multi_width
theorem test4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
      True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true →
    False :=
      by bv_generalize ; bv_multi_width
theorem scalar_zext_slt_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (zeroExtend 32 x <ₛ 500#32) = ofBool (x <ᵤ 500#16) :=
      by bv_generalize ; bv_multi_width
theorem negative_trunc_not_arg_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → ofBool (x &&& 128#32 == 0#32) = 1#1 → False :=
      by bv_generalize ; bv_multi_width
theorem negative_trunc_not_arg_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x_1) = 1#1 →
    ¬ofBool (x_1 &&& 128#32 == 0#32) = 1#1 → ofBool (x + 128#32 <ᵤ 256#32) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem negative_trunc_not_arg_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (-1#8 <ₛ truncate 8 x_1) = 1#1 →
    ofBool (x_1 &&& 128#32 == 0#32) = 1#1 → 0#1 = ofBool (x + 128#32 <ᵤ 256#32) :=
      by bv_generalize ; bv_multi_width
theorem negative_trunc_not_arg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x_1) &&& ofBool (x + 128#32 <ᵤ 256#32) =
    ofBool (x_1 &&& 128#32 == 0#32) &&& ofBool (x + 128#32 <ᵤ 256#32) :=
      by bv_generalize ; bv_multi_width
theorem positive_different_trunc_both_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#15 <ₛ truncate 15 x) = 1#1 →
    ¬ofBool (x &&& 16384#32 == 0#32) = 1#1 → ofBool (truncate 16 x + 128#16 <ᵤ 256#16) = 0#1 :=
      by bv_generalize ; bv_multi_width
theorem positive_different_trunc_both_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#15 <ₛ truncate 15 x) = 1#1 →
    ofBool (x &&& 16384#32 == 0#32) = 1#1 → 0#1 = ofBool (truncate 16 x + 128#16 <ᵤ 256#16) :=
      by bv_generalize ; bv_multi_width
theorem positive_different_trunc_both_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#15 <ₛ truncate 15 x) &&& ofBool (truncate 16 x + 128#16 <ᵤ 256#16) =
    ofBool (x &&& 16384#32 == 0#32) &&& ofBool (truncate 16 x + 128#16 <ᵤ 256#16) :=
      by bv_generalize ; bv_multi_width
theorem positive_trunc_base_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#16 <ₛ truncate 16 x) = 1#1 → ofBool (truncate 16 x + 128#16 <ᵤ 256#16) = ofBool (x &&& 65408#32 == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem positive_trunc_base_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#16 <ₛ truncate 16 x) = 1#1 → 0#1 = ofBool (x &&& 65408#32 == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem positive_trunc_base_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#16 <ₛ truncate 16 x) &&& ofBool (truncate 16 x + 128#16 <ᵤ 256#16) = ofBool (x &&& 65408#32 == 0#32) :=
      by bv_generalize ; bv_multi_width
theorem positive_trunc_signbit_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → ofBool (x + 128#32 <ᵤ 256#32) = ofBool (x <ᵤ 128#32) :=
      by bv_generalize ; bv_multi_width
theorem positive_trunc_signbit_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → 0#1 = ofBool (x <ᵤ 128#32) :=
      by bv_generalize ; bv_multi_width
theorem positive_trunc_signbit_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x) &&& ofBool (x + 128#32 <ᵤ 256#32) = ofBool (x <ᵤ 128#32) :=
      by bv_generalize ; bv_multi_width
theorem sext_thm.extracted_1._1 : ∀ (x : BitVec 16),
  (zeroExtend 32 x ^^^ 32768#32) + BitVec.ofInt 32 (-32768) = signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) → (zeroExtend 32 x <<< 16#32).sshiftRight' 16#32 = signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem signed_sign_bit_extract_trunc_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ofBool (truncate 32 (x.sshiftRight' 63#64) != 0#32) = ofBool (x <ₛ 0#64) :=
      by bv_generalize ; bv_multi_width
theorem unsigned_sign_bit_extract_with_trunc_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ofBool (truncate 32 (x >>> 63#64) != 0#32) = ofBool (x <ₛ 0#64) :=
      by bv_generalize ; bv_multi_width
theorem n2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬15#32 ≥ ↑32 → zeroExtend 32 x <<< 15#32 &&& BitVec.ofInt 32 (-2147483648) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem n4_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬16#32 ≥ ↑32 → True ∧ zeroExtend 32 x <<< 16#32 >>> 16#32 ≠ zeroExtend 32 x ∨ 16#32 ≥ ↑32 → False :=
      by bv_generalize ; bv_multi_width
theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬16#32 ≥ ↑32 →
    zeroExtend 32 x <<< 16#32 &&& BitVec.ofInt 32 (-2147483648) = signExtend 32 x &&& BitVec.ofInt 32 (-2147483648) :=
      by bv_generalize ; bv_multi_width
theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬24#32 ≥ ↑32 →
    zeroExtend 32 x <<< 24#32 &&& BitVec.ofInt 32 (-2147483648) = signExtend 32 x &&& BitVec.ofInt 32 (-2147483648) :=
      by bv_generalize ; bv_multi_width
theorem neg_or_ashr_i32_commute_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬(x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true →
      ((42#32).sdiv x ||| 0#32 - (42#32).sdiv x).sshiftRight' 31#32 = signExtend 32 (ofBool ((42#32).sdiv x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem neg_or_ashr_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (0#32 - x ||| x).sshiftRight' 31#32 = signExtend 32 (ofBool (x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem neg_or_lshr_i32_commute_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬(x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true →
      ((42#32).sdiv x ||| 0#32 - (42#32).sdiv x) >>> 31#32 = zeroExtend 32 (ofBool ((42#32).sdiv x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem neg_or_lshr_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (0#32 - x ||| x) >>> 31#32 = zeroExtend 32 (ofBool (x != 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem negate_sext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  x_1 - signExtend 8 x = x_1 + zeroExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem negate_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  x_1 - zeroExtend 8 x = x_1 + signExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem t20_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬x ≥ ↑16 → x_1 - truncate 8 (BitVec.ofInt 16 (-42) <<< x) = x_1 + truncate 8 (42#16 <<< x) :=
      by bv_generalize ; bv_multi_width
theorem negate_sext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  x_1 - signExtend 8 x = x_1 + zeroExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem negate_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  x_1 - zeroExtend 8 x = x_1 + signExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem t20_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬x ≥ ↑16 → x_1 - truncate 8 (BitVec.ofInt 16 (-42) <<< x) = x_1 + truncate 8 (42#16 <<< x) :=
      by bv_generalize ; bv_multi_width
theorem absdiff1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 <ᵤ x) = 1#1 →
    (x_1 - x ^^^ signExtend 64 (ofBool (x_1 <ᵤ x))) - signExtend 64 (ofBool (x_1 <ᵤ x)) = 0#64 - (x_1 - x) :=
      by bv_generalize ; bv_multi_width
theorem absdiff1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬ofBool (x_1 <ᵤ x) = 1#1 →
    (x_1 - x ^^^ signExtend 64 (ofBool (x_1 <ᵤ x))) - signExtend 64 (ofBool (x_1 <ᵤ x)) = x_1 - x :=
      by bv_generalize ; bv_multi_width
theorem absdiff2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 <ᵤ x) = 1#1 →
    (x_1 - x ^^^ signExtend 64 (ofBool (x_1 <ᵤ x))) - signExtend 64 (ofBool (x_1 <ᵤ x)) = 0#64 - (x_1 - x) :=
      by bv_generalize ; bv_multi_width
theorem absdiff2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬ofBool (x_1 <ᵤ x) = 1#1 →
    (x_1 - x ^^^ signExtend 64 (ofBool (x_1 <ᵤ x))) - signExtend 64 (ofBool (x_1 <ᵤ x)) = x_1 - x :=
      by bv_generalize ; bv_multi_width
theorem absdiff_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 <ᵤ x) = 1#1 →
    (signExtend 64 (ofBool (x_1 <ᵤ x)) ^^^ x_1 - x) - signExtend 64 (ofBool (x_1 <ᵤ x)) = 0#64 - (x_1 - x) :=
      by bv_generalize ; bv_multi_width
theorem absdiff_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬ofBool (x_1 <ᵤ x) = 1#1 →
    (signExtend 64 (ofBool (x_1 <ᵤ x)) ^^^ x_1 - x) - signExtend 64 (ofBool (x_1 <ᵤ x)) = x_1 - x :=
      by bv_generalize ; bv_multi_width
theorem sext_diff_i1_xor_sub_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true → False :=
      by bv_generalize ; bv_multi_width
theorem sext_diff_i1_xor_sub_1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  ¬(True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true) →
    signExtend 64 x_1 - signExtend 64 x = zeroExtend 64 x + signExtend 64 x_1 :=
      by bv_generalize ; bv_multi_width
theorem sext_diff_i1_xor_sub_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true → False :=
      by bv_generalize ; bv_multi_width
theorem sext_diff_i1_xor_sub_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  ¬(True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true) →
    signExtend 64 x_1 - signExtend 64 x = zeroExtend 64 x + signExtend 64 x_1 :=
      by bv_generalize ; bv_multi_width
theorem sext_multi_uses_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1) (x_2 : BitVec 64),
  x_1 = 1#1 → x_2 * signExtend 64 x_1 + ((x ^^^ signExtend 64 x_1) - signExtend 64 x_1) = 0#64 - (x_2 + x) :=
      by bv_generalize ; bv_multi_width
theorem sext_multi_uses_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1) (x_2 : BitVec 64),
  ¬x_1 = 1#1 → x_2 * signExtend 64 x_1 + ((x ^^^ signExtend 64 x_1) - signExtend 64 x_1) = x :=
      by bv_generalize ; bv_multi_width
theorem sext_non_bool_xor_sub_1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 8),
  (signExtend 64 x_1 ^^^ x) - signExtend 64 x_1 = (x ^^^ signExtend 64 x_1) - signExtend 64 x_1 :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → (signExtend 64 x_1 ^^^ x) - signExtend 64 x_1 = 0#64 - x :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_1_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → (signExtend 64 x_1 ^^^ x) - signExtend 64 x_1 = x :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 64 x_1 - (x ^^^ signExtend 64 x_1) = x :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_2_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 64 x_1 - (x ^^^ signExtend 64 x_1) = 0#64 - x :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_3_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 64 x_1 - (signExtend 64 x_1 ^^^ x) = x :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_3_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 64 x_1 - (signExtend 64 x_1 ^^^ x) = 0#64 - x :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  x = 1#1 → (x_1 ^^^ signExtend 64 x) - signExtend 64 x = 0#64 - x_1 :=
      by bv_generalize ; bv_multi_width
theorem sext_xor_sub_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  ¬x = 1#1 → (x_1 ^^^ signExtend 64 x) - signExtend 64 x = x_1 :=
      by bv_generalize ; bv_multi_width
theorem PR44545_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) = 1#1 →
    ¬(True ∧ (truncate 16 0#32).saddOverflow (-1#16) = true) → truncate 16 0#32 + -1#16 = -1#16 :=
      by bv_generalize ; bv_multi_width
theorem PR44545_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ (truncate 16 0#32).saddOverflow (-1#16) = true) → truncate 16 0#32 + -1#16 = -1#16 :=
      by bv_generalize ; bv_multi_width
theorem PR44545_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ x.saddOverflow 1#32 = true ∨ True ∧ x.uaddOverflow 1#32 = true) →
      ¬(True ∧ (truncate 16 (x + 1#32)).saddOverflow (-1#16) = true) → truncate 16 (x + 1#32) + -1#16 = truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_sign_bits_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬3#32 ≥ ↑32 → True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 3#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_sign_bits_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬3#32 ≥ ↑32 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 3#16 ≥ ↑16) →
      truncate 16 ((signExtend 32 x_1 * signExtend 32 x).sshiftRight' 3#32) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 3#16 :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 → True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16) →
      truncate 16 ((signExtend 20 x_1 * signExtend 20 x).sshiftRight' 8#20) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 8#16 :=
      by bv_generalize ; bv_multi_width
theorem drop_both_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 (x_1 &&& 255#16 &&& x)) ≠ x_1 &&& 255#16 &&& x ∨
        True ∧ zeroExtend 16 (truncate 8 (x_1 &&& 255#16 &&& x)) ≠ x_1 &&& 255#16 &&& x) →
    truncate 8 (x_1 &&& 255#16 &&& x) = truncate 8 (x_1 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem drop_nsw_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 (x_1 &&& 255#16 &&& x)) ≠ x_1 &&& 255#16 &&& x) →
    truncate 8 (x_1 &&& 255#16 &&& x) = truncate 8 (x_1 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem drop_nuw_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ zeroExtend 16 (truncate 8 (x_1 &&& 255#16 &&& x)) ≠ x_1 &&& 255#16 &&& x) →
    truncate 8 (x_1 &&& 255#16 &&& x) = truncate 8 (x_1 &&& x) :=
      by bv_generalize ; bv_multi_width
theorem test11_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    True ∧ (x &&& 31#32).msb = true ∨
        True ∧
            (zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32)).sshiftRight' (zeroExtend 64 (x &&& 31#32)) ≠
              zeroExtend 64 x_1 ∨
          True ∧ zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) >>> zeroExtend 64 (x &&& 31#32) ≠ zeroExtend 64 x_1 ∨
            zeroExtend 64 (x &&& 31#32) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test11_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨
          True ∧
              (zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32)).sshiftRight' (zeroExtend 64 (x &&& 31#32)) ≠
                zeroExtend 64 x_1 ∨
            True ∧
                zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) >>> zeroExtend 64 (x &&& 31#32) ≠ zeroExtend 64 x_1 ∨
              zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 (zeroExtend 128 x_1 <<< (zeroExtend 128 x &&& 31#128)) =
        zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) :=
      by bv_generalize ; bv_multi_width
theorem test12_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 → True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test12_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 (zeroExtend 128 x_1 >>> (zeroExtend 128 x &&& 31#128)) =
        zeroExtend 64 x_1 >>> zeroExtend 64 (x &&& 31#32) :=
      by bv_generalize ; bv_multi_width
theorem test13_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 → True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test13_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 ((signExtend 128 x_1).sshiftRight' (zeroExtend 128 x &&& 31#128)) =
        (signExtend 64 x_1).sshiftRight' (zeroExtend 64 (x &&& 31#32)) :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#128 ≥ ↑128 → ¬16#32 ≥ ↑32 → truncate 32 (zeroExtend 128 x >>> 16#128) = x >>> 16#32 :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 → 32#64 ≥ ↑64 ∨ True ∧ zeroExtend 64 (truncate 32 (x >>> 32#64)) ≠ x >>> 32#64 → False :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    ¬(32#64 ≥ ↑64 ∨ True ∧ zeroExtend 64 (truncate 32 (x >>> 32#64)) ≠ x >>> 32#64) →
      truncate 32 (zeroExtend 128 x >>> 32#128) = truncate 32 (x >>> 32#64) :=
      by bv_generalize ; bv_multi_width
theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    ¬(32#64 ≥ ↑64 ∨ True ∧ (x >>> 32#64).msb = true) →
      truncate 92 (zeroExtend 128 x >>> 32#128) = zeroExtend 92 (x >>> 32#64) :=
      by bv_generalize ; bv_multi_width
theorem test8_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#128 ≥ ↑128 →
    True ∧ zeroExtend 64 x_1 <<< 32#64 >>> 32#64 ≠ zeroExtend 64 x_1 ∨
        32#64 ≥ ↑64 ∨ True ∧ (zeroExtend 64 x_1 <<< 32#64 &&& zeroExtend 64 x != 0) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬32#128 ≥ ↑128 →
    ¬(True ∧ zeroExtend 64 x_1 <<< 32#64 >>> 32#64 ≠ zeroExtend 64 x_1 ∨
          32#64 ≥ ↑64 ∨ True ∧ (zeroExtend 64 x_1 <<< 32#64 &&& zeroExtend 64 x != 0) = true) →
      truncate 64 (zeroExtend 128 x_1 <<< 32#128 ||| zeroExtend 128 x) =
        zeroExtend 64 x_1 <<< 32#64 ||| zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 32), truncate 8 (x &&& 42#32) = truncate 8 x &&& 42#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬8#36 ≥ ↑36 →
    ¬8#32 ≥ ↑32 →
      truncate 32 ((zeroExtend 36 x ||| BitVec.ofInt 36 (-2147483648)).sshiftRight' 8#36) =
        x >>> 8#32 ||| BitVec.ofInt 32 (-8388608) :=
      by bv_generalize ; bv_multi_width
theorem trunc_nsw_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ signExtend 8 (truncate 1 (x_1 ^^^ x)) ≠ x_1 ^^^ x) → truncate 1 (x_1 ^^^ x) = ofBool (x_1 != x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_nuw_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ zeroExtend 8 (truncate 1 (x_1 ^^^ x)) ≠ x_1 ^^^ x) → truncate 1 (x_1 ^^^ x) = ofBool (x_1 != x) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_15_i16_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬15#32 ≥ ↑32 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#32) = truncate 16 x <<< 15#16 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_15_i16_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#64) = truncate 16 x <<< 15#16 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_16_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬16#64 ≥ ↑64 → ¬16#32 ≥ ↑32 → truncate 32 (x <<< 16#64) = truncate 32 x <<< 16#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_1_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬1#64 ≥ ↑64 → ¬1#32 ≥ ↑32 → truncate 32 (x <<< 1#64) = truncate 32 x <<< 1#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬31#64 ≥ ↑64 → ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_32_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64), ¬32#64 ≥ ↑64 → truncate 32 (x <<< 32#64) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_33_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64), ¬33#64 ≥ ↑64 → truncate 32 (x <<< 33#64) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_7_i8_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬7#64 ≥ ↑64 → ¬7#8 ≥ ↑8 → truncate 8 (x <<< 7#64) = truncate 8 x <<< 7#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_ashr_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(3#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬1#64 ≥ ↑64 → truncate 32 (x.sshiftRight' 3#64 <<< 2#64) = truncate 32 (x >>> 1#64) &&& BitVec.ofInt 32 (-4) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_ashr_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1.sshiftRight' x <<< 2#64) = truncate 32 (x_1.sshiftRight' x) <<< 2#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_lshr_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬1#32 ≥ ↑32 → truncate 32 (x >>> 1#64 <<< 2#64) = truncate 32 x <<< 1#32 &&& BitVec.ofInt 32 (-4) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_lshr_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1 >>> x <<< 2#64) = truncate 32 (x_1 >>> x) <<< 2#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_nsw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (x <<< 31#64).sshiftRight' 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_nsw_nuw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (x <<< 31#64).sshiftRight' 31#64 ≠ x ∨ True ∧ x <<< 31#64 >>> 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_nuw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 31#64 >>> 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_shl_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) → ¬3#32 ≥ ↑32 → truncate 32 (x <<< 1#64 <<< 2#64) = truncate 32 x <<< 3#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_shl_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1 <<< x <<< 2#64) = truncate 32 (x_1 <<< x) <<< 2#32 :=
      by bv_generalize ; bv_multi_width
theorem badimm1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 9#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 9#16)) = 1#1 →
      7#8 ≥ ↑8 ∨
          9#16 ≥ ↑16 ∨
            True ∧ signExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 ∨
              True ∧ zeroExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 →
        False :=
      by bv_generalize ; bv_multi_width
theorem badimm1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 9#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 9#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        7#8 ≥ ↑8 ∨
            9#16 ≥ ↑16 ∨
              True ∧ signExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 ∨
                True ∧ zeroExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 →
          False :=
      by bv_generalize ; bv_multi_width
theorem badimm1_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 9#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 9#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(7#8 ≥ ↑8 ∨
              9#16 ≥ ↑16 ∨
                True ∧ signExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 ∨
                  True ∧ zeroExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16) →
          ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = 127#8 :=
      by bv_generalize ; bv_multi_width
theorem badimm1_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 9#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 9#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(7#8 ≥ ↑8 ∨
              9#16 ≥ ↑16 ∨
                True ∧ signExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 ∨
                  True ∧ zeroExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16) →
          ¬ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = BitVec.ofInt 8 (-128) :=
      by bv_generalize ; bv_multi_width
theorem badimm2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16 → False :=
      by bv_generalize ; bv_multi_width
theorem badimm2_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 → 6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16 → False :=
      by bv_generalize ; bv_multi_width
theorem badimm2_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16) →
          ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = 127#8 :=
      by bv_generalize ; bv_multi_width
theorem badimm2_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16) →
          ¬ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = BitVec.ofInt 8 (-128) :=
      by bv_generalize ; bv_multi_width
theorem badimm3_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬ofBool (x + 128#16 <ᵤ 256#16) = 1#1 →
        14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16 → False :=
      by bv_generalize ; bv_multi_width
theorem badimm3_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬ofBool (x + 128#16 <ᵤ 256#16) = 1#1 →
        ¬(14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16) →
          truncate 8 x = truncate 8 (x.sshiftRight' 14#16) ^^^ 127#8 :=
      by bv_generalize ; bv_multi_width
theorem badimm3_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬14#16 ≥ ↑16 → ofBool (x + 128#16 <ᵤ 256#16) = 1#1 → truncate 8 (x.sshiftRight' 14#16) ^^^ 127#8 = truncate 8 x :=
      by bv_generalize ; bv_multi_width
theorem badimm3_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬14#16 ≥ ↑16 →
        ¬ofBool (x + 128#16 <ᵤ 256#16) = 1#1 →
          14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16 → False :=
      by bv_generalize ; bv_multi_width
theorem badimm4_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ofBool (127#16 <ₛ x) = 1#1 → truncate 8 x = 126#8 :=
      by bv_generalize ; bv_multi_width
theorem badimm4_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬ofBool (127#16 <ₛ x) = 1#1 → ofBool (x <ₛ BitVec.ofInt 16 (-128)) = 1#1 → truncate 8 x = BitVec.ofInt 8 (-127) :=
      by bv_generalize ; bv_multi_width
theorem badimm4_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 → ofBool (127#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 126#8 = 126#8 :=
      by bv_generalize ; bv_multi_width
theorem badimm4_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬ofBool (127#16 <ₛ x) = 1#1 →
          ofBool (x <ₛ BitVec.ofInt 16 (-128)) = 1#1 →
            truncate 8 (x.sshiftRight' 15#16) ^^^ 126#8 = BitVec.ofInt 8 (-127) :=
      by bv_generalize ; bv_multi_width
theorem badimm4_thm.extracted_1._5 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬ofBool (127#16 <ₛ x) = 1#1 →
          ¬ofBool (x <ₛ BitVec.ofInt 16 (-128)) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 126#8 = truncate 8 x :=
      by bv_generalize ; bv_multi_width
theorem differentconsts_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x + 16#32 <ᵤ 144#32) = 1#1 → ofBool (127#32 <ₛ x) = 1#1 → truncate 16 x = -1#16 :=
      by bv_generalize ; bv_multi_width
theorem differentconsts_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x + 16#32 <ᵤ 144#32) = 1#1 →
    ¬ofBool (127#32 <ₛ x) = 1#1 → ofBool (x <ₛ BitVec.ofInt 32 (-16)) = 1#1 → truncate 16 x = 256#16 :=
      by bv_generalize ; bv_multi_width
theorem differentconsts_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (x + 16#32 <ᵤ 144#32) = 1#1 →
    ofBool (x <ₛ 128#32) = 1#1 →
      ¬ofBool (127#32 <ₛ x) = 1#1 → ¬ofBool (x <ₛ BitVec.ofInt 32 (-16)) = 1#1 → 256#16 = truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem differentconsts_thm.extracted_1._6 : ∀ (x : BitVec 32),
  ¬ofBool (x + 16#32 <ᵤ 144#32) = 1#1 →
    ¬ofBool (x <ₛ 128#32) = 1#1 →
      ¬ofBool (127#32 <ₛ x) = 1#1 → ¬ofBool (x <ₛ BitVec.ofInt 32 (-16)) = 1#1 → -1#16 = truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem testi32i8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#8 ≥ ↑8 ∨ 8#32 ≥ ↑32) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#32)) = 1#1 →
      ¬15#32 ≥ ↑32 → truncate 8 (x.sshiftRight' 15#32) ^^^ 127#8 = truncate 8 (x >>> 15#32) ^^^ 127#8 :=
      by bv_generalize ; bv_multi_width
theorem dont_narrow_zext_ashr_keep_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 16 x_1).saddOverflow (signExtend 16 x) = true ∨ 1#16 ≥ ↑16) →
    truncate 8 ((signExtend 16 x_1 + signExtend 16 x).sshiftRight' 1#16) =
      truncate 8 ((signExtend 16 x_1 + signExtend 16 x) >>> 1#16) :=
      by bv_generalize ; bv_multi_width
theorem narrow_sext_add_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (signExtend 32 x_1 + x) = x_1 + truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_sext_and_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (signExtend 32 x_1 &&& x) = x_1 &&& truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_sext_mul_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (signExtend 32 x_1 * x) = x_1 * truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_sext_or_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (signExtend 32 x_1 ||| x) = x_1 ||| truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_sext_sub_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (signExtend 32 x_1 - x) = x_1 - truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_sext_xor_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (signExtend 32 x_1 ^^^ x) = x_1 ^^^ truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_add_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 + x) = x_1 + truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_and_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 &&& x) = x_1 &&& truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_ashr_keep_trunc2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    True ∧ (zeroExtend 16 x_1).saddOverflow (zeroExtend 16 x) = true ∨
        True ∧ (zeroExtend 16 x_1).uaddOverflow (zeroExtend 16 x) = true ∨ 1#16 ≥ ↑16 →
      False :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_ashr_keep_trunc2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 9),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    ¬(True ∧ (zeroExtend 16 x_1).saddOverflow (zeroExtend 16 x) = true ∨
          True ∧ (zeroExtend 16 x_1).uaddOverflow (zeroExtend 16 x) = true ∨ 1#16 ≥ ↑16) →
      truncate 8 ((signExtend 64 x_1 + signExtend 64 x).sshiftRight' 1#64) =
        truncate 8 ((zeroExtend 16 x_1 + zeroExtend 16 x) >>> 1#16) :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_ashr_keep_trunc3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    True ∧ (zeroExtend 14 x_1).saddOverflow (zeroExtend 14 x) = true ∨
        True ∧ (zeroExtend 14 x_1).uaddOverflow (zeroExtend 14 x) = true ∨ 1#14 ≥ ↑14 →
      False :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_ashr_keep_trunc3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    ¬(True ∧ (zeroExtend 14 x_1).saddOverflow (zeroExtend 14 x) = true ∨
          True ∧ (zeroExtend 14 x_1).uaddOverflow (zeroExtend 14 x) = true ∨ 1#14 ≥ ↑14) →
      truncate 7 ((signExtend 64 x_1 + signExtend 64 x).sshiftRight' 1#64) =
        truncate 7 ((zeroExtend 14 x_1 + zeroExtend 14 x) >>> 1#14) :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_ashr_keep_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 32 x_1).saddOverflow (signExtend 32 x) = true ∨ 1#32 ≥ ↑32) →
    True ∧ (signExtend 16 x_1).saddOverflow (signExtend 16 x) = true ∨ 1#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_ashr_keep_trunc_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 32 x_1).saddOverflow (signExtend 32 x) = true ∨ 1#32 ≥ ↑32) →
    ¬(True ∧ (signExtend 16 x_1).saddOverflow (signExtend 16 x) = true ∨ 1#16 ≥ ↑16) →
      truncate 8 ((signExtend 32 x_1 + signExtend 32 x).sshiftRight' 1#32) =
        truncate 8 ((signExtend 16 x_1 + signExtend 16 x) >>> 1#16) :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_mul_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 * x) = x_1 * truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_or_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 ||| x) = x_1 ||| truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_sub_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 - x) = x_1 - truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem narrow_zext_xor_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 ^^^ x) = x_1 ^^^ truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem or_trunc_lshr_more_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 → 4#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 4#6 &&& BitVec.ofInt 6 (-4) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem or_trunc_lshr_more_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 →
    ¬(4#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 4#6 &&& BitVec.ofInt 6 (-4) != 0) = true) →
      truncate 6 (x >>> 4#8) ||| BitVec.ofInt 6 (-4) = truncate 6 x >>> 4#6 ||| BitVec.ofInt 6 (-4) :=
      by bv_generalize ; bv_multi_width
theorem or_trunc_lshr_small_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 →
    4#8 ≥ ↑8 ∨
        True ∧ signExtend 8 (truncate 6 (x >>> 4#8)) ≠ x >>> 4#8 ∨
          True ∧ zeroExtend 8 (truncate 6 (x >>> 4#8)) ≠ x >>> 4#8 →
      False :=
      by bv_generalize ; bv_multi_width
theorem or_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → 1#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 1#6 &&& BitVec.ofInt 6 (-32) != 0) = true → False :=
      by bv_generalize ; bv_multi_width
theorem or_trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 →
    ¬(1#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 1#6 &&& BitVec.ofInt 6 (-32) != 0) = true) →
      truncate 6 (x >>> 1#8) ||| BitVec.ofInt 6 (-32) = truncate 6 x >>> 1#6 ||| BitVec.ofInt 6 (-32) :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_big_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 → 2#8 ≥ ↑8 ∨ True ∧ zeroExtend 8 (truncate 6 (x >>> 2#8)) ≠ x >>> 2#8 → False :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_exact_mask_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 → ¬2#6 ≥ ↑6 → truncate 6 (x >>> 2#8) &&& 15#6 = truncate 6 x >>> 2#6 :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 → ¬2#6 ≥ ↑6 → truncate 6 (x >>> 2#8) &&& 14#6 = truncate 6 x >>> 2#6 &&& 14#6 :=
      by bv_generalize ; bv_multi_width
theorem PR44545_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) = 1#1 →
    ¬(True ∧ (truncate 16 0#32).saddOverflow (-1#16) = true) → truncate 16 0#32 + -1#16 = -1#16 :=
      by bv_generalize ; bv_multi_width
theorem PR44545_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ (truncate 16 0#32).saddOverflow (-1#16) = true) → truncate 16 0#32 + -1#16 = -1#16 :=
      by bv_generalize ; bv_multi_width
theorem PR44545_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ x.saddOverflow 1#32 = true ∨ True ∧ x.uaddOverflow 1#32 = true) →
      ¬(True ∧ (truncate 16 (x + 1#32)).saddOverflow (-1#16) = true) → truncate 16 (x + 1#32) + -1#16 = truncate 16 x :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_sign_bits_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬3#32 ≥ ↑32 → True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 3#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_sign_bits_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬3#32 ≥ ↑32 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 3#16 ≥ ↑16) →
      truncate 16 ((signExtend 32 x_1 * signExtend 32 x).sshiftRight' 3#32) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 3#16 :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 → True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16 → False :=
      by bv_generalize ; bv_multi_width
theorem ashr_mul_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16) →
      truncate 16 ((signExtend 20 x_1 * signExtend 20 x).sshiftRight' 8#20) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 8#16 :=
      by bv_generalize ; bv_multi_width
theorem test11_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    True ∧ (x &&& 31#32).msb = true ∨
        True ∧
            (zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32)).sshiftRight' (zeroExtend 64 (x &&& 31#32)) ≠
              zeroExtend 64 x_1 ∨
          True ∧ zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) >>> zeroExtend 64 (x &&& 31#32) ≠ zeroExtend 64 x_1 ∨
            zeroExtend 64 (x &&& 31#32) ≥ ↑64 →
      False :=
      by bv_generalize ; bv_multi_width
theorem test11_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨
          True ∧
              (zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32)).sshiftRight' (zeroExtend 64 (x &&& 31#32)) ≠
                zeroExtend 64 x_1 ∨
            True ∧
                zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) >>> zeroExtend 64 (x &&& 31#32) ≠ zeroExtend 64 x_1 ∨
              zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 (zeroExtend 128 x_1 <<< (zeroExtend 128 x &&& 31#128)) =
        zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) :=
      by bv_generalize ; bv_multi_width
theorem test12_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 → True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test12_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 (zeroExtend 128 x_1 >>> (zeroExtend 128 x &&& 31#128)) =
        zeroExtend 64 x_1 >>> zeroExtend 64 (x &&& 31#32) :=
      by bv_generalize ; bv_multi_width
theorem test13_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 → True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem test13_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 ((signExtend 128 x_1).sshiftRight' (zeroExtend 128 x &&& 31#128)) =
        (signExtend 64 x_1).sshiftRight' (zeroExtend 64 (x &&& 31#32)) :=
      by bv_generalize ; bv_multi_width
theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#128 ≥ ↑128 → ¬16#32 ≥ ↑32 → truncate 32 (zeroExtend 128 x >>> 16#128) = x >>> 16#32 :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 → 32#64 ≥ ↑64 ∨ True ∧ zeroExtend 64 (truncate 32 (x >>> 32#64)) ≠ x >>> 32#64 → False :=
      by bv_generalize ; bv_multi_width
theorem test6_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    ¬(32#64 ≥ ↑64 ∨ True ∧ zeroExtend 64 (truncate 32 (x >>> 32#64)) ≠ x >>> 32#64) →
      truncate 32 (zeroExtend 128 x >>> 32#128) = truncate 32 (x >>> 32#64) :=
      by bv_generalize ; bv_multi_width
theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    ¬(32#64 ≥ ↑64 ∨ True ∧ (x >>> 32#64).msb = true) →
      truncate 92 (zeroExtend 128 x >>> 32#128) = zeroExtend 92 (x >>> 32#64) :=
      by bv_generalize ; bv_multi_width
theorem test8_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#128 ≥ ↑128 →
    True ∧ zeroExtend 64 x_1 <<< 32#64 >>> 32#64 ≠ zeroExtend 64 x_1 ∨
        32#64 ≥ ↑64 ∨ True ∧ (zeroExtend 64 x_1 <<< 32#64 &&& zeroExtend 64 x != 0) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem test8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬32#128 ≥ ↑128 →
    ¬(True ∧ zeroExtend 64 x_1 <<< 32#64 >>> 32#64 ≠ zeroExtend 64 x_1 ∨
          32#64 ≥ ↑64 ∨ True ∧ (zeroExtend 64 x_1 <<< 32#64 &&& zeroExtend 64 x != 0) = true) →
      truncate 64 (zeroExtend 128 x_1 <<< 32#128 ||| zeroExtend 128 x) =
        zeroExtend 64 x_1 <<< 32#64 ||| zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 32), truncate 8 (x &&& 42#32) = truncate 8 x &&& 42#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬8#36 ≥ ↑36 →
    ¬8#32 ≥ ↑32 →
      truncate 32 ((zeroExtend 36 x ||| BitVec.ofInt 36 (-2147483648)).sshiftRight' 8#36) =
        x >>> 8#32 ||| BitVec.ofInt 32 (-8388608) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_15_i16_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬15#32 ≥ ↑32 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#32) = truncate 16 x <<< 15#16 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_15_i16_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#64) = truncate 16 x <<< 15#16 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_16_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬16#64 ≥ ↑64 → ¬16#32 ≥ ↑32 → truncate 32 (x <<< 16#64) = truncate 32 x <<< 16#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_1_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬1#64 ≥ ↑64 → ¬1#32 ≥ ↑32 → truncate 32 (x <<< 1#64) = truncate 32 x <<< 1#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬31#64 ≥ ↑64 → ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_32_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64), ¬32#64 ≥ ↑64 → truncate 32 (x <<< 32#64) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_33_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64), ¬33#64 ≥ ↑64 → truncate 32 (x <<< 33#64) = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_7_i8_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬7#64 ≥ ↑64 → ¬7#8 ≥ ↑8 → truncate 8 (x <<< 7#64) = truncate 8 x <<< 7#8 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_ashr_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(3#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬1#64 ≥ ↑64 → truncate 32 (x.sshiftRight' 3#64 <<< 2#64) = truncate 32 (x >>> 1#64) &&& BitVec.ofInt 32 (-4) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_ashr_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1.sshiftRight' x <<< 2#64) = truncate 32 (x_1.sshiftRight' x) <<< 2#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_lshr_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬1#32 ≥ ↑32 → truncate 32 (x >>> 1#64 <<< 2#64) = truncate 32 x <<< 1#32 &&& BitVec.ofInt 32 (-4) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_lshr_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1 >>> x <<< 2#64) = truncate 32 (x_1 >>> x) <<< 2#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_nsw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (x <<< 31#64).sshiftRight' 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_nsw_nuw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (x <<< 31#64).sshiftRight' 31#64 ≠ x ∨ True ∧ x <<< 31#64 >>> 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_nuw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 31#64 >>> 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_shl_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) → ¬3#32 ≥ ↑32 → truncate 32 (x <<< 1#64 <<< 2#64) = truncate 32 x <<< 3#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_shl_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1 <<< x <<< 2#64) = truncate 32 (x_1 <<< x) <<< 2#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_ashr_trunc_exact_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ truncate 32 x >>> 8#32 <<< 8#32 ≠ truncate 32 x ∨ 8#32 ≥ ↑32) →
    True ∧ x >>> 8#64 <<< 8#64 ≠ x ∨ 8#64 ≥ ↑64 → False :=
      by bv_generalize ; bv_multi_width
theorem trunc_ashr_trunc_exact_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ truncate 32 x >>> 8#32 <<< 8#32 ≠ truncate 32 x ∨ 8#32 ≥ ↑32) →
    ¬(True ∧ x >>> 8#64 <<< 8#64 ≠ x ∨ 8#64 ≥ ↑64) →
      truncate 8 ((truncate 32 x).sshiftRight' 8#32) = truncate 8 (x >>> 8#64) :=
      by bv_generalize ; bv_multi_width
theorem trunc_ashr_trunc_outofrange_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬25#32 ≥ ↑32 →
    25#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 8 ((truncate 32 x).sshiftRight' 25#32)) ≠ (truncate 32 x).sshiftRight' 25#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_ashr_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → ¬8#64 ≥ ↑64 → truncate 8 ((truncate 32 x).sshiftRight' 8#32) = truncate 8 (x >>> 8#64) :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_trunc_outofrange_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬25#32 ≥ ↑32 →
    25#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 8 (truncate 32 x >>> 25#32)) ≠ truncate 32 x >>> 25#32 ∨
          True ∧ zeroExtend 32 (truncate 8 (truncate 32 x >>> 25#32)) ≠ truncate 32 x >>> 25#32 →
      False :=
      by bv_generalize ; bv_multi_width
theorem trunc_lshr_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → ¬8#64 ≥ ↑64 → truncate 8 (truncate 32 x >>> 8#32) = truncate 8 (x >>> 8#64) :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_zext_32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬4#16 ≥ ↑16 → ¬4#32 ≥ ↑32 → zeroExtend 32 (truncate 16 x <<< 4#16) = x <<< 4#32 &&& 65520#32 :=
      by bv_generalize ; bv_multi_width
theorem trunc_shl_zext_64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬7#8 ≥ ↑8 → ¬7#64 ≥ ↑64 → zeroExtend 64 (truncate 8 x <<< 7#8) = x <<< 7#64 &&& 128#64 :=
      by bv_generalize ; bv_multi_width
theorem udiv_c_i32_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x = 0 → x = 0 ∨ True ∧ (10#8 / x).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem udiv_c_i32_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬(x = 0 ∨ True ∧ (10#8 / x).msb = true) → 10#32 / zeroExtend 32 x = zeroExtend 32 (10#8 / x) :=
      by bv_generalize ; bv_multi_width
theorem udiv_i32_c_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    10#32 = 0 ∨
        True ∧ (zeroExtend 32 x / 10#32).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x / 10#32).uaddOverflow (zeroExtend 32 x) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem udiv_i32_c_multiuse_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    ¬(10#32 = 0 ∨
          True ∧ (zeroExtend 32 x / 10#32).saddOverflow (zeroExtend 32 x) = true ∨
            True ∧ (zeroExtend 32 x / 10#32).uaddOverflow (zeroExtend 32 x) = true) →
      zeroExtend 32 x + zeroExtend 32 x / 10#32 = zeroExtend 32 x / 10#32 + zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem udiv_i32_c_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬10#32 = 0 → ¬(10#8 = 0 ∨ True ∧ (x / 10#8).msb = true) → zeroExtend 32 x / 10#32 = zeroExtend 32 (x / 10#8) :=
      by bv_generalize ; bv_multi_width
theorem udiv_i32_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 →
    zeroExtend 32 x = 0 ∨
        True ∧ (zeroExtend 32 x_1).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x_1).uaddOverflow (zeroExtend 32 x) = true ∨
            True ∧ (zeroExtend 32 x_1 / zeroExtend 32 x).smulOverflow (zeroExtend 32 x_1 + zeroExtend 32 x) = true ∨
              True ∧ (zeroExtend 32 x_1 / zeroExtend 32 x).umulOverflow (zeroExtend 32 x_1 + zeroExtend 32 x) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem udiv_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), ¬zeroExtend 32 x = 0 → x = 0 → False :=
      by bv_generalize ; bv_multi_width
theorem udiv_i32_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → zeroExtend 32 x_1 / zeroExtend 32 x = zeroExtend 32 (x_1 / x) :=
      by bv_generalize ; bv_multi_width
theorem udiv_i8_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), ¬zeroExtend 32 x = 0 → x = 0 → False :=
      by bv_generalize ; bv_multi_width
theorem udiv_i8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → truncate 8 (zeroExtend 32 x_1 / zeroExtend 32 x) = x_1 / x :=
      by bv_generalize ; bv_multi_width
theorem udiv_illegal_type_c_thm.extracted_1._2 : ∀ (x : BitVec 9),
  ¬10#32 = 0 → ¬(10#9 = 0 ∨ True ∧ (x / 10#9).msb = true) → zeroExtend 32 x / 10#32 = zeroExtend 32 (x / 10#9) :=
      by bv_generalize ; bv_multi_width
theorem udiv_illegal_type_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9), ¬zeroExtend 32 x = 0 → x = 0 → False :=
      by bv_generalize ; bv_multi_width
theorem udiv_illegal_type_thm.extracted_1._2 : ∀ (x x_1 : BitVec 9),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → zeroExtend 32 x_1 / zeroExtend 32 x = zeroExtend 32 (x_1 / x) :=
      by bv_generalize ; bv_multi_width
theorem urem_c_i32_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x = 0 → x = 0 ∨ True ∧ (10#8 % x).msb = true → False :=
      by bv_generalize ; bv_multi_width
theorem urem_c_i32_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬(x = 0 ∨ True ∧ (10#8 % x).msb = true) → 10#32 % zeroExtend 32 x = zeroExtend 32 (10#8 % x) :=
      by bv_generalize ; bv_multi_width
theorem urem_i32_c_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    10#32 = 0 ∨
        True ∧ (zeroExtend 32 x % 10#32).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x % 10#32).uaddOverflow (zeroExtend 32 x) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem urem_i32_c_multiuse_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    ¬(10#32 = 0 ∨
          True ∧ (zeroExtend 32 x % 10#32).saddOverflow (zeroExtend 32 x) = true ∨
            True ∧ (zeroExtend 32 x % 10#32).uaddOverflow (zeroExtend 32 x) = true) →
      zeroExtend 32 x + zeroExtend 32 x % 10#32 = zeroExtend 32 x % 10#32 + zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem urem_i32_c_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬10#32 = 0 → ¬(10#8 = 0 ∨ True ∧ (x % 10#8).msb = true) → zeroExtend 32 x % 10#32 = zeroExtend 32 (x % 10#8) :=
      by bv_generalize ; bv_multi_width
theorem urem_i32_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 →
    zeroExtend 32 x = 0 ∨
        True ∧ (zeroExtend 32 x_1).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x_1).uaddOverflow (zeroExtend 32 x) = true ∨
            True ∧ (zeroExtend 32 x_1 % zeroExtend 32 x).smulOverflow (zeroExtend 32 x_1 + zeroExtend 32 x) = true ∨
              True ∧ (zeroExtend 32 x_1 % zeroExtend 32 x).umulOverflow (zeroExtend 32 x_1 + zeroExtend 32 x) = true →
      False :=
      by bv_generalize ; bv_multi_width
theorem urem_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), ¬zeroExtend 32 x = 0 → x = 0 → False :=
      by bv_generalize ; bv_multi_width
theorem urem_i32_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → zeroExtend 32 x_1 % zeroExtend 32 x = zeroExtend 32 (x_1 % x) :=
      by bv_generalize ; bv_multi_width
theorem urem_i8_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), ¬zeroExtend 32 x = 0 → x = 0 → False :=
      by bv_generalize ; bv_multi_width
theorem urem_i8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → truncate 8 (zeroExtend 32 x_1 % zeroExtend 32 x) = x_1 % x :=
      by bv_generalize ; bv_multi_width
theorem urem_illegal_type_c_thm.extracted_1._2 : ∀ (x : BitVec 9),
  ¬10#32 = 0 → ¬(10#9 = 0 ∨ True ∧ (x % 10#9).msb = true) → zeroExtend 32 x % 10#32 = zeroExtend 32 (x % 10#9) :=
      by bv_generalize ; bv_multi_width
theorem urem_illegal_type_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9), ¬zeroExtend 32 x = 0 → x = 0 → False :=
      by bv_generalize ; bv_multi_width
theorem urem_illegal_type_thm.extracted_1._2 : ∀ (x x_1 : BitVec 9),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → zeroExtend 32 x_1 % zeroExtend 32 x = zeroExtend 32 (x_1 % x) :=
      by bv_generalize ; bv_multi_width
theorem max_sub_ult_c1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 1#32) = 1#1 → x + -1#32 = signExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem max_sub_ult_c1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ᵤ 1#32) = 1#1 → 0#32 = signExtend 32 (ofBool (x == 0#32)) :=
      by bv_generalize ; bv_multi_width
theorem fold_zext_xor_sandwich_thm.extracted_1._1 : ∀ (x : BitVec 1),
  zeroExtend 32 (x ^^^ 1#1) ^^^ 2#32 = zeroExtend 32 x ^^^ 3#32 :=
      by bv_generalize ; bv_multi_width
theorem test22_thm.extracted_1._1 : ∀ (x : BitVec 1), zeroExtend 32 (x ^^^ 1#1) ^^^ 1#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem test27_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  zeroExtend 32 (ofBool (x_2 ^^^ x_1 == x_2 ^^^ x)) = zeroExtend 32 (ofBool (x_1 == x)) :=
      by bv_generalize ; bv_multi_width
theorem testi16i8_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬15#16 ≥ ↑16 → ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 27#8 = 27#8 :=
      by bv_generalize ; bv_multi_width
theorem testi16i8_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬15#16 ≥ ↑16 → ¬ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 27#8 = BitVec.ofInt 8 (-28) :=
      by bv_generalize ; bv_multi_width
theorem testi64i32_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ofBool (-1#64 <ₛ x) = 1#1 → truncate 32 (x.sshiftRight' 63#64) ^^^ 127#32 = 127#32 :=
      by bv_generalize ; bv_multi_width
theorem testi64i32_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ¬ofBool (-1#64 <ₛ x) = 1#1 → truncate 32 (x.sshiftRight' 63#64) ^^^ 127#32 = BitVec.ofInt 32 (-128) :=
      by bv_generalize ; bv_multi_width
theorem wrongimm_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬14#16 ≥ ↑16 →
    14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16 → False :=
      by bv_generalize ; bv_multi_width
theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& 8#8).msb = true) → zeroExtend 32 x &&& 65544#32 = zeroExtend 32 (x &&& 8#8) :=
      by bv_generalize ; bv_multi_width
theorem fold_and_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  zeroExtend 8 (ofBool (x_1 <ₛ x_2)) &&& zeroExtend 8 (ofBool (x_2 <ₛ x)) =
    zeroExtend 8 (ofBool (x_1 <ₛ x_2) &&& ofBool (x_2 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem fold_nested_logic_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 64),
  zeroExtend 8 (ofBool (x_2 <ₛ x_3)) &&& zeroExtend 8 (ofBool (x_3 <ₛ x_1)) ||| zeroExtend 8 (ofBool (x_3 == x)) =
    zeroExtend 8 (ofBool (x_2 <ₛ x_3) &&& ofBool (x_3 <ₛ x_1) ||| ofBool (x_3 == x)) :=
      by bv_generalize ; bv_multi_width
theorem fold_or_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  zeroExtend 8 (ofBool (x_1 <ₛ x_2)) ||| zeroExtend 8 (ofBool (x_2 <ₛ x)) =
    zeroExtend 8 (ofBool (x_1 <ₛ x_2) ||| ofBool (x_2 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem fold_xor_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  zeroExtend 8 (ofBool (x_1 <ₛ x_2)) ^^^ zeroExtend 8 (ofBool (x_2 <ₛ x)) =
    zeroExtend 8 (ofBool (x_1 <ₛ x_2) ^^^ ofBool (x_2 <ₛ x)) :=
      by bv_generalize ; bv_multi_width
theorem fold_xor_zext_sandwich_thm.extracted_1._1 : ∀ (x : BitVec 1),
  zeroExtend 64 (zeroExtend 32 x ^^^ 1#32) = zeroExtend 64 (x ^^^ 1#1) :=
      by bv_generalize ; bv_multi_width
theorem masked_bit_clear_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬((x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨ x ≥ ↑32) →
    zeroExtend 32 (ofBool ((42#32).srem x_1 &&& 1#32 <<< x == 0#32)) = ((42#32).srem x_1 ^^^ -1#32) >>> x &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem masked_bit_set_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x_1 &&& x != 0#32)) = x >>> x_1 &&& 1#32 :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_apint1_thm.extracted_1._1 : ∀ (x : BitVec 77),
  signExtend 1024 (zeroExtend 533 x) = zeroExtend 1024 x :=
      by bv_generalize ; bv_multi_width
theorem sext_zext_apint2_thm.extracted_1._1 : ∀ (x : BitVec 11), signExtend 47 (zeroExtend 39 x) = zeroExtend 47 x :=
      by bv_generalize ; bv_multi_width
theorem test_sext_zext_thm.extracted_1._1 : ∀ (x : BitVec 16), signExtend 64 (zeroExtend 32 x) = zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem zext_masked_bit_nonzero_to_smaller_bitwidth_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → zeroExtend 16 (ofBool (1#32 <<< x_1 &&& x != 0#32)) = truncate 16 (x >>> x_1) &&& 1#16 :=
      by bv_generalize ; bv_multi_width
theorem zext_masked_bit_zero_to_larger_bitwidth_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 →
    ¬(x_1 ≥ ↑32 ∨ True ∧ ((x ^^^ -1#32) >>> x_1 &&& 1#32).msb = true) →
      zeroExtend 64 (ofBool (1#32 <<< x_1 &&& x == 0#32)) = zeroExtend 64 ((x ^^^ -1#32) >>> x_1 &&& 1#32) :=
      by bv_generalize ; bv_multi_width
theorem zext_masked_bit_zero_to_smaller_bitwidth_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → zeroExtend 16 (ofBool (1#32 <<< x_1 &&& x == 0#32)) = truncate 16 ((x ^^^ -1#32) >>> x_1) &&& 1#16 :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_flag_drop_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬(True ∧ (x_1 &&& 127#8).msb = true) →
    zeroExtend 16 (x_1 &&& 127#8) ||| x ||| 128#16 = x ||| zeroExtend 16 x_1 ||| 128#16 :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_i1_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬(True ∧ x.msb = true) → zeroExtend 32 x = 0#32 :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_redundant_and_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.msb = true) → zeroExtend 32 x &&& 127#32 = zeroExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem zext_nneg_signbit_extract_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.msb = true ∨ 31#64 ≥ ↑64) → zeroExtend 64 x >>> 31#64 = 0#64 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        x = 1#1 →
          ¬(True ∧ (zeroExtend 32 x + 1#32).saddOverflow 1#32 = true) →
            True ∧ (2#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                True ∧ (2#32).uaddOverflow (zeroExtend 32 x_2) = true →
              False :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        ¬x = 1#1 →
          ¬(True ∧ (1#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                True ∧ (1#32).uaddOverflow (zeroExtend 32 x_2) = true) →
            zeroExtend 32 x + 1#32 = 1#32 + zeroExtend 32 x_2 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    ¬x_1 = 1#1 →
      True ∧ (zeroExtend 32 x).saddOverflow (zeroExtend 32 x_2) = true ∨
          True ∧ (zeroExtend 32 x).uaddOverflow (zeroExtend 32 x_2) = true →
        False :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    ¬x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow (zeroExtend 32 x_2) = true ∨
            True ∧ (zeroExtend 32 x).uaddOverflow (zeroExtend 32 x_2) = true) →
        zeroExtend 32 x = zeroExtend 32 x + zeroExtend 32 x_2 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        x = 1#1 →
          ¬(True ∧ (zeroExtend 32 x + 1#32).saddOverflow 1#32 = true) →
            ¬(True ∧ (2#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                  True ∧ (2#32).uaddOverflow (zeroExtend 32 x_2) = true) →
              zeroExtend 32 x + 1#32 + 1#32 = 2#32 + zeroExtend 32 x_2 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        ¬x = 1#1 →
          ¬(True ∧ (zeroExtend 32 x + 1#32).saddOverflow 1#32 = true) →
            True ∧ (1#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                True ∧ (1#32).uaddOverflow (zeroExtend 32 x_2) = true →
              False :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        ¬x = 1#1 →
          ¬(True ∧ (zeroExtend 32 x + 1#32).saddOverflow 1#32 = true) →
            ¬(True ∧ (1#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                  True ∧ (1#32).uaddOverflow (zeroExtend 32 x_2) = true) →
              zeroExtend 32 x + 1#32 + 1#32 = 1#32 + zeroExtend 32 x_2 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    ¬x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        True ∧ (zeroExtend 32 x).saddOverflow (zeroExtend 32 x_2) = true ∨
            True ∧ (zeroExtend 32 x).uaddOverflow (zeroExtend 32 x_2) = true →
          False :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    ¬x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        ¬(True ∧ (zeroExtend 32 x).saddOverflow (zeroExtend 32 x_2) = true ∨
              True ∧ (zeroExtend 32 x).uaddOverflow (zeroExtend 32 x_2) = true) →
          zeroExtend 32 x + 1#32 = zeroExtend 32 x + zeroExtend 32 x_2 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        x = 1#1 →
          True ∧ (2#32).saddOverflow (zeroExtend 32 x_2) = true ∨
              True ∧ (2#32).uaddOverflow (zeroExtend 32 x_2) = true →
            False :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        x = 1#1 →
          ¬(True ∧ (2#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                True ∧ (2#32).uaddOverflow (zeroExtend 32 x_2) = true) →
            zeroExtend 32 x + 1#32 = 2#32 + zeroExtend 32 x_2 :=
      by bv_generalize ; bv_multi_width
theorem PR30273_three_bools_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        ¬x = 1#1 →
          True ∧ (1#32).saddOverflow (zeroExtend 32 x_2) = true ∨
              True ∧ (1#32).uaddOverflow (zeroExtend 32 x_2) = true →
            False :=
      by bv_generalize ; bv_multi_width
theorem a_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → True ∧ (2#32).saddOverflow (signExtend 32 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem a_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬(True ∧ (2#32).saddOverflow (signExtend 32 x) = true) →
      zeroExtend 32 x_1 + 1#32 + (0#32 - zeroExtend 32 x) = 2#32 + signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem a_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → True ∧ (1#32).saddOverflow (signExtend 32 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem a_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (1#32).saddOverflow (signExtend 32 x) = true) →
      zeroExtend 32 x_1 + 1#32 + (0#32 - zeroExtend 32 x) = 1#32 + signExtend 32 x :=
      by bv_generalize ; bv_multi_width
theorem sext_negate_thm.extracted_1._1 : ∀ (x : BitVec 1), 0#64 - signExtend 64 x = zeroExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem sext_sub_const_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 42#64 - signExtend 64 x = 43#64 :=
      by bv_generalize ; bv_multi_width
theorem sext_sub_const_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 42#64 - signExtend 64 x = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem sext_sub_nuw_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ¬(True ∧ x_1.usubOverflow (signExtend 8 x) = true) → x_1 - signExtend 8 x = x_1 + zeroExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem sext_sub_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8), x_1 - signExtend 8 x = x_1 + zeroExtend 8 x :=
      by bv_generalize ; bv_multi_width
theorem sextbool_add_commute_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬42#32 = 0 → 42#32 = 0 ∨ True ∧ (x_1 % 42#32).saddOverflow (signExtend 32 x) = true → False :=
      by bv_generalize ; bv_multi_width
theorem sextbool_add_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  signExtend 32 x_1 + x = x + signExtend 32 x_1 :=
      by bv_generalize ; bv_multi_width
theorem zext_add_scalar_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → zeroExtend 32 x + 42#32 = 43#32 :=
      by bv_generalize ; bv_multi_width
theorem zext_add_scalar_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → zeroExtend 32 x + 42#32 = 42#32 :=
      by bv_generalize ; bv_multi_width
theorem zext_negate_thm.extracted_1._1 : ∀ (x : BitVec 1), 0#64 - zeroExtend 64 x = signExtend 64 x :=
      by bv_generalize ; bv_multi_width
theorem zext_sub_const_thm.extracted_1._1 : ∀ (x : BitVec 1), x = 1#1 → 42#64 - zeroExtend 64 x = 41#64 :=
      by bv_generalize ; bv_multi_width
theorem zext_sub_const_thm.extracted_1._2 : ∀ (x : BitVec 1), ¬x = 1#1 → 42#64 - zeroExtend 64 x = 42#64 :=
      by bv_generalize ; bv_multi_width
theorem select_zext_or_eq_ult_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 2#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem select_zext_or_eq_ult_add_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 2#32) = 1#1 →
    zeroExtend 32 (ofBool (x == 5#32)) = zeroExtend 32 (ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 3#32)) :=
      by bv_generalize ; bv_multi_width
theorem zext_or_eq_ult_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 3#32) ||| ofBool (x == 5#32)) =
    zeroExtend 32 (ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 3#32)) :=
      by bv_generalize ; bv_multi_width
