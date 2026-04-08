{
^bb0(%arg0: i32):
  %0 = "llvm.trunc"(%arg0) : (i32) -> i3
  "llvm.return"(%0) : (i3) -> ()
}
