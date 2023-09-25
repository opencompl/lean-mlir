"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i17):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i37} : () -> i37
    %1 = "llvm.zext"(%arg0) : (i17) -> i37
    %2 = "llvm.lshr"(%1, %0) : (i37, i37) -> i37
    %3 = "llvm.shl"(%1, %0) : (i37, i37) -> i37
    %4 = "llvm.or"(%2, %3) : (i37, i37) -> i37
    %5 = "llvm.trunc"(%4) : (i37) -> i17
    "llvm.return"(%5) : (i17) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i17 (i17)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i167):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i577} : () -> i577
    %1 = "llvm.mlir.constant"() {value = 9 : i577} : () -> i577
    %2 = "llvm.zext"(%arg0) : (i167) -> i577
    %3 = "llvm.lshr"(%2, %1) : (i577, i577) -> i577
    %4 = "llvm.shl"(%2, %0) : (i577, i577) -> i577
    %5 = "llvm.or"(%3, %4) : (i577, i577) -> i577
    %6 = "llvm.trunc"(%5) : (i577) -> i167
    "llvm.return"(%6) : (i167) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i167 (i167)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
