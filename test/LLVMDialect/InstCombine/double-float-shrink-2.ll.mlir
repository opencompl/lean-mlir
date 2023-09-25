"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "floor", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "ceil", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "round", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "roundeven", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "nearbyint", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "trunc", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fabs", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ceil.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ceil.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fabs.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fabs.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.floor.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.floor.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.nearbyint.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.nearbyint.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.rint.f32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.rint.v2f32", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.round.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.round.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.roundeven.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.roundeven.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.trunc.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.trunc.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @floor, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_floor", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @ceil, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_ceil", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @round, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_round", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @roundeven, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_roundeven", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @nearbyint, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_nearbyint", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @trunc, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_trunc", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @fabs, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_fabs", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @fabs, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_libcall_fabs_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_ceil", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.floor.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_floor", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.nearbyint.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_nearbyint", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f16) -> f32
    %1 = "llvm.call"(%0) {callee = @llvm.rint.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %2 = "llvm.fptrunc"(%1) : (f32) -> f16
    "llvm.return"(%2) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_rint", type = !llvm.func<f16 (f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.round.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_round", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.roundeven.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_roundeven", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.trunc.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_trunc", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_v2f64", type = !llvm.func<void (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_v2f32", type = !llvm.func<void (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%0) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_ceil_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%1) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.floor.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%0) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.call"(%1) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_floor_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.nearbyint.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%0) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_nearbyint_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf16>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf32>
    %1 = "llvm.call"(%0) {callee = @llvm.rint.v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf32>) -> vector<2xf16>
    "llvm.call"(%1) {callee = @use_v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>) -> ()
    "llvm.return"(%2) : (vector<2xf16>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_rint_multi_use", type = !llvm.func<vector<2xf16> (vector<2xf16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.round.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%0) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.call"(%1) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_round_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.roundeven.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%0) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.call"(%1) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_roundeven_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf32>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.trunc.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    %2 = "llvm.fptrunc"(%1) : (vector<2xf64>) -> vector<2xf32>
    "llvm.call"(%0) {callee = @use_v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> ()
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_trunc_multi_use", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.floor.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_floor", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_ceil", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.round.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_round", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.roundeven.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_roundeven", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.nearbyint.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_nearbyint", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.trunc.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_trunc", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs_double_src", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs_fast_double_src", type = !llvm.func<f32 (f64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.floor.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_floor", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_ceil", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.round.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_round", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.roundeven.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_roundeven", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.nearbyint.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_nearbyint", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.trunc.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_trunc", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_fabs", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.100000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_float_convertible_constant_intrin_fabs_fast", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.floor.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_mismatched_type_intrin_floor", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_mismatched_type_intrin_ceil", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.round.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_mismatched_type_intrin_round", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.roundeven.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_mismatched_type_intrin_roundeven", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.nearbyint.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_mismatched_type_intrin_nearbyint", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.trunc.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_mismatched_type_intrin_trunc", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_mismatched_type_intrin_fabs_double_src", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fptrunc"(%0) : (f64) -> f16
    "llvm.return"(%1) : (f16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_mismatched_type_intrin_fabs_fast_double_src", type = !llvm.func<f16 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf16>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.floor.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_floor_fp16_vec", type = !llvm.func<vector<2xf64> (vector<2xf16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f16) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_ceil_fp16_src", type = !llvm.func<f32 (f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf16>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.round.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_round_fp16_vec", type = !llvm.func<vector<2xf64> (vector<2xf16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf16>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.roundeven.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_roundeven_fp16_vec", type = !llvm.func<vector<2xf64> (vector<2xf16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f16) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.nearbyint.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_nearbyint_fp16_src", type = !llvm.func<f32 (f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf16>):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.trunc.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_trunc_fp16_src", type = !llvm.func<vector<2xf64> (vector<2xf16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f16) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs_fp16_src", type = !llvm.func<f32 (f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f16) -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fptrunc"(%1) : (f64) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shrink_intrin_fabs_fast_fp16_src", type = !llvm.func<f32 (f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<f64>
    %1 = "llvm.fpext"(%arg0) : (f16) -> f64
    "llvm.store"(%1, %0) : (f64, !llvm.ptr<f64>) -> ()
    %2 = "llvm.call"(%1) {callee = @llvm.floor.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_floor_multi_use_fpext", type = !llvm.func<f32 (f16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f16):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<f64>
    %1 = "llvm.fpext"(%arg0) : (f16) -> f64
    "llvm.store"(%1, %0) : (f64, !llvm.ptr<f64>) -> ()
    %2 = "llvm.call"(%1) {callee = @llvm.fabs.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_shrink_intrin_fabs_multi_use_fpext", type = !llvm.func<f32 (f16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
