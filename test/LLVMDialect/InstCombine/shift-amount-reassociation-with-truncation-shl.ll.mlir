module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @Y32(42 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global external @Y16(42 : i16) {addr_space = 0 : i32} : i16
  llvm.func @t0(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-24 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.shl %5, %6  : i16
    llvm.return %7 : i16
  }
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-24> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg1  : vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    %4 = llvm.shl %arg0, %3  : vector<2xi32>
    %5 = llvm.trunc %4 : vector<2xi32> to vector<2xi16>
    %6 = llvm.add %arg1, %1  : vector<2xi16>
    %7 = llvm.shl %5, %6  : vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[32, 30]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[-24, 0]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg1  : vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    %4 = llvm.shl %arg0, %3  : vector<2xi32>
    %5 = llvm.trunc %4 : vector<2xi32> to vector<2xi16>
    %6 = llvm.add %arg1, %1  : vector<2xi16>
    %7 = llvm.shl %5, %6  : vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @t3_vec_nonsplat_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<-24> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.sub %8, %arg1  : vector<3xi16>
    %11 = llvm.zext %10 : vector<3xi16> to vector<3xi32>
    %12 = llvm.shl %arg0, %11  : vector<3xi32>
    %13 = llvm.trunc %12 : vector<3xi32> to vector<3xi16>
    %14 = llvm.add %arg1, %9  : vector<3xi16>
    %15 = llvm.shl %13, %14  : vector<3xi16>
    llvm.return %15 : vector<3xi16>
  }
  llvm.func @t4_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(-24 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.sub %0, %arg1  : vector<3xi16>
    %11 = llvm.zext %10 : vector<3xi16> to vector<3xi32>
    %12 = llvm.shl %arg0, %11  : vector<3xi32>
    %13 = llvm.trunc %12 : vector<3xi32> to vector<3xi16>
    %14 = llvm.add %arg1, %9  : vector<3xi16>
    %15 = llvm.shl %13, %14  : vector<3xi16>
    llvm.return %15 : vector<3xi16>
  }
  llvm.func @t5_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(-24 : i16) : i16
    %10 = llvm.mlir.undef : vector<3xi16>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi16>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi16>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi16>
    %17 = llvm.sub %8, %arg1  : vector<3xi16>
    %18 = llvm.zext %17 : vector<3xi16> to vector<3xi32>
    %19 = llvm.shl %arg0, %18  : vector<3xi32>
    %20 = llvm.trunc %19 : vector<3xi32> to vector<3xi16>
    %21 = llvm.add %arg1, %16  : vector<3xi16>
    %22 = llvm.shl %20, %21  : vector<3xi16>
    llvm.return %22 : vector<3xi16>
  }
  llvm.func @use16(i16)
  llvm.func @use32(i32)
  llvm.func @t6_extrause0(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-24 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%5) : (i16) -> ()
    %7 = llvm.shl %5, %6  : i16
    llvm.return %7 : i16
  }
  llvm.func @t7_extrause1(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-24 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%6) : (i16) -> ()
    %7 = llvm.shl %5, %6  : i16
    llvm.return %7 : i16
  }
  llvm.func @t8_extrause2(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-24 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%5) : (i16) -> ()
    llvm.call @use16(%6) : (i16) -> ()
    %7 = llvm.shl %5, %6  : i16
    llvm.return %7 : i16
  }
  llvm.func @n11(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(30 : i16) : i16
    %1 = llvm.mlir.constant(-31 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.shl %5, %6  : i16
    llvm.return %7 : i16
  }
  llvm.func @t01(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @Y32 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.mlir.constant(42 : i16) : i16
    %4 = llvm.mlir.addressof @Y16 : !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i16
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.trunc %6 : i32 to i16
    %8 = llvm.shl %7, %5  : i16
    llvm.return %8 : i16
  }
  llvm.func @shl_tr_shl_constant_shift_amount_uses(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.shl %3, %1  : i16
    llvm.return %4 : i16
  }
  llvm.func @PR51657(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(64 : i64) : i64
    llvm.cond_br %arg1, ^bb1, ^bb2(%0, %1 : i32, i8)
  ^bb1:  // pred: ^bb0
    %3 = llvm.shl %arg0, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %3 : i64 to i8
    llvm.br ^bb2(%4, %5 : i32, i8)
  ^bb2(%6: i32, %7: i8):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.sext %7 : i8 to i32
    %9 = llvm.icmp "eq" %6, %8 : i32
    llvm.return %9 : i1
  }
  llvm.func @extra_use_on_first_shift(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    %4 = llvm.lshr %3, %1  : i16
    llvm.return %4 : i16
  }
}
