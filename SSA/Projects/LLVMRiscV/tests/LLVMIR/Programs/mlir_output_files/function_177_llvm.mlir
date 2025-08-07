"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = -4571148209368180742 : i64}> : () -> i64
    %1 = "llvm.xor"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %3 = "llvm.mul"(%1, %1) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %4 = "llvm.or"(%1, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {seed = 176 : index} : () -> ()
}) : () -> ()

