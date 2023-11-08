"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32768 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -32768 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32768 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -32768 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%3, %1) : (i32, i32) -> i32
    "llvm.call"(%4) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %5 = "llvm.add"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg_extra_use", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32768> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<-32768> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() {value = dense<65535> : vector<2xi32>} : () -> vector<2xi32>
    %3 = "llvm.and"(%arg0, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.xor"(%3, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.add"(%4, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%5) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg_splat", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -32768 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32768 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg_alt", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-32768> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<32768> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() {value = dense<65535> : vector<2xi32>} : () -> vector<2xi32>
    %3 = "llvm.and"(%arg0, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.xor"(%3, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.add"(%4, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%5) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg_alt_splat", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -32768 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32768 : i32} : () -> i32
    %2 = "llvm.zext"(%arg0) : (i16) -> i32
    %3 = "llvm.xor"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sext", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -32768 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32768 : i32} : () -> i32
    %2 = "llvm.zext"(%arg0) : (i16) -> i32
    %3 = "llvm.xor"(%2, %1) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %4 = "llvm.add"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_extra_use", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-32768> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<32768> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.xor"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.add"(%3, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%4) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_splat", type = !llvm.func<vector<2xi32> (vector<2xi16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -128 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 128 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg2", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-128> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<128> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() {value = dense<255> : vector<2xi32>} : () -> vector<2xi32>
    %3 = "llvm.and"(%arg0, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.xor"(%3, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.add"(%4, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%5) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "sextinreg2_splat", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.shl"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.ashr"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    %2 = "llvm.shl"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi12>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<20> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.zext"(%arg0) : (vector<2xi12>) -> vector<2xi32>
    %2 = "llvm.shl"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.ashr"(%2, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%3) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test6_splat_vec", type = !llvm.func<vector<2xi32> (vector<2xi12>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -67108864 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 67108864 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %3 = "llvm.lshr"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-67108864> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<67108864> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() {value = dense<5> : vector<2xi32>} : () -> vector<2xi32>
    %3 = "llvm.lshr"(%arg0, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.xor"(%3, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.add"(%4, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%5) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_splat", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
