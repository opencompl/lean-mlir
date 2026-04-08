{
^bb0(%arg0: i48):
  %0 = "llvm.trunc"(%arg0) : (i48) -> i33
  "llvm.return"(%0) : (i33) -> ()
}
