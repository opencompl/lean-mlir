import SSA.Projects.InstCombine.LLVM.Opt
import LeanMLIR.Framework.Print

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
