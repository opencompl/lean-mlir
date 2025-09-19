import SSA.Projects.InstCombine.LLVM.EDSL

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.add false true""(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
  "llvm.return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toPrint [llvm| {
  ^bb0(%0: i64, %1 : i64):
    %2 = "llvm.add"(%0, %1) {overflowFlags = #llvm.overflow<nuw>} : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}]
