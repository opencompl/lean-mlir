"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64, i1, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
    %0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.trunc"(%arg1) <{overflowFlags = #llvm.overflow<none>}> : (i1) -> i64
    %2 = "llvm.udiv"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.urem"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.urem"(%arg2, %1) : (i64, i64) -> i64
    %5 = "llvm.sext"(%arg1) : (i1) -> i64
    %6 = "llvm.lshr"(%5, %1) : (i64, i64) -> i64
    %7 = "llvm.add"(%arg0, %6) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %8 = "llvm.udiv"(%4, %7) : (i64, i64) -> i64
    %9 = "llvm.icmp"(%3, %8) <{predicate = 8 : i64}> : (i64, i64) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

