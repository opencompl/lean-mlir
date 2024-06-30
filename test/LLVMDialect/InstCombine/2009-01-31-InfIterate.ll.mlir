"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i1, %arg3: i128, %arg4: i128, %arg5: !llvm.ptr<i64>, %arg6: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.trunc"(%arg3) : (i128) -> i64
    %1 = "llvm.trunc"(%arg4) : (i128) -> i64
    "llvm.store"(%0, %arg5) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.store"(%1, %arg6) : (i64, !llvm.ptr<i64>) -> ()
    %2 = "llvm.sub"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.sub"(%0, %1) : (i64, i64) -> i64
    %4 = "llvm.zext"(%arg2) : (i1) -> i64
    %5 = "llvm.sub"(%3, %4) : (i64, i64) -> i64
    "llvm.br"(%5)[^bb1] : (i64) -> ()
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = "llvm.zext"(%6) : (i64) -> i128
    "llvm.return"(%7) : (i128) -> ()
  ^bb2:  // no predecessors
    "llvm.br"(%0)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i128 (i64, i64, i1, i128, i128, ptr<i64>, ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
