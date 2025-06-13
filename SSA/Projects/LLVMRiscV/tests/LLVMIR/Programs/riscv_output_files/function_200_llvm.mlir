"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.constant"() <{value = 5185231879317400701 : i64}> : () -> i64
    %1 = "llvm.udiv"(%arg1, %0) : (i64, i64) -> i64
    %2 = "llvm.xor"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.intr.umin"(%2, %1) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {seed = 199 : index} : () -> ()
}) : () -> ()

