import SSA.Projects.InstCombine.LLVM.Opt
import LeanMLIR.Framework.Print

/--
info: {
  ^bb0(%0 : i1, %1 : i32, %2 : i32):
    %3 = "llvm.sext"(%1) : (i32) -> (i64)
    %4 = "llvm.sext"(%2) : (i32) -> (i64)
    %5 = "llvm.select"(%0, %3, %4) : (i1, i64, i64) -> (i64)
    "llvm.return"(%5) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_of_anyext_rw.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i32, %2 : i32):
    %3 = "llvm.zext"(%1) : (i32) -> (i64)
    %4 = "llvm.zext"(%2) : (i32) -> (i64)
    %5 = "llvm.select"(%0, %3, %4) : (i1, i64, i64) -> (i64)
    "llvm.return"(%5) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_of_zext_rw.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64, %2 : i64):
    %3 = "llvm.trunc"(%1) : (i64) -> (i32)
    %4 = "llvm.trunc"(%2) : (i64) -> (i32)
    %5 = "llvm.select"(%0, %3, %4) : (i1, i32, i32) -> (i32)
    "llvm.return"(%5) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_of_truncate_rw.lhs)).val


/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.not"(%0) : (i64) -> (i64)
    %3 = "llvm.and"(%2, %1) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner xor_of_and_with_same_reg.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%1, %0)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner ZeroMinusAPlusB.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusZeroMinusB.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusBMinusA.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner BMinusAPlusA.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.sub"(%2, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AMinusBPlusCMinusA.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.sub"(%0, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AMinusBPlusBMinusC.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.sub"(%1, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusBMinusAPlusC.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.sub"(%1, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusBMinusCPlusA.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.eq"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XPlusYEqX.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.ne"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XPlusYNeX.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.eq"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XMinusYEqX.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.ne"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XMinusYNeX.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.eq"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XXorYEqX.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.ne"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XXorYNeX.lhs)).val


/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_add_y_sub_y.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_add_y_sub_x.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%2, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_sub_y_add_x.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%2, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_sub_x_add_y.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_constant_cmp_true.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 1 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_2.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 3 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_4.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 7 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_8.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 15 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_16.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 31 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_32.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 63 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_64.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 127 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_128.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 255 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_256.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 511 : i64} : () -> (i64)
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_512.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.icmp.eq"(%3, %2) : (i64, i64) -> (i1)
    "llvm.return"(%4) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelO0PreLegalizerCombiner double_icmp_zero_and_combine.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.icmp.ne"(%3, %2) : (i64, i64) -> (i1)
    "llvm.return"(%4) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelO0PreLegalizerCombiner double_icmp_zero_or_combine.lhs)).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.and"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.sext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndSextSext.lhs)).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.or"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.sext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrSextSext.lhs)).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.sext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorSextSext.lhs)).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.and"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.zext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndZextZext.lhs)).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.or"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.zext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrZextZext.lhs)).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.zext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorZextZext.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %3 = "llvm.trunc"(%2) : (i64) -> (i32)
    "llvm.return"(%3) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndTruncTrunc.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %3 = "llvm.trunc"(%2) : (i64) -> (i32)
    "llvm.return"(%3) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrTruncTrunc.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %3 = "llvm.trunc"(%2) : (i64) -> (i32)
    "llvm.return"(%3) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorTruncTrunc.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.shl"(%3, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndShlShl.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.shl"(%3, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrShlShl.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.shl"(%3, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorShlShl.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.lshr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndLshrLshr.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.lshr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrLshrLshr.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.lshr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorLshrLshr.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.ashr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndAshrAshr.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.ashr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrAshrAshr.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.ashr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorAshrAshr.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.and"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndAndAnd.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.and"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrAndAnd.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.and"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorAndAnd.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.add"(%0, %0)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulo_by_2_unsigned_signed.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.add"(%0, %0)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulo_by_2_unsigned.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.add"(%0, %0)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulo_by_2_signed.lhs)).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.zext"(%0) : (i1) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_1_0.lhs)).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.sext"(%0) : (i1) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_neg1_0.lhs)).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.not"(%0) : (i1) -> (i1)
    %2 = "llvm.zext"(%1) : (i1) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_0_1.lhs)).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.not"(%0) : (i1) -> (i1)
    %2 = "llvm.sext"(%1) : (i1) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_0_neg1.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64):
    %2 = "llvm.sext"(%0) : (i1) -> (i64)
    %3 = "llvm.freeze"(%1) : (i64) -> (i64)
    %4 = "llvm.or"(%2, %3) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_cond_f.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64):
    %2 = "llvm.sext"(%0) : (i1) -> (i64)
    %3 = "llvm.freeze"(%1) : (i64) -> (i64)
    %4 = "llvm.or"(%2, %3) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_1_f.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64):
    %2 = "llvm.sext"(%0) : (i1) -> (i64)
    %3 = "llvm.freeze"(%1) : (i64) -> (i64)
    %4 = "llvm.and"(%2, %3) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_t_cond.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64):
    %2 = "llvm.sext"(%0) : (i1) -> (i64)
    %3 = "llvm.freeze"(%1) : (i64) -> (i64)
    %4 = "llvm.and"(%2, %3) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_t_0.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64):
    %2 = "llvm.not"(%0) : (i1) -> (i1)
    %3 = "llvm.sext"(%2) : (i1) -> (i64)
    %4 = "llvm.freeze"(%1) : (i64) -> (i64)
    %5 = "llvm.or"(%3, %4) : (i64, i64) -> (i64)
    "llvm.return"(%5) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_t_1.lhs)).val

/--
info: {
  ^bb0(%0 : i1, %1 : i64):
    %2 = "llvm.not"(%0) : (i1) -> (i1)
    %3 = "llvm.sext"(%2) : (i1) -> (i64)
    %4 = "llvm.freeze"(%1) : (i64) -> (i64)
    %5 = "llvm.and"(%3, %4) : (i64, i64) -> (i64)
    "llvm.return"(%5) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_0_f.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.freeze"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner idempotent_prop_freeze.lhs)).val

/--
info: {
  ^bb0(%0 : i32):
    "llvm.return"(%0) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner trunc_of_zext.lhs)).val

/--
info: {
  ^bb0(%0 : i32):
    %1 = "llvm.zext"(%0) : (i32) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner trunc_of_zext_zext.lhs)).val

/--
info: {
  ^bb0(%0 : i32):
    %1 = "llvm.zext"(%0) : (i32) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner zext_of_zext.lhs)).val

/--
info: {
  ^bb0(%0 : i32):
    %1 = "llvm.zext"(%0) : (i32) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sext_of_zext.lhs)).val

/--
info: {
  ^bb0(%0 : i32):
    %1 = "llvm.sext"(%0) : (i32) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sext_of_sext.lhs)).val

/--
info: {
  ^bb0(%0 : i32):
    %1 = "llvm.sext"(%0) : (i32) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner zext_of_sext.lhs)).val

/--
info: {
  riscv_func.func @f(%0 : !riscv.reg):
    %1 = "riscv.li"(){immediate = 63 : i64 } : () -> (!riscv.reg)
    %2 = "riscv.sra"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    "riscv.ret"(%2) : (!riscv.reg) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulh_to_lshr_2.lhs)).val

/--
info: {
  riscv_func.func @f(%0 : !riscv.reg):
    %1 = "riscv.li"(){immediate = 62 : i64 } : () -> (!riscv.reg)
    %2 = "riscv.sra"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    "riscv.ret"(%2) : (!riscv.reg) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulh_to_lshr_4.lhs)).val

/--
info: {
  riscv_func.func @f(%0 : !riscv.reg):
    %1 = "riscv.li"(){immediate = 61 : i64 } : () -> (!riscv.reg)
    %2 = "riscv.sra"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    "riscv.ret"(%2) : (!riscv.reg) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulh_to_lshr_8.lhs)).val

/--
info: {
  riscv_func.func @f(%0 : !riscv.reg):
    %1 = "riscv.li"(){immediate = 60 : i64 } : () -> (!riscv.reg)
    %2 = "riscv.sra"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    "riscv.ret"(%2) : (!riscv.reg) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.repeatDce (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulh_to_lshr_16.lhs)).val
