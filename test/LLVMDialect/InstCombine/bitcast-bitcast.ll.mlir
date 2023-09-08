"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i128):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (i128) -> f128
    %1 = "llvm.bitcast"(%0) : (f128) -> !llvm.ppc_fp128
    "llvm.return"(%1) : (!llvm.ppc_fp128) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_s_s_s", type = !llvm.func<ppc_fp128 (i128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (i64) -> f64
    %1 = "llvm.bitcast"(%0) : (f64) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_s_s_v", type = !llvm.func<vector<2xi32> (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (i64) -> vector<2xi32>
    %1 = "llvm.bitcast"(%0) : (vector<2xi32>) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_s_v_s", type = !llvm.func<f64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (i64) -> vector<4xi16>
    %1 = "llvm.bitcast"(%0) : (vector<4xi16>) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_s_v_v", type = !llvm.func<vector<2xi32> (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (vector<2xi32>) -> f64
    %1 = "llvm.bitcast"(%0) : (f64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_v_s_s", type = !llvm.func<i64 (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (vector<2xi32>) -> f64
    %1 = "llvm.bitcast"(%0) : (f64) -> vector<4xi16>
    "llvm.return"(%1) : (vector<4xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_v_s_v", type = !llvm.func<vector<4xi16> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (vector<2xf32>) -> vector<4xi16>
    %1 = "llvm.bitcast"(%0) : (vector<4xi16>) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_v_v_s", type = !llvm.func<f64 (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (vector<2xf32>) -> vector<4xi16>
    %1 = "llvm.bitcast"(%0) : (vector<4xi16>) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_bitcast_v_v_v", type = !llvm.func<vector<2xi32> (vector<2xf32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
