"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.constant"() <{value = 2026955581972156870 : i64}> : () -> i64
    %1 = "llvm.and"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.sdiv"(%1, %arg1) : (i64, i64) -> i64
    %3 = "llvm.mul"(%2, %arg1) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %4 = "llvm.icmp"(%1, %3) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %5 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %6 = "llvm.icmp"(%1, %5) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %7 = "llvm.icmp"(%arg1, %5) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %8 = "llvm.icmp"(%6, %7) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %9 = "llvm.and"(%4, %8) : (i1, i1) -> i1
    %10 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %11 = "llvm.add"(%2, %10) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %12 = "llvm.select"(%9, %11, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    "llvm.return"(%12) : (i64) -> ()
  }) {seed = 79 : index} : () -> ()
}) : () -> ()

