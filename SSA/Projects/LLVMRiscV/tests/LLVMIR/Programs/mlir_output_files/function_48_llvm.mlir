"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 8586503299156924594 : i64}> : () -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {seed = 47 : index} : () -> ()
}) : () -> ()

