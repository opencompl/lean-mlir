"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64, i1, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
    %0 = "llvm.add"(%arg0, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %1 = "llvm.xor"(%arg2, %arg2) : (i64, i64) -> i64
    %2 = "llvm.select"(%arg1, %arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %3 = "llvm.xor"(%arg2, %arg2) : (i64, i64) -> i64
    %4 = "llvm.lshr"(%2, %3) : (i64, i64) -> i64
    %5 = "llvm.icmp"(%0, %4) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %6 = "llvm.sext"(%5) : (i1) -> i64
    %7 = "llvm.mul"(%4, %0) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %8 = "llvm.shl"(%6, %7) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %9 = "llvm.icmp"(%8, %7) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

