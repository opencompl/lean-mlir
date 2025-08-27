"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
    %0 = "llvm.add"(%arg0, %arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %1 = "llvm.and"(%0, %arg1) : (i64, i64) -> i64
    %2 = "llvm.mul"(%0, %1) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %3 = "llvm.sub"(%arg2, %arg1) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %4 = "llvm.sub"(%2, %3) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %5 = "llvm.shl"(%4, %0) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %6 = "llvm.and"(%5, %1) : (i64, i64) -> i64
    %7 = "llvm.srem"(%0, %6) : (i64, i64) -> i64
    %8 = "llvm.icmp"(%4, %7) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %9 = "llvm.trunc"(%8) <{overflowFlags = #llvm.overflow<none>}> : (i1) -> i64
    "llvm.return"(%9) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

