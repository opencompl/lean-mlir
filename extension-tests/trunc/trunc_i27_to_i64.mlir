{
^bb0(%arg0: i27):
  %0 = "llvm.trunc"(%arg0) : (i27) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
