"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "llvm.shl"(%arg0, %arg1) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %1 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %3 = "llvm.lshr"(%1, %2) : (i1, i1) -> i1
    %4 = "llvm.or"(%0, %3) : (i1, i1) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {seed = 53 : index} : () -> ()
}) : () -> ()

