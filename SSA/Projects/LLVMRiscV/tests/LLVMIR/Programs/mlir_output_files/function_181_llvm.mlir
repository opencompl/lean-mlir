"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.constant"() <{value = 6061852734527939001 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = -1887855366840786876 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 398286634005578373 : i64}> : () -> i64
    %3 = "llvm.intr.smin"(%2, %arg0) : (i64, i64) -> i64
    %4 = "llvm.mul"(%3, %arg1) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {seed = 180 : index} : () -> ()
}) : () -> ()

