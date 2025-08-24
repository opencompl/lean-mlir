"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = -2922715212673609339 : i64}> : () -> i64
    %1 = "llvm.sdiv"(%0, %arg0) : (i64, i64) -> i64
    %2 = "llvm.srem"(%1, %arg0) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {seed = 151 : index} : () -> ()
}) : () -> ()

