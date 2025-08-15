{
  ^bb0(%arg0: i1, %arg1: i1):
    %17 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    "llvm.return"(%17) : (i1) -> ()
}