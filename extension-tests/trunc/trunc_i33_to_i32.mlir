{
^bb0(%arg0: i33):
  %0 = "llvm.trunc"(%arg0) : (i33) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
