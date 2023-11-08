"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.zext"(%arg0) : (i8) -> i32
    %3 = "llvm.add"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.ashr"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i64, %arg2: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.sext"(%arg0) : (i1) -> i64
    "llvm.br"(%2)[^bb3] : (i64) -> ()
  ^bb2:  // pred: ^bb0
    %3 = "llvm.ashr"(%arg1, %1) : (i64, i64) -> i64
    "llvm.br"(%3)[^bb3] : (i64) -> ()
  ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.ashr"(%4, %0) : (i64, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i64 (i1, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i64, %arg2: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.sext"(%arg0) : (i1) -> i64
    "llvm.br"(%2)[^bb3] : (i64) -> ()
  ^bb2:  // pred: ^bb0
    %3 = "llvm.ashr"(%arg1, %1) : (i64, i64) -> i64
    "llvm.br"(%3)[^bb3] : (i64) -> ()
  ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.shl"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.ashr"(%5, %0) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i64 (i1, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.cond_br"(%arg1)[^bb1, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.cond_br"(%arg2, %1)[^bb2, ^bb4] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.br"(%1)[^bb4] : (i32) -> ()
  ^bb3:  // pred: ^bb0
    "llvm.cond_br"(%arg3, %arg0)[^bb4, ^bb5] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  ^bb5:  // pred: ^bb3
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i32 (i32, i1, i1, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ashr", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 17 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_overshift", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<7> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<5> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.ashr"(%2, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%3) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ashr_splat_vec", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<17> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<15> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.ashr"(%2, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%3) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_overshift_splat_vec", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.ashr"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "hoist_ashr_ahead_of_sext_1", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<3> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.ashr"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "hoist_ashr_ahead_of_sext_1_splat", type = !llvm.func<vector<2xi32> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.ashr"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "hoist_ashr_ahead_of_sext_2", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<8> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.ashr"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "hoist_ashr_ahead_of_sext_2_splat", type = !llvm.func<vector<2xi32> (vector<2xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
