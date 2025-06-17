"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1):
    %0 = "llvm.zext"(%arg1) : (i1) -> i64
    %1 = "llvm.or"(%arg0, %0) {isDisjointFlag} : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {seed = 440 : index} : () -> ()
}) : () -> ()

