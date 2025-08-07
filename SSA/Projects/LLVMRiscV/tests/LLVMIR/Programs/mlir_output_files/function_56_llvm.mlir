"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.srem"(%0, %1) : (i1, i1) -> i1
    %3 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %4 = "llvm.ashr"(%2, %3) : (i1, i1) -> i1
    %5 = "llvm.select"(%2, %4, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
    %6 = "llvm.sub"(%4, %5) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %7 = "llvm.lshr"(%6, %2) : (i1, i1) -> i1
    %8 = "llvm.ashr"(%2, %7) : (i1, i1) -> i1
    "llvm.return"(%8) : (i1) -> ()
  }) {seed = 55 : index} : () -> ()
}) : () -> ()

