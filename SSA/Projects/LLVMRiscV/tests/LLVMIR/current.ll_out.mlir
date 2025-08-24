{
 ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    %0 = "llvm.sdiv"(%arg1, %arg2) : (i1, i1) -> i1
    %1 = "llvm.mul"(%0, %arg2) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %2 = "llvm.icmp"(%arg1, %1) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %3 = "llvm.mlir.constant"() <{value = 0 : i1}> : () -> i1
    %4 = "llvm.icmp"(%arg1, %3) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %5 = "llvm.icmp"(%arg2, %3) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %6 = "llvm.icmp"(%4, %5) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %7 = "llvm.and"(%2, %6) : (i1, i1) -> i1
    %8 = "llvm.mlir.constant"() <{value = 1 : i1}> : () -> i1
    %9 = "llvm.add"(%0, %8) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %10 = "llvm.select"(%7, %9, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %11 = "llvm.sdiv"(%arg0, %10) : (i1, i1) -> i1
    %12 = "llvm.mlir.constant"() <{value = 1 : i1}> : () -> i1
    %13 = "llvm.xor"(%arg2, %12) : (i1, i1) -> i1
    %14 = "llvm.sdiv"(%11, %13) : (i1, i1) -> i1
    %15 = "llvm.mul"(%14, %13) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %16 = "llvm.icmp"(%11, %15) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %17 = "llvm.mlir.constant"() <{value = 0 :i1}> : () -> i1
    %18 = "llvm.icmp"(%11, %17) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %19 = "llvm.icmp"(%13, %17) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %20 = "llvm.icmp"(%18, %19) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %21 = "llvm.and"(%16, %20) : (i1, i1) -> i1
    %22 = "llvm.mlir.constant"() <{value = 1 : i1}> : () -> i1
    %23 = "llvm.add"(%14, %22) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %24 = "llvm.select"(%21, %23, %14) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    "llvm.return"(%24) : (i1) -> ()
}
