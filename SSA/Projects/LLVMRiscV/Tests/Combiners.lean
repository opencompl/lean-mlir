import SSA.Projects.InstCombine.LLVM.Opt
import LeanMLIR.Framework.Print

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.const"(){value = 1 : i1} : () -> (i1)
  "llvm.return"(%0) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (DCE.dce' (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_constant_cmp_true.lhs)).val
