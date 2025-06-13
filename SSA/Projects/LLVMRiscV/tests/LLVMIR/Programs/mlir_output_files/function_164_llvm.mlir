"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.icmp"(%arg0, %0) <{predicate = 3 : i64}> : (i1, i1) -> i1
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %3 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %4 = "llvm.icmp"(%arg0, %3) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %5 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %6 = "llvm.sub"(%arg0, %5) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %7 = "llvm.udiv"(%6, %2) : (i1, i1) -> i1
    %8 = "llvm.add"(%7, %5) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %9 = "llvm.select"(%4, %3, %8) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %10 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %11 = "llvm.sdiv"(%9, %10) : (i1, i1) -> i1
    %12 = "llvm.intr.smax"(%arg1, %11) : (i1, i1) -> i1
    %13 = "llvm.and"(%1, %12) : (i1, i1) -> i1
    "llvm.return"(%13) : (i1) -> ()
  }) {seed = 163 : index} : () -> ()
}) : () -> ()

