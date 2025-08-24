"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1):
    %0 = "llvm.mlir.constant"() <{value = -1629065603047637383 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = -382332001542543107 : i64}> : () -> i64
    %2 = "llvm.select"(%arg1, %1, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %3 = "llvm.intr.smin"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %6 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %7 = "llvm.mlir.constant"() <{value = -1629065603047637384 : i64}> : () -> i64
    %8 = "llvm.udiv"(%7, %3) : (i64, i64) -> i64
    %9 = "llvm.add"(%8, %6) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %10 = "llvm.select"(%5, %4, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    "llvm.return"(%10) : (i64) -> ()
  }) {seed = 197 : index} : () -> ()
}) : () -> ()

