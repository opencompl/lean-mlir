"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.urem"(%0, %1) : (i1, i1) -> i1
    %3 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %4 = "llvm.urem"(%2, %3) : (i1, i1) -> i1
    %5 = "llvm.srem"(%2, %4) : (i1, i1) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {seed = 152 : index} : () -> ()
}) : () -> ()

