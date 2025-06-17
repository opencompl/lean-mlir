"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %1 = "llvm.trunc"(%0) <{overflowFlags = #llvm.overflow<none>}> {overflowFlags = #llvm.overflow<nuw>} : (i1) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {seed = 4 : index} : () -> ()
}) : () -> ()

