import SSA.Projects.InstCombine.LLVM.Opt
import LeanMLIR.Framework.Print

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.const"(){value = 0 : i64} : () -> (i64)
    %3 = "llvm.sub"(%1, %0)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner ZeroMinusAPlusB.lhs)).val).val

/--
info: {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.const"(){value = 0 : i64} : () -> (i64)
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
    %2 = "llvm.const"(){value = 1 : i1} : () -> (i1)
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_constant_cmp_true.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 2 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 1 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_2.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 4 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 3 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_4.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 8 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 7 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_8.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 16 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 15 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_16.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 32 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 31 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_32.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 64 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 63 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_64.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 128 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 127 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_128.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 256 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 255 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_256.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 512 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 511 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_512.lhs)).val

/--
info: {
  ^bb0(%0 : i64):
    %1 = "llvm.const"(){value = 1024 : i64} : () -> (i64)
    %2 = "llvm.const"(){value = 1023 : i64} : () -> (i64)
    %3 = "llvm.and"(%0, %2) : (i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner urem_pow2_to_mask_1024.lhs)).val
