"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %1 = "llvm.intr.smax"(%arg0, %arg0) : (i1, i1) -> i1
    %2 = "llvm.lshr"(%arg0, %1) : (i1, i1) -> i1
    %3 = "llvm.ashr"(%0, %2) : (i1, i1) -> i1
    %4 = "llvm.xor"(%3, %arg0) : (i1, i1) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {seed = 144 : index} : () -> ()
}) : () -> ()

