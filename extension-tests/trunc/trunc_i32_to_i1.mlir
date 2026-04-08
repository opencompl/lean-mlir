{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) : (i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
