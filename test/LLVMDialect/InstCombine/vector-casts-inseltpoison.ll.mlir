module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @trunc(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @and_cmp_is_trunc(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @and_cmp_is_trunc_even_with_poison_elt(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %9 = llvm.and %arg0, %6  : vector<2xi64>
    %10 = llvm.icmp "ne" %9, %8 : vector<2xi64>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @and_cmp_is_trunc_even_with_poison_elts(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.and %arg0, %6  : vector<2xi64>
    %14 = llvm.icmp "ne" %13, %12 : vector<2xi64>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @test2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test3(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ord" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.and %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test4(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "uno" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.or %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test5(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.and %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test6(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.or %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test7(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.fcmp "ult" %arg1, %1 : vector<4xf32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    %6 = llvm.xor %3, %5  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @convert(%arg0: !llvm.ptr, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    llvm.return
  }
  llvm.func @foo(%arg0: vector<2xi64>) -> vector<2xi65> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.zext %0 : vector<2xi32> to vector<2xi65>
    llvm.return %1 : vector<2xi65>
  }
  llvm.func @bar(%arg0: vector<2xi65>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi65> to vector<2xi32>
    %1 = llvm.zext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @bars(%arg0: vector<2xi65>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi65> to vector<2xi32>
    %1 = llvm.sext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @quxs(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.sext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @quxt(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.ashr %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @fa(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf32>
    %1 = llvm.fpext %0 : vector<2xf32> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fb(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptoui %arg0 : vector<2xf64> to vector<2xi64>
    %1 = llvm.uitofp %0 : vector<2xi64> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fptosi %arg0 : vector<2xf64> to vector<2xi64>
    %1 = llvm.sitofp %0 : vector<2xi64> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @f(%arg0: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %7 = llvm.mlir.undef : vector<4xi32>
    %8 = llvm.mlir.undef : vector<4xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi32>
    %10 = llvm.insertelement %arg0, %9[%2 : i32] : vector<4xi32>
    %11 = llvm.insertelement %arg0, %10[%3 : i32] : vector<4xi32>
    %12 = llvm.insertelement %arg0, %11[%4 : i32] : vector<4xi32>
    %13 = llvm.getelementptr %5[%2] : (!llvm.ptr, i32) -> !llvm.ptr, vector<4xf32>
    %14 = llvm.ptrtoint %13 : !llvm.ptr to i64
    %15 = llvm.trunc %14 : i64 to i32
    %16 = llvm.insertelement %15, %0[%1 : i32] : vector<4xi32>
    %17 = llvm.insertelement %15, %16[%2 : i32] : vector<4xi32>
    %18 = llvm.insertelement %15, %17[%3 : i32] : vector<4xi32>
    %19 = llvm.insertelement %15, %18[%4 : i32] : vector<4xi32>
    %20 = llvm.mul %12, %19  : vector<4xi32>
    %21 = llvm.add %6, %20  : vector<4xi32>
    %22 = llvm.add %21, %7  : vector<4xi32>
    llvm.return %8 : vector<4xf32>
  }
  llvm.func @pr24458(%arg0: vector<8xf32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "une" %arg0, %1 : vector<8xf32>
    %3 = llvm.fcmp "ueq" %arg0, %1 : vector<8xf32>
    %4 = llvm.sext %2 : vector<8xi1> to vector<8xi32>
    %5 = llvm.sext %3 : vector<8xi1> to vector<8xi32>
    %6 = llvm.or %4, %5  : vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }
  llvm.func @trunc_inselt_undef(%arg0: i32) -> vector<3xi16> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi32>
    %3 = llvm.trunc %2 : vector<3xi32> to vector<3xi16>
    llvm.return %3 : vector<3xi16>
  }
  llvm.func @fptrunc_inselt_undef(%arg0: f64, %arg1: i32) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i32] : vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @trunc_inselt1(%arg0: i32) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[3, -2, 65536]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi32>
    %3 = llvm.trunc %2 : vector<3xi32> to vector<3xi16>
    llvm.return %3 : vector<3xi16>
  }
  llvm.func @fptrunc_inselt1(%arg0: f64, %arg1: i32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.undef : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.insertelement %arg0, %6[%arg1 : i32] : vector<2xf64>
    %8 = llvm.fptrunc %7 : vector<2xf64> to vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }
  llvm.func @trunc_inselt2(%arg0: vector<8xi32>, %arg1: i32) -> vector<8xi16> {
    %0 = llvm.mlir.constant(1048576 : i32) : i32
    %1 = llvm.insertelement %0, %arg0[%arg1 : i32] : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @fptrunc_inselt2(%arg0: vector<3xf64>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<3xf64>
    %3 = llvm.fptrunc %2 : vector<3xf64> to vector<3xf32>
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @sext_less_casting_with_wideop(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.mul %0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @zext_less_casting_with_wideop(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %1 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %2 = llvm.mul %0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
}
