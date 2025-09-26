import SSA.Projects.InstCombine.LLVM.Opt
import LeanMLIR.Framework.Print

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.const"(){value = 1 : i1} : () -> (i1)
  %3 = "llvm.select"(%2, %0, %1) : (i1, i64, i64) -> (i64)
  "llvm.return"(%0) : (i64) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 GLobalISelPostLegalizerCombiner select_constant_cmp_true.lhs)
