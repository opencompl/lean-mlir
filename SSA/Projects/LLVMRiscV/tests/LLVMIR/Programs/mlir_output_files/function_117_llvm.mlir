"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.sdiv"(%arg0, %0) : (i1, i1) -> i1
    %2 = "llvm.icmp"(%arg0, %0) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %3 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %4 = "llvm.icmp"(%arg0, %3) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %5 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %6 = "llvm.icmp"(%4, %5) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %7 = "llvm.and"(%2, %6) : (i1, i1) -> i1
    %8 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %9 = "llvm.add"(%1, %8) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %10 = "llvm.select"(%7, %9, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %11 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %12 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %13 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %14 = "llvm.icmp"(%arg0, %12) <{predicate = 4 : i64}> : (i1, i1) -> i1
    %15 = "llvm.select"(%14, %13, %11) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %16 = "llvm.add"(%15, %10) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %17 = "llvm.sdiv"(%16, %arg0) : (i1, i1) -> i1
    %18 = "llvm.add"(%17, %11) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %19 = "llvm.sub"(%12, %10) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %20 = "llvm.sdiv"(%19, %arg0) : (i1, i1) -> i1
    %21 = "llvm.sub"(%12, %20) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %22 = "llvm.icmp"(%10, %12) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %23 = "llvm.icmp"(%10, %12) <{predicate = 4 : i64}> : (i1, i1) -> i1
    %24 = "llvm.icmp"(%arg0, %12) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %25 = "llvm.icmp"(%arg0, %12) <{predicate = 4 : i64}> : (i1, i1) -> i1
    %26 = "llvm.and"(%22, %24) : (i1, i1) -> i1
    %27 = "llvm.and"(%23, %25) : (i1, i1) -> i1
    %28 = "llvm.or"(%26, %27) : (i1, i1) -> i1
    %29 = "llvm.select"(%28, %18, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %30 = "llvm.udiv"(%29, %10) : (i1, i1) -> i1
    "llvm.return"(%30) : (i1) -> ()
  }) {seed = 116 : index} : () -> ()
}) : () -> ()

