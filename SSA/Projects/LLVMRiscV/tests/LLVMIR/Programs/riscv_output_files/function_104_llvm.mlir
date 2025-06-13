"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = -1134788058768042145 : i64}> : () -> i64
    %1 = "llvm.urem"(%arg0, %arg0) : (i64, i64) -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %5 = "llvm.icmp"(%1, %3) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %6 = "llvm.select"(%5, %4, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %7 = "llvm.add"(%6, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %8 = "llvm.sdiv"(%7, %1) : (i64, i64) -> i64
    %9 = "llvm.add"(%8, %2) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %10 = "llvm.sub"(%3, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %11 = "llvm.sdiv"(%10, %1) : (i64, i64) -> i64
    %12 = "llvm.sub"(%3, %11) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %13 = "llvm.icmp"(%arg0, %3) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %14 = "llvm.icmp"(%arg0, %3) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %15 = "llvm.icmp"(%1, %3) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %16 = "llvm.icmp"(%1, %3) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %17 = "llvm.and"(%13, %15) : (i1, i1) -> i1
    %18 = "llvm.and"(%14, %16) : (i1, i1) -> i1
    %19 = "llvm.or"(%17, %18) : (i1, i1) -> i1
    %20 = "llvm.select"(%19, %9, %12) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %21 = "llvm.xor"(%20, %0) : (i64, i64) -> i64
    "llvm.return"(%21) : (i64) -> ()
  }) {seed = 103 : index} : () -> ()
}) : () -> ()

