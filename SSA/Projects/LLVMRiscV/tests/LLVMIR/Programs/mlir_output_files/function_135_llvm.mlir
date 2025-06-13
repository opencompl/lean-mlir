"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "llvm.sdiv"(%arg0, %arg0) : (i1, i1) -> i1
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.icmp"(%0, %1) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %3 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %4 = "llvm.sub"(%0, %3) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %5 = "llvm.udiv"(%4, %arg1) : (i1, i1) -> i1
    %6 = "llvm.add"(%5, %3) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %7 = "llvm.select"(%2, %1, %6) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %8 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %9 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %10 = "llvm.sub"(%9, %arg1) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %11 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %12 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %13 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %14 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %15 = "llvm.udiv"(%14, %10) : (i1, i1) -> i1
    %16 = "llvm.add"(%15, %13) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %17 = "llvm.select"(%12, %11, %16) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %18 = "llvm.add"(%7, %17) <{overflowFlags = #llvm.overflow<nsw>}> : (i1, i1) -> i1
    "llvm.return"(%18) : (i1) -> ()
  }) {seed = 134 : index} : () -> ()
}) : () -> ()

