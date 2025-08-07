"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %1 = "llvm.srem"(%0, %arg0) : (i1, i1) -> i1
    %2 = "llvm.add"(%arg1, %arg2) <{overflowFlags = #llvm.overflow<nuw>}> : (i1, i1) -> i1
    %3 = "llvm.intr.umax"(%1, %2) : (i1, i1) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {seed = 27 : index} : () -> ()
}) : () -> ()

