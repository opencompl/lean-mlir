"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
    %0 = "llvm.intr.smin"(%arg0, %arg1) : (i64, i64) -> i64
    %1 = "llvm.srem"(%0, %arg1) : (i64, i64) -> i64
    %2 = "llvm.mlir.constant"() <{value = -2293592565771025543 : i64}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %6 = "llvm.icmp"(%arg2, %4) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %7 = "llvm.select"(%6, %5, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %8 = "llvm.add"(%7, %2) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %9 = "llvm.sdiv"(%8, %arg2) : (i64, i64) -> i64
    %10 = "llvm.add"(%9, %3) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %11 = "llvm.mlir.constant"() <{value = 2293592565771025543 : i64}> : () -> i64
    %12 = "llvm.sdiv"(%11, %arg2) : (i64, i64) -> i64
    %13 = "llvm.sub"(%4, %12) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %14 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %15 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %16 = "llvm.icmp"(%arg2, %4) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %17 = "llvm.icmp"(%arg2, %4) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %18 = "llvm.and"(%14, %16) : (i1, i1) -> i1
    %19 = "llvm.and"(%15, %17) : (i1, i1) -> i1
    %20 = "llvm.or"(%18, %19) : (i1, i1) -> i1
    %21 = "llvm.select"(%20, %10, %13) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %22 = "llvm.sdiv"(%1, %21) : (i64, i64) -> i64
    "llvm.return"(%22) : (i64) -> ()
  }) {seed = 12 : index} : () -> ()
}) : () -> ()

