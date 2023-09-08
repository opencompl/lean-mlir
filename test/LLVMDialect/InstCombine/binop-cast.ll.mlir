"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.bitcast"(%0) : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "testAdd", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i1) -> i32
    %1 = "llvm.and"(%0, %arg0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_sext_to_sel", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[42, -7]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sext"(%arg0) : (vector<2xi1>) -> vector<2xi32>
    %2 = "llvm.and"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "and_sext_to_sel_constant_vec", type = !llvm.func<vector<2xi32> (vector<2xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi1>):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = "llvm.sext"(%arg1) : (vector<2xi1>) -> vector<2xi32>
    %2 = "llvm.and"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "and_sext_to_sel_swap", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i1) -> i32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %1 = "llvm.and"(%0, %arg0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_sext_to_sel_multi_use", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i1) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.and"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "and_sext_to_sel_multi_use_constant_mask", type = !llvm.func<i32 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i1) -> i32
    %1 = "llvm.or"(%0, %arg0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_sext_to_sel", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[42, -7]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sext"(%arg0) : (vector<2xi1>) -> vector<2xi32>
    %2 = "llvm.or"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "or_sext_to_sel_constant_vec", type = !llvm.func<vector<2xi32> (vector<2xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi1>):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = "llvm.sext"(%arg1) : (vector<2xi1>) -> vector<2xi32>
    %2 = "llvm.or"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "or_sext_to_sel_swap", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i1) -> i32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %1 = "llvm.or"(%0, %arg0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_sext_to_sel_multi_use", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i1) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.or"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_sext_to_sel_multi_use_constant_mask", type = !llvm.func<i32 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i1) -> i32
    %1 = "llvm.xor"(%0, %arg0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_sext_to_sel", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[42, -7]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.sext"(%arg0) : (vector<2xi1>) -> vector<2xi32>
    %2 = "llvm.xor"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_sext_to_sel_constant_vec", type = !llvm.func<vector<2xi32> (vector<2xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi1>):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = "llvm.sext"(%arg1) : (vector<2xi1>) -> vector<2xi32>
    %2 = "llvm.xor"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_sext_to_sel_swap", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i1) -> i32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %1 = "llvm.xor"(%0, %arg0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_sext_to_sel_multi_use", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i1) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.xor"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "xor_sext_to_sel_multi_use_constant_mask", type = !llvm.func<i32 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
