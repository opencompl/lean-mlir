"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fmul"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fmul"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fmul", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fmul"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fmul"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fmul_fast", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fmul"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fmul"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fmul_reassoc_nsz", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fmul"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fmul"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fmul_reassoc", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadd", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadd_fast", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadd_reassoc_nsz", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%2, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadd_reassoc", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%arg1, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "llvm.fadd"(%2, %3) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%4) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadds_cancel_", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%arg1, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "llvm.fadd"(%2, %3) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%4) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadds_cancel_fast", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%arg1, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "llvm.fadd"(%2, %3) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%4) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadds_cancel_reassoc_nsz", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.fadd"(%arg0, %1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fadd"(%arg1, %0) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "llvm.fadd"(%2, %3) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%4) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_fadds_cancel_reassoc", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
