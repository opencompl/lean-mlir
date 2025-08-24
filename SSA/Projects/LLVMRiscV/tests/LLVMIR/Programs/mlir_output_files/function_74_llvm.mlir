"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = 7916645702478358597 : i64}> : () -> i64
    %1 = "llvm.intr.smax"(%arg0, %0) : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {seed = 73 : index} : () -> ()
}) : () -> ()

