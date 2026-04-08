{
^bb0(%arg0: i64):
  %0 = "llvm.trunc"(%arg0) : (i64) -> i43
  "llvm.return"(%0) : (i43) -> ()
}
