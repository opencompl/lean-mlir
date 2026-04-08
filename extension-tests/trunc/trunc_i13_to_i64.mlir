{
^bb0(%arg0: i13):
  %0 = "llvm.trunc"(%arg0) : (i13) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
