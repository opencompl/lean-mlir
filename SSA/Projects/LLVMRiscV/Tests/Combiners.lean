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
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_of_anyext_rw.lhs)).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_of_zext_rw.lhs)).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_of_truncate_rw.lhs)).val).val


/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.not"(%0) : (i64) -> (i64)
    %3 = "llvm.and"(%2, %1) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner xor_of_and_with_same_reg.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%1, %0)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner ZeroMinusAPlusB.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusZeroMinusB.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusBMinusA.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner BMinusAPlusA.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.sub"(%2, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AMinusBPlusCMinusA.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.sub"(%0, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AMinusBPlusBMinusC.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.add"(%0, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    %4 = "llvm.sub"(%1, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusBMinusAPlusC.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.add"(%2, %0)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    %4 = "llvm.sub"(%1, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner APlusBMinusCPlusA.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.eq"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XPlusYEqX.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.ne"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XPlusYNeX.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.eq"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XMinusYEqX.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.ne"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XMinusYNeX.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.eq"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XXorYEqX.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.icmp.ne"(%1, %2) : (i64, i64) -> (i1)
    "llvm.return"(%3) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner redundant_binop_in_equality_XXorYNeX.lhs)).val).val


/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_add_y_sub_y.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_add_y_sub_x.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%2, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_sub_y_add_x.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%2, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner sub_add_reg_x_sub_x_add_y.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 1 : i1} : () -> (i1)
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_constant_cmp_true.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 2 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 1 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_2.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 4 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 3 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_4.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 8 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 7 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_8.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 16 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 15 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_16.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 32 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 31 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_32.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 64 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 63 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_64.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 128 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 127 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_128.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 256 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 255 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_256.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 512 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 511 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_512.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.mlir.constant"(){value = 1024 : i64} : () -> (i64)
    %2 = "llvm.mlir.constant"(){value = 1023 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_1024.lhs)).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %4 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %5 = "llvm.icmp.eq"(%4, %3) : (i64, i64) -> (i1)
    "llvm.return"(%5) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelO0PreLegalizerCombiner double_icmp_zero_and_combine.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.mlir.constant"(){value = 0 : i64} : () -> (i64)
    %4 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %5 = "llvm.icmp.ne"(%4, %3) : (i64, i64) -> (i1)
    "llvm.return"(%5) : (i1) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelO0PreLegalizerCombiner double_icmp_zero_or_combine.lhs)).val).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.and"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.sext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndSextSext.lhs)).val).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.or"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.sext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrSextSext.lhs)).val).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.sext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorSextSext.lhs)).val).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.and"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.zext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndZextZext.lhs)).val).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.or"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.zext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrZextZext.lhs)).val).val

/--
info: {
  ^bb0(%0 : i32, %1 : i32):
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> (i32)
    %3 = "llvm.zext"(%2) : (i32) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorZextZext.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %3 = "llvm.trunc"(%2) : (i64) -> (i32)
    "llvm.return"(%3) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndTruncTrunc.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %3 = "llvm.trunc"(%2) : (i64) -> (i32)
    "llvm.return"(%3) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrTruncTrunc.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %3 = "llvm.trunc"(%2) : (i64) -> (i32)
    "llvm.return"(%3) : (i32) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorTruncTrunc.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.shl"(%3, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndShlShl.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.shl"(%3, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrShlShl.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.shl"(%3, %2)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorShlShl.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.lshr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndLshrLshr.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.lshr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrLshrLshr.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.lshr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorLshrLshr.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.ashr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndAshrAshr.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.ashr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrAshrAshr.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.ashr"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorAshrAshr.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.and"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner AndAndAnd.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.and"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner OrAndAnd.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64, %2 : i64):
    %3 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    %4 = "llvm.and"(%3, %2) : (i64, i64) -> (i64)
    "llvm.return"(%4) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner XorAndAnd.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.add"(%0, %0)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulo_by_2_unsigned_signed.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.add"(%0, %0)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulo_by_2_unsigned.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.add"(%0, %0)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner mulo_by_2_signed.lhs)).val).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.zext"(%0) : (i1) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_1_0.lhs)).val).val).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.sext"(%0) : (i1) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_neg1_0.lhs)).val).val).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.not"(%0) : (i1) -> (i1)
    %2 = "llvm.zext"(%1) : (i1) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_0_1.lhs)).val).val).val

/--
info: {
  ^bb0(%0 : i1):
    %1 = "llvm.not"(%0) : (i1) -> (i1)
    %2 = "llvm.sext"(%1) : (i1) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_0_neg1.lhs)).val).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_cond_f.lhs)).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_1_f.lhs)).val).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_t_cond.lhs)).val).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_t_0.lhs)).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_t_1.lhs)).val).val).val

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
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_0_f.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.freeze"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner idempotent_prop_freeze.lhs)).val).val
