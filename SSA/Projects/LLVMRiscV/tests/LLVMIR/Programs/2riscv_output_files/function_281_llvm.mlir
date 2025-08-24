"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.add"(%arg0, %arg0) <{overflowFlags = #llvm.overflow<none>}> {overflowFlags = #llvm.overflow<nsw>} : (i64, i64) -> i64
    %1 = "llvm.icmp"(%0, %arg0) <{predicate = 8 : i64}> : (i64, i64) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {seed = 280 : index} : () -> ()
}) : () -> ()

