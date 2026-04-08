{
^bb0(%arg0: i37):
  %0 = "llvm.trunc"(%arg0) : (i37) -> i64
  "llvm.return"(%0) : (i64) -> ()
}
