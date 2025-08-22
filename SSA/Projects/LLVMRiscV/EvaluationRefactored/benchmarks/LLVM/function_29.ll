"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.sext"(%arg0) : (i1) -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {seed = 29 : index} : () -> ()
}) : () -> ()

