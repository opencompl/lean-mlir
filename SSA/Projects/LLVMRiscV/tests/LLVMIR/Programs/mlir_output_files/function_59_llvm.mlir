"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {seed = 58 : index} : () -> ()
}) : () -> ()

