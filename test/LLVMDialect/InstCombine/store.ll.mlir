"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "Unknown", type = i32} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_of_undef", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_of_poison", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    "llvm.store"(%1, %0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_into_undef", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 124 : i32} : () -> i32
    "llvm.store"(%1, %0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_into_null", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.add"(%1, %0) : (i32, i32) -> i32
    "llvm.store"(%2, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    %2 = "llvm.getelementptr"(%1, %arg0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_at_gep_off_null_inbounds", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    %2 = "llvm.getelementptr"(%1, %arg0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_at_gep_off_null_not_inbounds", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    %2 = "llvm.getelementptr"(%1, %arg0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_at_gep_off_no_null_opt", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 47 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -987654321 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%1, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.store"(%0, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %4 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i32 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -987654321 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 47 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%1, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%0, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i32 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -987654321 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 47 : i32} : () -> i32
    "llvm.store"(%1, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%0, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<void (i1, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    "llvm.store"(%3, %arg2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%2)[^bb1] : (i32) -> ()
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = "llvm.load"(%arg2) : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.icmp"(%5, %arg0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%6)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %7 = "llvm.sext"(%5) : (i32) -> i64
    %8 = "llvm.getelementptr"(%arg1, %7) : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    "llvm.store"(%1, %8) : (f32, !llvm.ptr<f32>) -> ()
    %9 = "llvm.load"(%arg2) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.add"(%9, %0) : (i32, i32) -> i32
    "llvm.store"(%10, %arg2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%10)[^bb1] : (i32) -> ()
  ^bb3:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<void (i32, ptr<f32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "dse1", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "dse2", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "dse3", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "dse4", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "dse5", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back1", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back2", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back3", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back4", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back5", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back6", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "write_back7", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @Unknown} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%1, %0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "store_to_constant", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
