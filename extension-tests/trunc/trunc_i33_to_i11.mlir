{
^bb0(%arg0: i33):
  %0 = "llvm.trunc"(%arg0) : (i33) -> i11
  "llvm.return"(%0) : (i11) -> ()
}
