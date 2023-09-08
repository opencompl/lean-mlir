"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_vec", type = !llvm.func<void (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nonzero", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nonzero2", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nonzero3", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nonzero4", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nonzero5", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nonzero6", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_not_in_range", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_in_range", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_range_sgt_constant", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_range_slt_constant", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_multi_range1", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_multi_range2", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.load"(%arg1) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_two_ranges", type = !llvm.func<i1 (ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.load"(%arg1) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_two_ranges2", type = !llvm.func<i1 (ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.load"(%arg1) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_two_ranges3", type = !llvm.func<i1 (ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ugt_zext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.mul"(%arg1, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = "llvm.zext"(%arg0) : (vector<2xi1>) -> vector<2xi8>
    %2 = "llvm.icmp"(%0, %1) {predicate = 6 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ult_zext", type = !llvm.func<vector<2xi1> (vector<2xi1>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "uge_zext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg1, %arg1) : (i8, i8) -> i8
    %1 = "llvm.zext"(%arg0) : (i1) -> i8
    %2 = "llvm.icmp"(%0, %1) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ule_zext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ugt_zext_use", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i2, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i2) -> i8
    %1 = "llvm.icmp"(%arg1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ult_zext_not_i1", type = !llvm.func<i1 (i2, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ult_zext", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg1, %arg1) : (i8, i8) -> i8
    %1 = "llvm.zext"(%arg0) : (i1) -> i16
    %2 = "llvm.zext"(%0) : (i8) -> i16
    %3 = "llvm.icmp"(%2, %1) {predicate = 6 : i64} : (i16, i16) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_ult_zext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i4):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    %1 = "llvm.zext"(%arg1) : (i4) -> i8
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%0, %1) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_ugt_zext", type = !llvm.func<i1 (i1, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i2, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i2) -> i8
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ult_zext_not_i1", type = !llvm.func<i1 (i2, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ult_zext_use1", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (vector<2xi1>) -> vector<2xi8>
    %1 = "llvm.sub"(%arg1, %arg2) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%1) {callee = @use_vec, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %2 = "llvm.icmp"(%0, %1) {predicate = 8 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_ugt_sub_use2", type = !llvm.func<vector<2xi1> (vector<2xi1>, vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ult_zext_use3", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i8
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ule_zext", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.and"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = "llvm.sub"(%arg1, %arg2) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = "llvm.icmp"(%2, %1) {predicate = 6 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ult_and", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.and"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%1, %2) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "and_ugt_sub", type = !llvm.func<i1 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "uge_sext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.mul"(%arg1, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = "llvm.sext"(%arg0) : (vector<2xi1>) -> vector<2xi8>
    %2 = "llvm.icmp"(%0, %1) {predicate = 7 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ule_sext", type = !llvm.func<vector<2xi1> (vector<2xi1>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ugt_sext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg1, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sext"(%arg0) : (i1) -> i8
    %2 = "llvm.icmp"(%0, %1) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ult_sext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "uge_sext_use", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i2, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i2) -> i8
    %1 = "llvm.icmp"(%arg1, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ule_sext_not_i1", type = !llvm.func<i1 (i2, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ule_sext", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg1, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sext"(%arg0) : (i1) -> i16
    %2 = "llvm.sext"(%0) : (i8) -> i16
    %3 = "llvm.icmp"(%2, %1) {predicate = 7 : i64} : (i16, i16) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_ule_sext", type = !llvm.func<i1 (i1, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i4):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    %1 = "llvm.sext"(%arg1) : (i4) -> i8
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%0, %1) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_uge_sext", type = !llvm.func<i1 (i1, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i2, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i2) -> i8
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ule_sext_not_i1", type = !llvm.func<i1 (i2, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ule_sext_use1", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (vector<2xi1>) -> vector<2xi8>
    %1 = "llvm.sub"(%arg1, %arg2) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%1) {callee = @use_vec, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %2 = "llvm.icmp"(%0, %1) {predicate = 9 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_uge_sub_use2", type = !llvm.func<vector<2xi1> (vector<2xi1>, vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ule_sext_use3", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i1) -> i8
    %1 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ult_sext", type = !llvm.func<i1 (i1, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<7> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.ashr"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = "llvm.sub"(%arg1, %arg2) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = "llvm.icmp"(%2, %1) {predicate = 7 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_ule_ashr", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.ashr"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.sub"(%arg1, %arg2) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%1, %2) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_uge_sub", type = !llvm.func<i1 (i8, i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
