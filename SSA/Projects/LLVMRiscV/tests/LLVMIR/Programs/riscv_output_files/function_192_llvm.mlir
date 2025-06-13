"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "llvm.intr.umax"(%arg0, %arg1) : (i1, i1) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {seed = 191 : index} : () -> ()
}) : () -> ()

