"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = -7735419487501869099 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 7921516532864124901 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 2789808053343557616 : i64}> : () -> i64
    %3 = "llvm.shl"(%2, %2) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %4 = "llvm.mul"(%2, %3) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {seed = 28 : index} : () -> ()
}) : () -> ()

