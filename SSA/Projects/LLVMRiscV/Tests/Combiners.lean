import SSA.Projects.InstCombine.LLVM.Opt
import LeanMLIR.Framework.Print


/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.add"(%1, %3)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %5 = "llvm.add"(%2, %3)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_add_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.sub"(%1, %3)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %5 = "llvm.sub"(%2, %3)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_sub_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.and"(%1, %3) : (i64, i64) -> (i64)
  %5 = "llvm.and"(%2, %3) : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_and_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.or"(%1, %3) : (i64, i64) -> (i64)
  %5 = "llvm.or"(%2, %3) : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_or_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.xor"(%1, %3) : (i64, i64) -> (i64)
  %5 = "llvm.xor"(%2, %3) : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_xor_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.sdiv"(%1, %3) : (i64, i64) -> (i64)
  %5 = "llvm.sdiv"(%2, %3) : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_sdiv_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.udiv"(%1, %3) : (i64, i64) -> (i64)
  %5 = "llvm.udiv"(%2, %3) : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_udiv_into_select.lhs)).val).val

/--
info:
^bb0(%0 : i1, %1 : i64, %2 : i64, %3 : i64):
  %4 = "llvm.shl"(%1, %3)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %5 = "llvm.shl"(%2, %3)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %6 = "llvm.select"(%0, %4, %5) : (i1, i64, i64) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner fold_shl_into_select.lhs)).val).val
