"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.and"(%0, %arg0) : (i1, i1) -> i1
    %3 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %4 = "llvm.urem"(%arg2, %3) : (i1, i1) -> i1
    %5 = "llvm.lshr"(%arg1, %4) : (i1, i1) -> i1
    %6 = "llvm.ashr"(%2, %5) : (i1, i1) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {seed = 10 : index} : () -> ()
}) : () -> ()

