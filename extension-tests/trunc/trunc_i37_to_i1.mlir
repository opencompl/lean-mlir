{
^bb0(%arg0: i37):
  %0 = "llvm.trunc"(%arg0) : (i37) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
