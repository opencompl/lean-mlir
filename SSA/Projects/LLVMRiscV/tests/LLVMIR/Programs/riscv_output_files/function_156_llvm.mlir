"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.add"(%0, %0) <{overflowFlags = #llvm.overflow<nuw>}> : (i1, i1) -> i1
    %3 = "llvm.sdiv"(%2, %2) : (i1, i1) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {seed = 155 : index} : () -> ()
}) : () -> ()

