"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "reassoc_add_nuw", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.sub"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sub"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "reassoc_sub_nuw", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mul"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.mul"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "reassoc_mul_nuw", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "no_reassoc_add_nuw_none", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "no_reassoc_add_none_nuw", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%arg1, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "reassoc_x2_add_nuw", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mul"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.mul"(%arg1, %0) : (i32, i32) -> i32
    %4 = "llvm.mul"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "reassoc_x2_mul_nuw", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.sub"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sub"(%arg1, %0) : (i32, i32) -> i32
    %4 = "llvm.sub"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "reassoc_x2_sub_nuw", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mul"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.add"(%1, %arg0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_nuw_mul_nuw", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2147483647 : i32} : () -> i32
    %1 = "llvm.mul"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.add"(%1, %arg0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_nuw_mul_nuw_int_max", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mul"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.add"(%1, %arg0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_mul_nuw", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mul"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.add"(%1, %arg0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_nuw_mul", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.mul"(%arg0, %arg2) : (i32, i32) -> i32
    %2 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_nuw_mul_nuw_mul_nuw_var", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.mul"(%arg0, %arg2) : (i32, i32) -> i32
    %2 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_nuw_mul_mul_nuw_var", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.mul"(%arg0, %arg2) : (i32, i32) -> i32
    %2 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_nuw_mul_nuw_mul_var", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.mul"(%arg0, %arg2) : (i32, i32) -> i32
    %2 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tryFactorization_add_mul_nuw_mul_var", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
