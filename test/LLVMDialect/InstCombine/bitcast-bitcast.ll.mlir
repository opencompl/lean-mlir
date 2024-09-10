module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bitcast_bitcast_s_s_s(%arg0: i128) -> !llvm.ppc_fp128 {
    %0 = llvm.bitcast %arg0 : i128 to f128
    %1 = llvm.bitcast %0 : f128 to !llvm.ppc_fp128
    llvm.return %1 : !llvm.ppc_fp128
  }
  llvm.func @bitcast_bitcast_s_s_v(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : i64 to f64
    %1 = llvm.bitcast %0 : f64 to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @bitcast_bitcast_s_v_s(%arg0: i64) -> f64 {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %1 = llvm.bitcast %0 : vector<2xi32> to f64
    llvm.return %1 : f64
  }
  llvm.func @bitcast_bitcast_s_v_v(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %1 = llvm.bitcast %0 : vector<4xi16> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @bitcast_bitcast_v_s_s(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to f64
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }
  llvm.func @bitcast_bitcast_v_s_v(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to f64
    %1 = llvm.bitcast %0 : f64 to vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @bitcast_bitcast_v_v_s(%arg0: vector<2xf32>) -> f64 {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to vector<4xi16>
    %1 = llvm.bitcast %0 : vector<4xi16> to f64
    llvm.return %1 : f64
  }
  llvm.func @bitcast_bitcast_v_v_v(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to vector<4xi16>
    %1 = llvm.bitcast %0 : vector<4xi16> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
}
