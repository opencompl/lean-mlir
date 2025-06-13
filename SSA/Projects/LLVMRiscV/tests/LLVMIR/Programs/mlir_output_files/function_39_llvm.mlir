"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 6184929394769412034 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1248357989847357726 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 3793952073406212796 : i64}> : () -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {seed = 38 : index} : () -> ()
}) : () -> ()

