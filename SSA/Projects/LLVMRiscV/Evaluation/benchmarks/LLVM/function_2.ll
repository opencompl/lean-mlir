"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.icmp"(%0, %arg0) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %2 = "llvm.sext"(%1) : (i1) -> i64
    %3 = "llvm.icmp"(%2, %arg0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %4 = "llvm.trunc"(%3) <{overflowFlags = #llvm.overflow<none>}> : (i1) -> i64
    %5 = "llvm.zext"(%3) : (i1) -> i64
    %6 = "llvm.icmp"(%5, %arg1) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %7 = "llvm.sext"(%6) : (i1) -> i64
    %8 = "llvm.add"(%arg1, %7) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %9 = "llvm.icmp"(%4, %8) <{predicate = 4 : i64}> : (i64, i64) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

