module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @add_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.add %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @add_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.add %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @sub_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sub %8, %9 overflow<nsw, nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @sub_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @sub_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sub %9, %8 overflow<nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @sub_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sub %3, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @mul_constant(%arg0: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi8>
    %12 = llvm.mul %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @mul_constant_not_undef_lane(%arg0: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.constant(42 : i8) : i8
    %5 = llvm.mlir.undef : vector<3xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<3xi8>
    %12 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi8>
    %13 = llvm.mul %12, %11  : vector<3xi8>
    llvm.return %13 : vector<3xi8>
  }
  llvm.func @shl_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.shl %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @shl_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.shl %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.shl %9, %8 overflow<nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @shl_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.shl %3, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @ashr_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.ashr %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @ashr_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.ashr %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @ashr_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.ashr %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @ashr_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.ashr %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @lshr_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.lshr %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @lshr_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.lshr %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @lshr_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.lshr %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @lshr_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.lshr %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @urem_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.urem %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @urem_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @urem_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.urem %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @urem_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.urem %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @srem_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.srem %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @srem_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @srem_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.srem %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @srem_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.srem %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @udiv_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.udiv %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @udiv_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.udiv %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @udiv_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.udiv %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @udiv_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.udiv %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @sdiv_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sdiv %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @sdiv_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sdiv %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @sdiv_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sdiv %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @sdiv_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sdiv %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @and_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.and %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @and_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.and %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @or_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.or %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @or_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @xor_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.xor %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @xor_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.xor %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @fadd_constant(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fadd %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @fadd_constant_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fadd %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fsub_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fsub %8, %9  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @fsub_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fsub_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fsub %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @fsub_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fsub %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fmul_constant(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fmul %9, %8  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @fmul_constant_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fmul %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fdiv_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fdiv %8, %9  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @fdiv_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fdiv %2, %3  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fdiv_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fdiv %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @fdiv_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fdiv %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @frem_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.frem %8, %9  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @frem_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.frem %2, %3  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @frem_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.frem %9, %8  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @frem_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.frem %3, %2  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
}
