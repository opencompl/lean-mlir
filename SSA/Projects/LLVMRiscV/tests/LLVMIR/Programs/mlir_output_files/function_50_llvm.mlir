"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = 3220996587549851491 : i64}> : () -> i64
    %1 = "llvm.sdiv"(%0, %arg0) : (i64, i64) -> i64
    %2 = "llvm.mul"(%1, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %4 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %6 = "llvm.icmp"(%arg0, %4) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %7 = "llvm.icmp"(%5, %6) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %8 = "llvm.and"(%3, %7) : (i1, i1) -> i1
    %9 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %10 = "llvm.add"(%1, %9) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %11 = "llvm.select"(%8, %10, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %12 = "llvm.lshr"(%11, %11) : (i64, i64) -> i64
    %13 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %14 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %15 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %16 = "llvm.icmp"(%arg0, %14) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %17 = "llvm.select"(%16, %15, %13) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %18 = "llvm.add"(%17, %12) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %19 = "llvm.sdiv"(%18, %arg0) : (i64, i64) -> i64
    %20 = "llvm.add"(%19, %13) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %21 = "llvm.sub"(%14, %12) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %22 = "llvm.sdiv"(%21, %arg0) : (i64, i64) -> i64
    %23 = "llvm.sub"(%14, %22) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %24 = "llvm.icmp"(%12, %14) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %25 = "llvm.icmp"(%12, %14) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %26 = "llvm.icmp"(%arg0, %14) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %27 = "llvm.icmp"(%arg0, %14) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %28 = "llvm.and"(%24, %26) : (i1, i1) -> i1
    %29 = "llvm.and"(%25, %27) : (i1, i1) -> i1
    %30 = "llvm.or"(%28, %29) : (i1, i1) -> i1
    %31 = "llvm.select"(%30, %20, %23) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %32 = "llvm.intr.umin"(%31, %12) : (i64, i64) -> i64
    %33 = "llvm.or"(%32, %11) : (i64, i64) -> i64
    "llvm.return"(%33) : (i64) -> ()
  }) {seed = 49 : index} : () -> ()
}) : () -> ()

