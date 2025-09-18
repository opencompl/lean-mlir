{
  ^bb0(%arg26: i64, %arg27: i64):
    %47 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %48 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %49 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %50 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %51 = "llvm.add"(%47, %48) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %52 = "llvm.add"(%49, %50) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%52) : (i64) -> ()
}
