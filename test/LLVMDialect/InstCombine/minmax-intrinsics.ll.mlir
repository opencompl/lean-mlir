module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : i32
  llvm.func @use(i8)
  llvm.func @use_vec(vector<3xi8>)
  llvm.func @umin_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.umin(%2, %arg1)  : (i8, i8) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @umax_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.intr.umax(%1, %arg1)  : (i8, i8) -> i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @smin_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.intr.smin(%1, %arg1)  : (i8, i8) -> i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @smax_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %arg1)  : (i8, i8) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @smax_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.sext %arg1 : i5 to i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.sext %arg1 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_sext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i5 to i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_sext(%arg0: vector<3xi5>, %arg1: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.sext %arg0 : vector<3xi5> to vector<3xi8>
    %1 = llvm.sext %arg1 : vector<3xi5> to vector<3xi8>
    %2 = llvm.intr.umin(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @smax_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_zext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_zext_types(%arg0: i6, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i6 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_ext(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.zext %arg1 : i5 to i8
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_zext_uses(%arg0: i5, %arg1: i5) -> i8 {
    %0 = llvm.zext %arg0 : i5 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.zext %arg1 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin_sext_constant(%arg0: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[7, 15, -16]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.sext %arg0 : vector<3xi5> to vector<3xi8>
    %2 = llvm.intr.smin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @smin_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_zext_constant(%arg0: vector<3xi5>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[7, 15, 31]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.zext %arg0 : vector<3xi5> to vector<3xi8>
    %2 = llvm.intr.umax(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @umax_zext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_sext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_sext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_zext_constant(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_zext_constant_big(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_zext_constant_uses(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.zext %arg0 : i5 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_of_nots(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.undef : vector<3xi8>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<3xi8>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : vector<3xi8>
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi8>
    %16 = llvm.xor %arg0, %8  : vector<3xi8>
    %17 = llvm.xor %arg1, %15  : vector<3xi8>
    %18 = llvm.intr.smin(%16, %17)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }
  llvm.func @umax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_of_nots_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_of_not_and_const(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(43 : i8) : i8
    %10 = llvm.mlir.constant(42 : i8) : i8
    %11 = llvm.mlir.undef : vector<3xi8>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi8>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : vector<3xi8>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %9, %15[%16 : i32] : vector<3xi8>
    %18 = llvm.xor %arg0, %8  : vector<3xi8>
    %19 = llvm.intr.smin(%17, %18)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %19 : vector<3xi8>
  }
  llvm.func @umax_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_of_not_and_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_of_not_and_smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smax(%2, %3)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %1)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }
  llvm.func @smin_of_umax_and_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%2, %3)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%1, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }
  llvm.func @umin_of_not_and_nontrivial_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.addressof @umin_of_not_and_nontrivial_const : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.intr.umin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @umin_of_not_and_const_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @not_smax_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_smin_of_nots(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_umax_of_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umax(%1, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_umin_of_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_umin_of_not_constant_op(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }
  llvm.func @smax_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_negation_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_negation_not_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_negation_vec(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.sub %8, %arg0  : vector<3xi8>
    %10 = llvm.intr.smax(%arg0, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }
  llvm.func @smin_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.intr.smin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_negation(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.umin(%1, %arg0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_negation_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @clamp_two_vals_smax_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_smin_smax(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<41> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.smin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.intr.smax(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @clamp_two_vals_umax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_umin_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(41 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_smax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_three_vals_smax_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_umax_umin_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_umin_umax_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_smax_smin_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @clamp_two_vals_smin_smax_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_non_zero_idiom1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }
  llvm.func @umin_non_zero_idiom2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umin(%0, %arg0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }
  llvm.func @umin_non_zero_idiom3(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %1 : vector<3xi8>
  }
  llvm.func @umin_non_zero_idiom4(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.intr.umin(%arg0, %8)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %9 : vector<3xi8>
  }
  llvm.func @umin_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @umin_eq_zero2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }
  llvm.func @umin_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @umin_ne_zero2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }
  llvm.func @smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg2)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin(%arg0: vector<3xi8>, %arg1: vector<3xi8>, %arg2: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %arg2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @umax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.umax(%arg2, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.intr.umin(%arg2, %arg0)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg2)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_no_common_op(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg3, %arg2)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_demand_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @umax_demand_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.intr.umax(%0, %arg0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @umin_demand_or_31_30(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.intr.umin(%0, %arg0)  : (i8, i8) -> i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @umin_demand_and_7_8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_nsw_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_nsw_smin(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.sub %1, %arg1 overflow<nsw>  : vector<3xi8>
    %4 = llvm.intr.smin(%2, %3)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }
  llvm.func @neg_neg_nsw_smax_use0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_nsw_smin_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_nsw_smin_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @neg_neg_nsw_umin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @freeToInvertSub(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.sub %3, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @freeToInvertSub_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.sub %3, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @freeToInvert(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @freeToInvert_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @freeToInvert_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @freeToInvert_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @freeToInvert_two_minmax_ops(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @freeToInvert_two_minmax_ops_use1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @freeToInvert_two_minmax_ops_use2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @freeToInvert_two_minmax_ops_use3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.call @use(%2) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.intr.smax(%4, %3)  : (i8, i8) -> i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.intr.smin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @sub_not_min_max(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @sub_not_min_max_uses1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @sub_not_min_max_uses2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @use4(i8, i8, i8, i8)
  llvm.func @cmyk(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute1(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute3(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %2, %5  : i8
    %8 = llvm.sub %3, %5  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute4(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %3, %5  : i8
    %7 = llvm.sub %1, %5  : i8
    %8 = llvm.sub %2, %5  : i8
    llvm.call @use4(%7, %8, %6, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute5(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %3, %5  : i8
    %8 = llvm.sub %2, %5  : i8
    llvm.call @use4(%6, %8, %7, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute6(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute7(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute8(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%3, %4)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute9(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %5, %1  : i8
    %7 = llvm.sub %5, %2  : i8
    %8 = llvm.sub %5, %3  : i8
    llvm.call @use4(%6, %7, %8, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute10(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %3, %5  : i8
    %7 = llvm.sub %5, %1  : i8
    %8 = llvm.sub %2, %5  : i8
    llvm.call @use4(%7, %8, %6, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk_commute11(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    %5 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.sub %5, %3  : i8
    %8 = llvm.sub %5, %2  : i8
    llvm.call @use4(%6, %8, %7, %5) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @smax_offset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_offset(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<124> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-3> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<3xi8>
    %3 = llvm.intr.smin(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @smin_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(125 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umax_offset(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-126> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<3xi8>
    %3 = llvm.intr.umax(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @umax_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umax_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umax_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_offset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_offset_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_offset_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_offset_may_wrap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umin_offset_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umax_vector_splat_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<[13, -126, -126]> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.add %arg0, %8 overflow<nuw>  : vector<3xi8>
    %11 = llvm.intr.umax(%10, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @smax_offset_simplify(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(50 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_smax_reassoc_constants(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[42, 43, 44]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %3 = llvm.intr.smax(%2, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @smin_smin_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(97 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @umax_umax_reassoc_constants(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[42, 43, 44]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(-113 : i8) : i8
    %3 = llvm.mlir.constant(43 : i8) : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.intr.umax(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %12 = llvm.intr.umax(%11, %10)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @umin_umin_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-116 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.intr.umin(%0, %arg0)  : (i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smin_smax_reassoc_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(97 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @smax_smax_reassoc_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin_smin_reassoc_constant(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @umax_umax_reassoc_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_umin_reassoc_constant(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.umin(%1, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @umin_umin_reassoc_constant_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_smax_reassoc_constant_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin_smin_reassoc_constant_sink(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.smin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.smin(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @umax_umax_reassoc_constant_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umin_umin_reassoc_constant_sink(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[43, -43, 0]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.intr.umin(%arg0, %0)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    %2 = llvm.intr.umin(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @umin_umin_reassoc_constant_sink_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%1, %arg1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_smax_smax_reassoc_constants(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%arg1, %2)  : (i8, i8) -> i8
    %4 = llvm.intr.smax(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @smax_smax_smax_reassoc_constants_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smax(%2, %arg1)  : (i8, i8) -> i8
    %4 = llvm.intr.smax(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @smin_smin_smin_reassoc_constants(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.smin(%arg1, %2)  : (i8, i8) -> i8
    %4 = llvm.intr.smin(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @umax_umax_reassoc_constantexpr_sink(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.addressof @umax_umax_reassoc_constantexpr_sink : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %4 = llvm.intr.umax(%3, %2)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @smax_unary_shuffle_ops(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 2] : vector<3xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @smin_unary_shuffle_ops_use_poison_mask_elt(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [-1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [-1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @umax_unary_shuffle_ops_use_widening(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 0] : vector<2xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 0] : vector<2xi8> 
    llvm.call @use_vec(%2) : (vector<3xi8>) -> ()
    %3 = llvm.intr.umax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @umin_unary_shuffle_ops_narrowing(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 3] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 3] : vector<4xi8> 
    %3 = llvm.intr.umin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @smax_unary_shuffle_ops_unshuffled_op(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 2] : vector<3xi8> 
    %2 = llvm.intr.smax(%1, %arg1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @smax_unary_shuffle_ops_wrong_mask(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0, 2] : vector<3xi8> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    %3 = llvm.intr.smax(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @smax_unary_shuffle_ops_wrong_shuf(%arg0: vector<3xi8>, %arg1: vector<3xi8>, %arg2: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.shufflevector %arg0, %arg2 [1, 0, 3] : vector<3xi8> 
    %1 = llvm.shufflevector %arg1, %arg2 [1, 0, 3] : vector<3xi8> 
    %2 = llvm.intr.smax(%0, %1)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %2 : vector<3xi8>
  }
  llvm.func @smin_unary_shuffle_ops_uses(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%1) : (vector<3xi8>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 2] : vector<3xi8> 
    llvm.call @use_vec(%2) : (vector<3xi8>) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @PR57986() -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.umin(%1, %2)  : (i1, i1) -> i1
    llvm.return %3 : i1
  }
  llvm.func @fold_umax_with_knownbits_info(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.intr.umax(%3, %0)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @fold_umax_with_knownbits_info_poison_in_splat(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.or %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %arg1, %0  : vector<3xi8>
    %12 = llvm.sub %10, %11  : vector<3xi8>
    %13 = llvm.intr.umax(%12, %9)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %13 : vector<3xi8>
  }
  llvm.func @fold_umin_with_knownbits_info(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.intr.umin(%4, %0)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }
  llvm.func @fold_umin_with_knownbits_info_poison_in_splat(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.or %arg0, %0  : vector<3xi8>
    %12 = llvm.shl %arg1, %1  : vector<3xi8>
    %13 = llvm.sub %11, %12  : vector<3xi8>
    %14 = llvm.intr.umin(%13, %10)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %14 : vector<3xi8>
  }
  llvm.func @fold_umax_with_knownbits_info_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.intr.umax(%4, %1)  : (i8, i8) -> i8
    llvm.return %5 : i8
  }
  llvm.func @fold_umin_with_knownbits_info_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.sub %3, %4  : i8
    %6 = llvm.intr.umin(%5, %2)  : (i8, i8) -> i8
    llvm.return %6 : i8
  }
  llvm.func @test_umax_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @test_umin_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @test_smax_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @test_smin_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @test_smin_and_mismatch(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.smin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @test_smin_and_non_negated_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @test_smin_and_multiuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
}
