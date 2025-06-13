"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.constant"() <{value = -1942878423542849690 : i64}> : () -> i64
    %1 = "llvm.sub"(%0, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %2 = "llvm.lshr"(%1, %arg1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {seed = 198 : index} : () -> ()
}) : () -> ()

