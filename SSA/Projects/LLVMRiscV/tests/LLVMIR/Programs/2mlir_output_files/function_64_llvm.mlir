"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {seed = 63 : index} : () -> ()
}) : () -> ()

