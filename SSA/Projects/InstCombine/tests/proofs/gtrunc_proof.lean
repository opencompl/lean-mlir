
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gtrunc_proof
theorem test5_thm (x : BitVec 32) : setWidth 32 (setWidth 128 x >>> 16) = x >>> 16 := sorry

theorem test6_thm (x : BitVec 64) : setWidth 32 (setWidth 128 x >>> 32) = setWidth 32 (x >>> 32) := sorry

theorem ashr_mul_sign_bits_thm (x x_1 : BitVec 8) :
  some (setWidth 16 ((signExtend 32 x_1 * signExtend 32 x).sshiftRight 3)) ⊑
    (if
            signExtend 32 (signExtend 16 x_1) * signExtend 32 (signExtend 16 x) < signExtend 32 (twoPow 16 15) ∨
              twoPow 32 15 ≤ signExtend 32 (signExtend 16 x_1) * signExtend 32 (signExtend 16 x) then
          none
        else some (signExtend 16 x_1 * signExtend 16 x)).bind
      fun x' => some (x'.sshiftRight 3) := sorry

theorem ashr_mul_thm (x x_1 : BitVec 8) :
  some (setWidth 16 ((signExtend 20 x_1 * signExtend 20 x).sshiftRight 8)) ⊑
    (if
            signExtend 32 (signExtend 16 x_1) * signExtend 32 (signExtend 16 x) < signExtend 32 (twoPow 16 15) ∨
              twoPow 32 15 ≤ signExtend 32 (signExtend 16 x_1) * signExtend 32 (signExtend 16 x) then
          none
        else some (signExtend 16 x_1 * signExtend 16 x)).bind
      fun x' => some (x'.sshiftRight 8) := sorry

theorem trunc_ashr_thm (x : BitVec 32) :
  setWidth 32 ((setWidth 36 x ||| 66571993088#36).sshiftRight 8) = x >>> 8 ||| 4286578688#32 := sorry

theorem test7_thm (x : BitVec 64) : setWidth 92 (setWidth 128 x >>> 32) = setWidth 92 (x >>> 32) := sorry

theorem test8_thm (x x_1 : BitVec 32) :
  some (setWidth 64 (setWidth 128 x_1 <<< 32) ||| setWidth 64 x) ⊑
    (if setWidth 64 x_1 <<< 32 >>> 32 = setWidth 64 x_1 then none else some (setWidth 64 x_1 <<< 32)).bind fun a =>
      some (a ||| setWidth 64 x) := sorry

theorem test11_thm (x x_1 : BitVec 32) :
  (Option.bind
      (if 128#128 ≤ setWidth 128 x &&& 31#128 then none
      else some (setWidth 128 x_1 <<< (x.toNat % 340282366920938463463374607431768211456 &&& 31)))
      fun x' => some (setWidth 64 x')) ⊑
    if
        (setWidth 64 x_1 <<< ((x.toNat &&& 31) % 18446744073709551616)).sshiftRight
            ((x.toNat &&& 31) % 18446744073709551616) =
          setWidth 64 x_1 then
      none
    else
      if
          setWidth 64 x_1 <<< ((x.toNat &&& 31) % 18446744073709551616) >>> ((x.toNat &&& 31) % 18446744073709551616) =
            setWidth 64 x_1 then
        none
      else
        if 64#64 ≤ setWidth 64 x &&& 31#64 then none
        else some (setWidth 64 x_1 <<< ((x.toNat &&& 31) % 18446744073709551616)) := sorry

theorem test12_thm (x x_1 : BitVec 32) :
  (Option.bind
      (if 128#128 ≤ setWidth 128 x &&& 31#128 then none
      else some (setWidth 128 x_1 >>> (x.toNat % 340282366920938463463374607431768211456 &&& 31)))
      fun x' => some (setWidth 64 x')) ⊑
    if 64#64 ≤ setWidth 64 x &&& 31#64 then none
    else some (setWidth 64 x_1 >>> ((x.toNat &&& 31) % 18446744073709551616)) := sorry

theorem test13_thm (x x_1 : BitVec 32) :
  (Option.bind
      (if 128#128 ≤ setWidth 128 x &&& 31#128 then none
      else some ((signExtend 128 x_1).sshiftRight (x.toNat % 340282366920938463463374607431768211456 &&& 31)))
      fun x' => some (setWidth 64 x')) ⊑
    if 64#64 ≤ setWidth 64 x &&& 31#64 then none
    else some ((signExtend 64 x_1).sshiftRight ((x.toNat &&& 31) % 18446744073709551616)) := sorry

theorem trunc_shl_31_i32_i64_thm (x : BitVec 64) : setWidth 32 (x <<< 31) = setWidth 32 x <<< 31 := sorry

theorem trunc_shl_nsw_31_i32_i64_thm (x : BitVec 64) :
  ((if (x <<< 31).sshiftRight 31 = x then none else some (x <<< 31)).bind fun x' => some (setWidth 32 x')) ⊑
    some (setWidth 32 x <<< 31) := sorry

theorem trunc_shl_nuw_31_i32_i64_thm (x : BitVec 64) :
  ((if x <<< 31 >>> 31 = x then none else some (x <<< 31)).bind fun x' => some (setWidth 32 x')) ⊑
    some (setWidth 32 x <<< 31) := sorry

theorem trunc_shl_nsw_nuw_31_i32_i64_thm (x : BitVec 64) :
  ((if (x <<< 31).sshiftRight 31 = x then none else if x <<< 31 >>> 31 = x then none else some (x <<< 31)).bind
      fun x' => some (setWidth 32 x')) ⊑
    some (setWidth 32 x <<< 31) := sorry

theorem trunc_shl_15_i16_i64_thm (x : BitVec 64) : setWidth 16 (x <<< 15) = setWidth 16 x <<< 15 := sorry

theorem trunc_shl_15_i16_i32_thm (x : BitVec 32) : setWidth 16 (x <<< 15) = setWidth 16 x <<< 15 := sorry

theorem trunc_shl_7_i8_i64_thm (x : BitVec 64) : setWidth 8 (x <<< 7) = setWidth 8 x <<< 7 := sorry

theorem trunc_shl_1_i32_i64_thm (x : BitVec 64) : setWidth 32 (x <<< 1) = setWidth 32 x <<< 1 := sorry

theorem trunc_shl_16_i32_i64_thm (x : BitVec 64) : setWidth 32 (x <<< 16) = setWidth 32 x <<< 16 := sorry

theorem trunc_shl_33_i32_i64_thm (x : BitVec 64) : setWidth 32 (x <<< 33) = 0#32 := sorry

theorem trunc_shl_32_i32_i64_thm (x : BitVec 64) : setWidth 32 (x <<< 32) = 0#32 := sorry

theorem trunc_shl_lshr_infloop_thm (x : BitVec 64) : setWidth 32 (x >>> 1 <<< 2) = setWidth 32 x <<< 1 &&& 4294967292#32 := sorry

theorem trunc_shl_ashr_infloop_thm (x : BitVec 64) :
  setWidth 32 (x.sshiftRight 3 <<< 2) = setWidth 32 (x >>> 1) &&& 4294967292#32 := sorry

theorem trunc_shl_shl_infloop_thm (x : BitVec 64) : setWidth 32 (x <<< 3) = setWidth 32 x <<< 3 := sorry

theorem trunc_shl_lshr_var_thm (x x_1 : BitVec 64) :
  (Option.bind (if 64#64 ≤ x then none else some (x_1 >>> x.toNat)) fun x => some (setWidth 32 (x <<< 2))) ⊑
    Option.bind (if 64#64 ≤ x then none else some (x_1 >>> x.toNat)) fun x => some (setWidth 32 x <<< 2) := sorry

theorem trunc_shl_ashr_var_thm (x x_1 : BitVec 64) :
  (Option.bind (if 64#64 ≤ x then none else some (x_1.sshiftRight x.toNat)) fun x => some (setWidth 32 (x <<< 2))) ⊑
    Option.bind (if 64#64 ≤ x then none else some (x_1.sshiftRight x.toNat)) fun x =>
      some (setWidth 32 x <<< 2) := sorry

theorem trunc_shl_shl_var_thm (x x_1 : BitVec 64) :
  (Option.bind (if 64#64 ≤ x then none else some (x_1 <<< x.toNat)) fun x => some (setWidth 32 (x <<< 2))) ⊑
    Option.bind (if 64#64 ≤ x then none else some (x_1 <<< x.toNat)) fun x => some (setWidth 32 x <<< 2) := sorry

theorem drop_nsw_trunc_thm (x x_1 : BitVec 16) :
  setWidth 8 x_1 &&& 255#8 &&& setWidth 8 x = setWidth 8 x_1 &&& setWidth 8 x := sorry

theorem drop_nuw_trunc_thm (x x_1 : BitVec 16) :
  setWidth 8 x_1 &&& 255#8 &&& setWidth 8 x = setWidth 8 x_1 &&& setWidth 8 x := sorry

theorem drop_both_trunc_thm (x x_1 : BitVec 16) :
  setWidth 8 x_1 &&& 255#8 &&& setWidth 8 x = setWidth 8 x_1 &&& setWidth 8 x := sorry

