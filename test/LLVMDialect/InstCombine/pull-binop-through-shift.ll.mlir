"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_signbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_nosignbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_signbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_nosignbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_signbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_nosignbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "add_signbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "add_nosignbit_shl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_signbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_nosignbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_signbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_nosignbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_signbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_nosignbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "add_signbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "add_nosignbit_lshr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_signbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_nosignbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_signbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_nosignbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_signbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_nosignbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "add_signbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147418112 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "add_nosignbit_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
