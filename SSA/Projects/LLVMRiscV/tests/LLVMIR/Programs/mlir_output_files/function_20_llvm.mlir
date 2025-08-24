"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %3 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %4 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %5 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %6 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %7 = "llvm.select"(%6, %5, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %8 = "llvm.add"(%7, %0) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %9 = "llvm.sdiv"(%8, %2) : (i1, i1) -> i1
    %10 = "llvm.add"(%9, %3) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %11 = "llvm.sub"(%4, %0) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %12 = "llvm.sdiv"(%11, %2) : (i1, i1) -> i1
    %13 = "llvm.sub"(%4, %12) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %14 = "llvm.icmp"(%0, %4) <{predicate = 2 : i64}> : (i1, i1) -> i1
    %15 = "llvm.icmp"(%0, %4) <{predicate = 4 : i64}> : (i1, i1) -> i1
    %16 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %17 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %18 = "llvm.and"(%14, %16) : (i1, i1) -> i1
    %19 = "llvm.and"(%15, %17) : (i1, i1) -> i1
    %20 = "llvm.or"(%18, %19) : (i1, i1) -> i1
    %21 = "llvm.select"(%20, %10, %13) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    "llvm.return"(%21) : (i1) -> ()
  }) {seed = 19 : index} : () -> ()
}) : () -> ()

