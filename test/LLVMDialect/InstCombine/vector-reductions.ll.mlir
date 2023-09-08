"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_f32", type = !llvm.func<void (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.reduce.add.v4i32", type = !llvm.func<i32 (vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.reduce.add.v8i32", type = !llvm.func<i32 (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_i32", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %1 = "llvm.call"(%arg2, %arg3) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_v4f32", type = !llvm.func<f32 (f32, vector<4xf32>, f32, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %1 = "llvm.call"(%arg2, %arg3) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_v4f32_fmf", type = !llvm.func<f32 (f32, vector<4xf32>, f32, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    "llvm.call"(%0) {callee = @use_f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    %1 = "llvm.call"(%arg2, %arg3) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_extra_use1", type = !llvm.func<f32 (f32, vector<4xf32>, f32, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %1 = "llvm.call"(%arg2, %arg3) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    "llvm.call"(%1) {callee = @use_f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_extra_use2", type = !llvm.func<f32 (f32, vector<4xf32>, f32, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<8xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.vector.reduce.fadd.v4f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<4xf32>) -> f32
    %1 = "llvm.call"(%arg2, %arg3) {callee = @llvm.vector.reduce.fadd.v8f32, fastmathFlags = #llvm.fastmath<>} : (f32, vector<8xf32>) -> f32
    %2 = "llvm.fsub"(%0, %1) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_type_mismatch", type = !llvm.func<f32 (f32, vector<4xf32>, f32, vector<8xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    %1 = "llvm.call"(%arg1) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_v4i32", type = !llvm.func<i32 (vector<4xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    "llvm.call"(%0) {callee = @use_i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %1 = "llvm.call"(%arg1) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_v4i32_extra_use1", type = !llvm.func<i32 (vector<4xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    %1 = "llvm.call"(%arg1) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    "llvm.call"(%1) {callee = @use_i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_v4i32_extra_use2", type = !llvm.func<i32 (vector<4xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.vector.reduce.add.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>) -> i32
    %1 = "llvm.call"(%arg1) {callee = @llvm.vector.reduce.add.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<4xi32>) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "diff_of_sums_type_mismatch2", type = !llvm.func<i32 (vector<8xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.reduce.fadd.v4f32", type = !llvm.func<f32 (f32, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.reduce.fadd.v8f32", type = !llvm.func<f32 (f32, vector<8xf32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
