module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @vec_use(vector<4xi32>)
  llvm.func @add_const_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_const_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_add_const_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_add_const_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_add_const_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %arg0, %11  : vector<4xi32>
    %24 = llvm.add %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @add_const_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_const_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_add_const_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_add_const_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_add_const_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @add_const_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_nsw_const_const_sub_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_nsw_const_const_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_const_const_sub_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_nsw_const_const_sub_nsw_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_nuw_const_const_sub_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.sub %1, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_nuw_const_const_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_const_const_sub_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-125, -126]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-125, -126]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-120, -126]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @non_splat_vec_add_nsw_const_const_sub_nsw_ov(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-126, -127]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @add_const_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_add_const_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_add_const_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_add_const_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @sub_const_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_const_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_sub_const_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_sub_const_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_sub_const_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %arg0, %11  : vector<4xi32>
    %24 = llvm.add %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @sub_const_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_const_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_sub_const_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_sub_const_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_sub_const_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @sub_const_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_const_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_sub_const_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_sub_const_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_sub_const_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %arg0, %11  : vector<4xi32>
    %24 = llvm.sub %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @const_sub_add_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @const_sub_add_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_const_sub_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_const_sub_add_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_const_sub_add_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %11, %arg0  : vector<4xi32>
    %24 = llvm.add %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @const_sub_sub_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @const_sub_sub_const_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_const_sub_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_const_sub_sub_const_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_const_sub_sub_const_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %11, %arg0  : vector<4xi32>
    %24 = llvm.sub %23, %22  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @const_sub_const_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @const_sub_const_sub_extrause(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @vec_const_sub_const_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_const_sub_const_sub_extrause(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @vec_const_sub_const_sub_nonsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %12, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %11, %arg0  : vector<4xi32>
    %24 = llvm.sub %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @addsub_combine_constants(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(42 : i7) : i7
    %1 = llvm.mlir.constant(10 : i7) : i7
    %2 = llvm.add %arg0, %0  : i7
    %3 = llvm.sub %1, %arg1  : i7
    %4 = llvm.add %2, %3 overflow<nsw>  : i7
    llvm.return %4 : i7
  }
  llvm.func @addsub_combine_constants_use1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[-100, 1, -1, 42]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.call @vec_use(%2) : (vector<4xi32>) -> ()
    %3 = llvm.sub %1, %arg1  : vector<4xi32>
    %4 = llvm.add %3, %2 overflow<nuw>  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @addsub_combine_constants_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @addsub_combine_constants_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @sub_from_constant(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.sub %0, %arg0  : i5
    %2 = llvm.add %1, %arg1  : i5
    llvm.return %2 : i5
  }
  llvm.func @sub_from_constant_commute(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.mul %arg1, %arg1  : i5
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i5
    %3 = llvm.add %1, %2 overflow<nsw>  : i5
    llvm.return %3 : i5
  }
  llvm.func @sub_from_constant_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi8>
    %2 = llvm.add %1, %arg1 overflow<nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @sub_from_constant_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call %1(%2) : !llvm.ptr, (i8) -> ()
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }
}
