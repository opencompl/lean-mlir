{
^bb0(%arg0: i57):
  %0 = "llvm.trunc"(%arg0) : (i57) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
