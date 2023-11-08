"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g0", type = i8} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g1", type = i8} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sub"(%0, %arg2) : (i8, i8) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t0", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sub"(%0, %arg2) : (i8, i8) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t1_flags", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sub"(%0, %arg2) : (i8, i8) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "n2", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.sub"(%1, %arg1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t3_c0", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %1 = "llvm.sub"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.sub"(%1, %arg1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t4_c1", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %1 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    %2 = "llvm.sub"(%1, %0) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t5_c2", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.sub"(%1, %arg1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t6_c0_extrause", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %1 = "llvm.sub"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.sub"(%1, %arg1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t7_c1_extrause", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %1 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.sub"(%1, %0) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t8_c2_extrause", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %2 = "llvm.sub"(%1, %arg0) : (i8, i8) -> i8
    %3 = "llvm.sub"(%2, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t9_c0_c2", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %2 = "llvm.sub"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.sub"(%2, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t10_c1_c2", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %2 = "llvm.sub"(%1, %arg0) : (i8, i8) -> i8
    "llvm.call"(%2) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %3 = "llvm.sub"(%2, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t11_c0_c2_extrause", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 42 : i8} : () -> i8
    %2 = "llvm.sub"(%arg0, %1) : (i8, i8) -> i8
    "llvm.call"(%2) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %3 = "llvm.sub"(%2, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t12_c1_c2_exrause", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @g0} : () -> !llvm.ptr<i8>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i8>) -> i32
    %3 = "llvm.add"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.sub"(%0, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "constantexpr0", type = !llvm.func<i32 (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g1} : () -> !llvm.ptr<i8>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i8>) -> i32
    %2 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %3 = "llvm.add"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.sub"(%1, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "constantexpr1", type = !llvm.func<i32 (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g1} : () -> !llvm.ptr<i8>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i8>) -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @g0} : () -> !llvm.ptr<i8>
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr<i8>) -> i32
    %4 = "llvm.add"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.sub"(%1, %4) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "constantexpr2", type = !llvm.func<i32 (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g0} : () -> !llvm.ptr<i8>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i8>) -> i64
    %2 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %3 = "llvm.xor"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.add"(%3, %1) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "pr49870", type = !llvm.func<i64 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
