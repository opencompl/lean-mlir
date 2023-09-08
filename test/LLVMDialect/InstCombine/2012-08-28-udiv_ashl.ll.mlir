"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv400", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv400_no", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sdiv"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sdiv400_yes", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i80):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i80} : () -> i80
    %1 = "llvm.mlir.constant"() {value = 2 : i80} : () -> i80
    %2 = "llvm.lshr"(%arg0, %1) : (i80, i80) -> i80
    %3 = "llvm.udiv"(%2, %0) : (i80, i80) -> i80
    "llvm.return"(%3) : (i80) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i80", type = !llvm.func<i80 (i80)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %1 = "llvm.lshr"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.udiv"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "no_crash_notconst_udiv", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
