"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.udiv"(%arg0, %arg0) {isExactFlag} : (i64, i64) -> i64
    %1 = "llvm.or"(%0, %arg1) {isDisjointFlag} : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {seed = 189 : index} : () -> ()
}) : () -> ()

