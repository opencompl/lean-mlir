"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.start.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.end.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "unknown", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "f2", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "f3", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_dead", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%0, %3) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%3) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.call"(%0, %3) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_lifetime", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%0, %3) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"() {callee = @unknown, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.call"(%3) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.call"() {callee = @unknown, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.call"(%0, %3) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_lifetime2", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_dead_readwrite", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    %3 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_read_after", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_infinite_loop", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_throw", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_extra_write", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%3, %4) {callee = @f2, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_unmodeled_write", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<ptr<i8>>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%2) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    "llvm.call"(%3, %4) {callee = @f2, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %5 = "llvm.load"(%2) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %7 = "llvm.load"(%6) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_captured_by_call", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<ptr<i8>>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%2) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    "llvm.store"(%3, %2) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.call"(%3) {callee = @f, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    %5 = "llvm.load"(%2) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %7 = "llvm.load"(%6) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_captured_before", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%3, %4) {callee = @f2, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_unreleated_read", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4) {callee = @f3, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_unrelated_capture", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4) {callee = @f3, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %6 = "llvm.load"(%5) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%6) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test_neg_unrelated_capture_used_via_return", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<i32>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%2, %2) {callee = @f2, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_self_read", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "removable_readnone", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "removable_ro", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    "llvm.call"() {callee = @removable_readnone, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_readnone", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    "llvm.call"() {callee = @removable_readnone, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_readnone_with_deopt", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    "llvm.call"() {callee = @removable_ro, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_readonly", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    "llvm.call"() {callee = @removable_ro, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_readonly_with_deopt", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
