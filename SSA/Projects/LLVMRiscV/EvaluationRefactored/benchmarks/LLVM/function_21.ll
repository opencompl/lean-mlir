"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
    %0 = "llvm.urem"(%arg1, %arg2) {isExactFlag} : (i64, i64) -> i64
    %1 = "llvm.sub"(%arg0, %0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nuw>} : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {seed = 21 : index} : () -> ()
}) : () -> ()

