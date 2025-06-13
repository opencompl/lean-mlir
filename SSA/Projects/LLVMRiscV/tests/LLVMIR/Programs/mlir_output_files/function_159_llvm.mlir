"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i1, i1, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i64):
    %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %1 = "llvm.sdiv"(%arg0, %arg1) : (i1, i1) -> i1
    %2 = "llvm.intr.smax"(%arg0, %1) : (i1, i1) -> i1
    %3 = "llvm.zext"(%2) : (i1) -> i64
    %4 = "llvm.icmp"(%3, %arg2) <{predicate = 7 : i64}> : (i64, i64) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {seed = 158 : index} : () -> ()
}) : () -> ()

