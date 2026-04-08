{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) : (i32) -> i5
  "llvm.return"(%0) : (i5) -> ()
}
