{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
"llvm.return"(%arg0) : (i1) -> ()
}
