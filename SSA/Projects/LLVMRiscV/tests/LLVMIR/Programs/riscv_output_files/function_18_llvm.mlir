"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = -8016584723174229753 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1713136009960174413 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = -8684885439175505334 : i64}> : () -> i64
    %3 = "llvm.and"(%arg0, %2) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {seed = 17 : index} : () -> ()
}) : () -> ()

