"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.shl"(%arg0, %arg1) <{overflowFlags = #llvm.overflow<none>}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {seed = 474 : index} : () -> ()
}) : () -> ()

