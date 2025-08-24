"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %1 = "llvm.srem"(%0, %arg0) : (i1, i1) -> i1
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %3 = "llvm.icmp"(%arg0, %2) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %4 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %5 = "llvm.sub"(%arg0, %4) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %6 = "llvm.udiv"(%5, %1) : (i1, i1) -> i1
    %7 = "llvm.add"(%6, %4) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %8 = "llvm.select"(%3, %2, %7) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    "llvm.return"(%8) : (i1) -> ()
  }) {seed = 118 : index} : () -> ()
}) : () -> ()

