module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.sub %1, %arg0  : i8
    %4 = llvm.xor %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @neg_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.udiv %arg0, %0  : vector<2xi8>
    %4 = llvm.sub %2, %arg0  : vector<2xi8>
    %5 = llvm.xor %4, %3  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @neg_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.udiv %arg0, %0  : vector<2xi8>
    %9 = llvm.sub %7, %arg0  : vector<2xi8>
    %10 = llvm.xor %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @not(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.xor %1, %arg0  : i8
    %4 = llvm.mul %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.udiv %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %1, %arg0  : vector<2xi8>
    %4 = llvm.mul %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @not_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.udiv %arg0, %0  : vector<2xi8>
    %9 = llvm.xor %7, %arg0  : vector<2xi8>
    %10 = llvm.mul %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @use(f32)
  llvm.func @use_vec(vector<2xf32>)
  llvm.func @fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %arg0, %0  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    %4 = llvm.fmul %3, %2  : f32
    llvm.call @use(%3) : (f32) -> ()
    llvm.return %4 : f32
  }
  llvm.func @unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fdiv %arg0, %0  : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.fmul %2, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }
  llvm.func @fneg_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fdiv %arg0, %0  : vector<2xf32>
    %3 = llvm.fsub %1, %arg0  : vector<2xf32>
    %4 = llvm.fmul %3, %2  : vector<2xf32>
    llvm.call @use_vec(%3) : (vector<2xf32>) -> ()
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fneg_vec_poison(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fdiv %arg0, %0  : vector<2xf32>
    %9 = llvm.fsub %7, %arg0  : vector<2xf32>
    %10 = llvm.fmul %9, %8  : vector<2xf32>
    llvm.call @use_vec(%9) : (vector<2xf32>) -> ()
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @unary_fneg_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    %2 = llvm.fneg %arg0  : vector<2xf32>
    %3 = llvm.fmul %2, %1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    llvm.return %3 : vector<2xf32>
  }
}
