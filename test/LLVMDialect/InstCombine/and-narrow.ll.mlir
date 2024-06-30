"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 44 : i16} : () -> i16
    %1 = "llvm.zext"(%arg0) : (i8) -> i16
    %2 = "llvm.add"(%1, %0) : (i16, i16) -> i16
    %3 = "llvm.and"(%2, %1) : (i16, i16) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_add", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i16} : () -> i16
    %1 = "llvm.zext"(%arg0) : (i8) -> i16
    %2 = "llvm.sub"(%0, %1) : (i16, i16) -> i16
    %3 = "llvm.and"(%2, %1) : (i16, i16) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sub", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i16} : () -> i16
    %1 = "llvm.zext"(%arg0) : (i8) -> i16
    %2 = "llvm.mul"(%1, %0) : (i16, i16) -> i16
    %3 = "llvm.and"(%2, %1) : (i16, i16) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_mul", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i16} : () -> i16
    %1 = "llvm.zext"(%arg0) : (i8) -> i16
    %2 = "llvm.lshr"(%1, %0) : (i16, i16) -> i16
    %3 = "llvm.and"(%2, %1) : (i16, i16) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_lshr", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i16} : () -> i16
    %1 = "llvm.zext"(%arg0) : (i8) -> i16
    %2 = "llvm.ashr"(%1, %0) : (i16, i16) -> i16
    %3 = "llvm.and"(%2, %1) : (i16, i16) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_ashr", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i16} : () -> i16
    %1 = "llvm.zext"(%arg0) : (i8) -> i16
    %2 = "llvm.shl"(%1, %0) : (i16, i16) -> i16
    %3 = "llvm.and"(%2, %1) : (i16, i16) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_shl", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[44, 42]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.add"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_add_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-5, -4]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.sub"(%0, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sub_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[3, -2]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.mul"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_mul_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[4, 2]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.lshr"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_lshr_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[2, 3]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.ashr"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_ashr_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[3, 2]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.shl"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_shl_vec", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[4, 8]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.lshr"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_lshr_vec_overshift", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.lshr"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_lshr_vec_undef", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[8, 2]> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.shl"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_shl_vec_overshift", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi16>
    %2 = "llvm.shl"(%1, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.and"(%2, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"(%3) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_shl_vec_undef", type = !llvm.func<vector<2xi16> (vector<2xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
