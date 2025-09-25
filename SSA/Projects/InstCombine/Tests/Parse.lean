import SSA.Projects.InstCombine.LLVM.EDSL

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%0: i64, %1 : i64):
    %2 = "llvm.add"(%0, %1) {overflowFlags = 0 : i64} : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}]

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%0: i64, %1 : i64):
    %2 = "llvm.add"(%0, %1) {overflowFlags = 1 : i64} : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}]

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%0: i64, %1 : i64):
    %2 = "llvm.add"(%0, %1) {overflowFlags = 2 : i64} : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}]

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%0: i64, %1 : i64):
    %2 = "llvm.add"(%0, %1) {overflowFlags = 3 : i64} : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}]
