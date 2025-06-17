"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i1, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
    %0 = "llvm.select"(%arg0, %arg1, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %1 = "llvm.mul"(%0, %arg2) <{overflowFlags = #llvm.overflow<none>}> {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {seed = 71 : index} : () -> ()
}) : () -> ()

