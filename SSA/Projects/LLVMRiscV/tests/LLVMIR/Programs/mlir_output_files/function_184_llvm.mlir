"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = -7139959042225150780 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = -5533462602492950974 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = -5533462602492950974 : i64}> : () -> i64
    %3 = "llvm.udiv"(%2, %2) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {seed = 183 : index} : () -> ()
}) : () -> ()

