"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.and"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_and", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i32
    %1 = "llvm.and"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_and", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.or"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_or", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i32
    %1 = "llvm.or"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_or", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.xor"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_xor", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i32
    %1 = "llvm.xor"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_xor", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.add"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_add", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i32
    %1 = "llvm.add"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_add", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.sub"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_sub", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i32
    %1 = "llvm.sub"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_sub", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.mul"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_mul", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i32
    %1 = "llvm.mul"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_mul", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.and"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_and_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.and"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_and_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.or"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_or_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.or"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_or_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.xor"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_xor_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.xor"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_xor_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.add"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_add_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.add"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_add_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.sub"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_sub_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.sub"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_sub_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.mul"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_sext_mul_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[7, -17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sdiv"(%arg1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.zext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %3 = "llvm.mul"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "llvm.trunc"(%3) : (vector<2xi32>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_mul_commute", type = !llvm.func<vector<2xi16> (vector<2xi16>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.sext"(%arg1) : (i8) -> i32
    %3 = "llvm.add"(%1, %2) : (i32, i32) -> i32
    %4 = "llvm.ashr"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.trunc"(%4) : (i32) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_ashr_keep_trunc", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i9):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.sext"(%arg0) : (i9) -> i64
    %2 = "llvm.sext"(%arg1) : (i9) -> i64
    %3 = "llvm.add"(%1, %2) : (i64, i64) -> i64
    %4 = "llvm.ashr"(%3, %0) : (i64, i64) -> i64
    %5 = "llvm.trunc"(%4) : (i64) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_ashr_keep_trunc2", type = !llvm.func<i8 (i9, i9)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.sext"(%arg0) : (i8) -> i64
    %2 = "llvm.sext"(%arg1) : (i8) -> i64
    %3 = "llvm.add"(%1, %2) : (i64, i64) -> i64
    %4 = "llvm.ashr"(%3, %0) : (i64, i64) -> i64
    %5 = "llvm.trunc"(%4) : (i64) -> i7
    "llvm.return"(%5) : (i7) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_ashr_keep_trunc3", type = !llvm.func<i7 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi8>, %arg1: vector<8xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<8xi32>} : () -> vector<8xi32>
    %1 = "llvm.sext"(%arg0) : (vector<8xi8>) -> vector<8xi32>
    %2 = "llvm.sext"(%arg1) : (vector<8xi8>) -> vector<8xi32>
    %3 = "llvm.add"(%1, %2) : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %4 = "llvm.ashr"(%3, %0) : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %5 = "llvm.trunc"(%4) : (vector<8xi32>) -> vector<8xi8>
    "llvm.return"(%5) : (vector<8xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "narrow_zext_ashr_keep_trunc_vector", type = !llvm.func<vector<8xi8> (vector<8xi8>, vector<8xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %1 = "llvm.sext"(%arg0) : (i8) -> i16
    %2 = "llvm.sext"(%arg1) : (i8) -> i16
    %3 = "llvm.add"(%1, %2) : (i16, i16) -> i16
    %4 = "llvm.ashr"(%3, %0) : (i16, i16) -> i16
    %5 = "llvm.trunc"(%4) : (i16) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "dont_narrow_zext_ashr_keep_trunc", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
