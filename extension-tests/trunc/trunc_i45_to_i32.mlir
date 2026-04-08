{
^bb0(%arg0: i45):
  %0 = "llvm.trunc"(%arg0) : (i45) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
