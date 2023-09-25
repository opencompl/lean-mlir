"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use4", type = !llvm.func<void (i4)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "usevec", type = !llvm.func<void (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %1 = "llvm.ashr"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.trunc"(%1) : (i8) -> i4
    %3 = "llvm.sext"(%2) : (i4) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "t0", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i8} : () -> i8
    %1 = "llvm.ashr"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.trunc"(%1) : (i8) -> i4
    %3 = "llvm.sext"(%2) : (i4) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "t1", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %1 = "llvm.ashr"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.trunc"(%1) : (i8) -> i4
    %3 = "llvm.sext"(%2) : (i4) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "n2", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<4> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.ashr"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%1) {callee = @usevec, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %2 = "llvm.trunc"(%1) : (vector<2xi8>) -> vector<2xi4>
    %3 = "llvm.sext"(%2) : (vector<2xi4>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "t3_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[4, 3]> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.ashr"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%1) {callee = @usevec, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %2 = "llvm.trunc"(%1) : (vector<2xi8>) -> vector<2xi4>
    %3 = "llvm.sext"(%2) : (vector<2xi4>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "t4_vec_nonsplat", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %1 = "llvm.ashr"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.trunc"(%1) : (i8) -> i4
    "llvm.call"(%2) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    %3 = "llvm.sext"(%2) : (i4) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "t5_extrause", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.sext"(%4) : (i8) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_source_matching_signbits", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.sext"(%4) : (i8) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_source_not_matching_signbits", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.sext"(%4) : (i8) -> i24
    "llvm.return"(%5) : (i24) -> ()
  }) {linkage = 10 : i64, sym_name = "wide_source_matching_signbits", type = !llvm.func<i24 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.sext"(%4) : (i8) -> i24
    "llvm.return"(%5) : (i24) -> ()
  }) {linkage = 10 : i64, sym_name = "wide_source_not_matching_signbits", type = !llvm.func<i24 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.sext"(%4) : (i8) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "same_source_matching_signbits", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.sext"(%4) : (i8) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "same_source_not_matching_signbits", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    "llvm.call"(%4) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %5 = "llvm.sext"(%4) : (i8) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "same_source_matching_signbits_extra_use", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%0, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    "llvm.call"(%4) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %5 = "llvm.sext"(%4) : (i8) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "same_source_not_matching_signbits_extra_use", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
