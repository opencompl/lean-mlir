"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i447, %arg1: i447):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 70368744177663 : i447} : () -> i447
    %1 = "llvm.mlir.constant"() {value = 70368744177664 : i447} : () -> i447
    %2 = "llvm.and"(%arg0, %1) : (i447, i447) -> i447
    %3 = "llvm.and"(%arg1, %0) : (i447, i447) -> i447
    %4 = "llvm.xor"(%2, %3) : (i447, i447) -> i447
    "llvm.return"(%4) : (i447) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i447 (i447, i447)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1005):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i1005} : () -> i1005
    %1 = "llvm.xor"(%arg0, %0) : (i1005, i1005) -> i1005
    "llvm.return"(%1) : (i1005) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i1005 (i1005)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i123):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg0) : (i123, i123) -> i123
    "llvm.return"(%0) : (i123) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i123 (i123)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i737):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i737} : () -> i737
    %1 = "llvm.xor"(%0, %arg0) : (i737, i737) -> i737
    %2 = "llvm.xor"(%arg0, %1) : (i737, i737) -> i737
    "llvm.return"(%2) : (i737) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i737 (i737)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i700):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 288230376151711743 : i700} : () -> i700
    %1 = "llvm.or"(%arg0, %0) : (i700, i700) -> i700
    %2 = "llvm.xor"(%1, %0) : (i700, i700) -> i700
    "llvm.return"(%2) : (i700) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i700 (i700)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i77):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 23 : i77} : () -> i77
    %1 = "llvm.xor"(%arg0, %0) : (i77, i77) -> i77
    %2 = "llvm.xor"(%1, %0) : (i77, i77) -> i77
    "llvm.return"(%2) : (i77) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i77 (i77)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1023):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 703687463 : i1023} : () -> i1023
    %1 = "llvm.mlir.constant"() {value = 70368744177663 : i1023} : () -> i1023
    %2 = "llvm.or"(%arg0, %1) : (i1023, i1023) -> i1023
    %3 = "llvm.xor"(%2, %0) : (i1023, i1023) -> i1023
    "llvm.return"(%3) : (i1023) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i1023 (i1023)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
