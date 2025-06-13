"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.mul"(%arg0, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    %1 = "llvm.add"(%0, %0) <{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {seed = 133 : index} : () -> ()
}) : () -> ()

