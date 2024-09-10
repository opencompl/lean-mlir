module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @zext(%arg0: i32, %arg1: i32, %arg2: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.select %1, %0, %arg2 : i1, i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @zext_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @sext(%arg0: i8, %arg1: i8, %arg2: i8) -> i64 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.select %1, %0, %arg2 : i1, i8
    %3 = llvm.sext %2 : i8 to i64
    llvm.return %3 : i64
  }
  llvm.func @sext_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi8> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @trunc(%arg0: i32, %arg1: i32, %arg2: i32) -> i16 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.select %1, %0, %arg2 : i1, i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_vec(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi64>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi64>
    %3 = llvm.trunc %2 : vector<2xi64> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @fpext(%arg0: f32, %arg1: f32, %arg2: f32) -> f64 {
    %0 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    %2 = llvm.select %1, %0, %arg2 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : vector<2xf32>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fpext %2 : vector<2xf32> to vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @fptrunc(%arg0: f64, %arg1: f64, %arg2: f64) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.select %1, %0, %arg2 : i1, f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @fptrunc_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[-4.200000e+01, 1.200000e+01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "oge" %arg0, %arg1 : vector<2xf64>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
}
