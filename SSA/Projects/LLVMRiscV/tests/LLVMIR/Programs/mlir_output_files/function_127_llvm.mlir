"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.sdiv"(%arg0, %arg0) : (i1, i1) -> i1
    %2 = "llvm.mul"(%1, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %3 = "llvm.icmp"(%arg0, %2) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %4 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %5 = "llvm.icmp"(%arg0, %4) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %6 = "llvm.icmp"(%arg0, %4) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %7 = "llvm.icmp"(%5, %6) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %8 = "llvm.and"(%3, %7) : (i1, i1) -> i1
    %9 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %10 = "llvm.add"(%1, %9) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %11 = "llvm.select"(%8, %10, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    "llvm.return"(%11) : (i1) -> ()
  }) {seed = 126 : index} : () -> ()
}) : () -> ()

