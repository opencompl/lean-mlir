"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -2147483648 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-1> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<-2147483648> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.xor"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test0vec", type = !llvm.func<vector<2xi1> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 12345 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 153 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 145 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 153 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 177 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 145 : i32} : () -> i32
    %3 = "llvm.or"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.and"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1234 : i32} : () -> i32
    %3 = "llvm.xor"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.lshr"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.add"(%5, %3) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1234 : i32} : () -> i32
    %2 = "llvm.xor"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%1, %2) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %3 = "llvm.xor"(%1, %2) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test8", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.xor"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.xor"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test9b", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test10", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test10b", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.and"(%1, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.and"(%3, %1) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11b", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.and"(%1, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11c", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.and"(%3, %1) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11d", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mul"(%arg1, %arg2) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %arg0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.xor"(%1, %3) : (i32, i32) -> i32
    %5 = "llvm.and"(%2, %4) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11e", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mul"(%arg1, %arg2) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %arg0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.xor"(%1, %3) : (i32, i32) -> i32
    %5 = "llvm.and"(%4, %2) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11f", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg1, %0) : (i32, i32) -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.xor"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test12", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg1, %0) : (i32, i32) -> i32
    %2 = "llvm.and"(%1, %arg0) : (i32, i32) -> i32
    %3 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.xor"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test12commuted", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg1, %0) : (i32, i32) -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%1, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test13", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%arg1, %0) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %arg0) : (i32, i32) -> i32
    %4 = "llvm.xor"(%1, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test13commuted", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute1", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg2, %arg0) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute2", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute3", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg2, %arg0) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute4", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute5", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg2, %arg0) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute6", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute7", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.xor"(%arg2, %arg0) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_commute8", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    "llvm.store"(%0, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_extra_use1", type = !llvm.func<i32 (i32, i32, i32, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    "llvm.store"(%1, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_extra_use2", type = !llvm.func<i32 (i32, i32, i32, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg2) : (i32, i32) -> i32
    "llvm.store"(%0, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    %1 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    "llvm.store"(%1, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    %2 = "llvm.xor"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_or_xor_common_op_extra_use3", type = !llvm.func<i32 (i32, i32, i32, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 33 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %arg0) : (i8, i8) -> i8
    %2 = "llvm.xor"(%arg0, %0) : (i8, i8) -> i8
    %3 = "llvm.xor"(%2, %arg1) : (i8, i8) -> i8
    %4 = "llvm.and"(%1, %3) : (i8, i8) -> i8
    %5 = "llvm.mul"(%4, %3) : (i8, i8) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test15", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 33 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %arg0) : (i8, i8) -> i8
    %2 = "llvm.xor"(%arg0, %0) : (i8, i8) -> i8
    %3 = "llvm.xor"(%2, %arg1) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %1) : (i8, i8) -> i8
    %5 = "llvm.mul"(%4, %3) : (i8, i8) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test16", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
