{
^bb0(%arg0: i11):
  %0 = "llvm.trunc"(%arg0) overflow<nsw> : (i11) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
