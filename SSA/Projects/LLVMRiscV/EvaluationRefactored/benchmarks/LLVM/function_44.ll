"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> {overflowFlags = #llvm.overflow<nuw>} : (i1) -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {seed = 44 : index} : () -> ()
}) : () -> ()

