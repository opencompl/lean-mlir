"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = -5828893222867816574 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = -6521698882570605103 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = -9119562089868481024 : i64}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = -6521698882570605103 : i64}> : () -> i64
    %4 = "llvm.ashr"(%0, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {seed = 67 : index} : () -> ()
}) : () -> ()

