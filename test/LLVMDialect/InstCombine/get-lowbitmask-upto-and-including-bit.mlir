module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @t1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.shl %0, %arg0  : i16
    %3 = llvm.add %2, %1  : i16
    %4 = llvm.or %3, %2  : i16
    llvm.return %4 : i16
  }
  llvm.func @t2_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @t3_vec_poison0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %8, %arg0  : vector<3xi8>
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.or %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @t4_vec_poison1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %0, %arg0  : vector<3xi8>
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.or %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @t5_vec_poison2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(-1 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.shl %8, %arg0  : vector<3xi8>
    %18 = llvm.add %17, %16  : vector<3xi8>
    %19 = llvm.or %18, %17  : vector<3xi8>
    llvm.return %19 : vector<3xi8>
  }
  llvm.func @t6_extrause0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @t7_extrause1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @t8_extrause2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @t9_nocse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t10_nocse_extrause0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t11_nocse_extrause1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t12_nocse_extrause2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t13_nocse_extrause3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t14_nocse_extrause4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t15_nocse_extrause5(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t16_nocse_extrause6(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @t17_nocse_mismatching_x(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg1  : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }
}
