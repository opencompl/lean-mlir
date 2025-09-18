import SSA.Projects.InstCombine.LLVM.PrettyEDSL

/-!
## Print Tests
-/
namespace Tests

/--
info: builtin.module { ⏎
^bb0(%0 : i1, %1 : i64):
  "llvm.return"(%0) : (i1) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toPrint [llvm| {
  ^bb0(%0 : i1, %1 : i64):
    "llvm.return"(%0) : (i1) -> ()
}]

/--
info: { ⏎
^entry(%0 : i1, %1 : i64):
  "return"(%0) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%0: i64, %1: i1):
    "llvm.return"(%0) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i1, %1 : i64):
    return %0 : (i64) → ()
}
-/
#guard_msgs in #eval repr [llvm| {
  ^bb0(%0: i64, %1: i1):
    "llvm.return"(%0) : (i64) -> ()
}]
