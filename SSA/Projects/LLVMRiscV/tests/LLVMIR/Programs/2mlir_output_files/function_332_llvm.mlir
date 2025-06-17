"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.udiv"(%arg0, %arg0) {isExactFlag} : (i64, i64) -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {seed = 331 : index} : () -> ()
}) : () -> ()

