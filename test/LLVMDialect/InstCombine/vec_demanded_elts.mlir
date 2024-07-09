module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global internal @GLOBAL(0 : i32) {addr_space = 0 : i32, dso_local} : i32
  llvm.mlir.global external @global() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.array<0 x i32>
  llvm.func @use(vector<2xi4>)
  llvm.func @use_fp(vector<2xf32>)
  llvm.func @test2(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.fmul %arg0, %arg0  : f32
    %7 = llvm.insertelement %6, %0[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %2, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %2, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.insertelement %2, %9[%5 : i32] : vector<4xf32>
    %11 = llvm.bitcast %10 : vector<4xf32> to vector<4xi32>
    %12 = llvm.extractelement %11[%1 : i32] : vector<4xi32>
    llvm.return %12 : i32
  }
  llvm.func @get_image() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<100xi8>) : vector<100xi8>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(80 : i8) : i8
    %6 = llvm.call @fgetc(%0) : (!llvm.ptr) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.insertelement %7, %2[%3 : i32] : vector<100xi8>
    %9 = llvm.extractelement %8[%4 : i32] : vector<100xi8>
    %10 = llvm.icmp "eq" %9, %5 : i8
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.unreachable
  }
  llvm.func @vac(%arg0: !llvm.ptr {llvm.nocapture}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    %6 = llvm.insertelement %0, %5[%1 : i32] : vector<4xf32>
    %7 = llvm.insertelement %0, %6[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %0, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %0, %8[%4 : i32] : vector<4xf32>
    llvm.store %9, %arg0 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @fgetc(!llvm.ptr) -> i32
  llvm.func @dead_shuffle_elt(%arg0: vector<4xf32>, %arg1: vector<2xf32>) -> vector<4xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.shufflevector %arg1, %arg1 [0, 1, 0, 1] : vector<2xf32> 
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 2, 3] : vector<4xf32> 
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @test_fptrunc(%arg0: f64) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<4xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xf32>
    %7 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf64>
    %8 = llvm.insertelement %2, %7[%3 : i32] : vector<4xf64>
    %9 = llvm.insertelement %2, %8[%4 : i32] : vector<4xf64>
    %10 = llvm.insertelement %2, %9[%5 : i32] : vector<4xf64>
    %11 = llvm.fptrunc %10 : vector<4xf64> to vector<4xf32>
    %12 = llvm.shufflevector %11, %6 [0, 1] : vector<4xf32> 
    llvm.return %12 : vector<2xf32>
  }
  llvm.func @test_fpext(%arg0: f32) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xf64>
    %7 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %2, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %2, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.insertelement %2, %9[%5 : i32] : vector<4xf32>
    %11 = llvm.fpext %10 : vector<4xf32> to vector<4xf64>
    %12 = llvm.shufflevector %11, %6 [0, 1] : vector<4xf64> 
    llvm.return %12 : vector<2xf64>
  }
  llvm.func @test_shuffle(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<4xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.shufflevector %arg0, %10 [0, 1, 2, 5] : vector<4xf64> 
    llvm.return %11 : vector<4xf64>
  }
  llvm.func @test_select(%arg0: f32, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %7 = llvm.mlir.constant(3 : i32) : i32
    %8 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %9 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %11 = llvm.mlir.constant(true) : i1
    %12 = llvm.mlir.constant(false) : i1
    %13 = llvm.mlir.constant(dense<[true, false, false, true]> : vector<4xi1>) : vector<4xi1>
    %14 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %15 = llvm.insertelement %2, %14[%3 : i32] : vector<4xf32>
    %16 = llvm.insertelement %4, %15[%5 : i32] : vector<4xf32>
    %17 = llvm.insertelement %6, %16[%7 : i32] : vector<4xf32>
    %18 = llvm.insertelement %arg1, %0[%1 : i32] : vector<4xf32>
    %19 = llvm.insertelement %8, %18[%3 : i32] : vector<4xf32>
    %20 = llvm.insertelement %9, %19[%5 : i32] : vector<4xf32>
    %21 = llvm.insertelement %10, %20[%7 : i32] : vector<4xf32>
    %22 = llvm.select %13, %17, %21 : vector<4xi1>, vector<4xf32>
    llvm.return %22 : vector<4xf32>
  }
  llvm.func @PR24922(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.addressof @PR24922 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %10 = llvm.select %7, %arg0, %9 : vector<2xi1>, vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }
  llvm.func @inselt_shuf_no_demand(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg1, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg2, %5[%3 : i32] : vector<4xf32>
    %7 = llvm.shufflevector %6, %0 [0, -1, -1, -1] : vector<4xf32> 
    llvm.return %7 : vector<4xf32>
  }
  llvm.func @inselt_shuf_no_demand_commute(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg1, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg2, %5[%3 : i32] : vector<4xf32>
    %7 = llvm.shufflevector %0, %6 [4, -1, -1, -1] : vector<4xf32> 
    llvm.return %7 : vector<4xf32>
  }
  llvm.func @inselt_shuf_no_demand_multiuse(%arg0: i32, %arg1: i32, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xi32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xi32>
    %8 = llvm.add %7, %arg2  : vector<4xi32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xi32>
    %10 = llvm.shufflevector %9, %0 [0, 1, -1, -1] : vector<4xi32> 
    llvm.return %10 : vector<4xi32>
  }
  llvm.func @inselt_shuf_no_demand_bogus_insert_index_in_chain(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %4 = llvm.insertelement %arg1, %3[%arg3 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg2, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.shufflevector %5, %0 [0, -1, -1, -1] : vector<4xf32> 
    llvm.return %6 : vector<4xf32>
  }
  llvm.func @shuf_add(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_sub(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_mul(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, 2, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_and(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.and %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, 1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_or(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.or %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_xor(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.xor %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_lshr_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.lshr %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_lshr_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.lshr %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_ashr_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.ashr %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_ashr_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.ashr %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_shl_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_shl_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_sdiv_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_sdiv_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_srem_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.srem %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_srem_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.srem %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_udiv_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.udiv %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_udiv_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.udiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_urem_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.urem %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_urem_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.urem %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shuf_fadd(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fadd %arg0, %0  : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @shuf_fsub(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 0, 2] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @shuf_fmul(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @shuf_fdiv_const_op0(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 0, 2] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @shuf_fdiv_const_op1(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @shuf_frem_const_op0(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.frem %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 2, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @shuf_frem_const_op1(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.frem %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }
  llvm.func @gep_vbase_w_s_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %2 = llvm.extractelement %1[%0 : i32] : !llvm.vec<2 x ptr>
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @gep_splat_base_w_s_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.shufflevector %4, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %6 = llvm.getelementptr %5[%2] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %7 = llvm.extractelement %6[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @gep_splat_base_w_cv_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.shufflevector %4, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %6 = llvm.getelementptr %5[%2] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %7 = llvm.extractelement %6[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @gep_splat_base_w_vidx(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.shufflevector %3, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %5 = llvm.getelementptr %4[%arg1] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<2 x ptr>
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @gep_cvbase_w_s_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @GLOBAL : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<2 x ptr>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.getelementptr %6[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %9 = llvm.extractelement %8[%7 : i32] : !llvm.vec<2 x ptr>
    llvm.return %9 : !llvm.ptr
  }
  llvm.func @gep_cvbase_w_cv_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @GLOBAL : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<2 x ptr>
    %7 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.getelementptr %6[%7] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %10 = llvm.extractelement %9[%8 : i32] : !llvm.vec<2 x ptr>
    llvm.return %10 : !llvm.ptr
  }
  llvm.func @gep_sbase_w_cv_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %3 = llvm.extractelement %2[%1 : i32] : !llvm.vec<2 x ptr>
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @gep_sbase_w_splat_idx(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi64> 
    %5 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<2 x ptr>
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @gep_splat_both(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.shufflevector %4, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %6 = llvm.insertelement %arg1, %2[%1 : i32] : vector<2xi64>
    %7 = llvm.shufflevector %6, %2 [0, 0] : vector<2xi64> 
    %8 = llvm.getelementptr %5[%7] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %9 = llvm.extractelement %8[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %9 : !llvm.ptr
  }
  llvm.func @gep_all_lanes_undef(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.insertelement %arg1, %2[%3 : i32] : vector<2xi64>
    %6 = llvm.getelementptr %4[%5] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    llvm.return %6 : !llvm.vec<2 x ptr>
  }
  llvm.func @gep_demanded_lane_undef(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.insertelement %arg1, %2[%3 : i32] : vector<2xi64>
    %6 = llvm.getelementptr %4[%5] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %7 = llvm.extractelement %6[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @PR41624(%arg0: !llvm.vec<2 x ptr>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.getelementptr %arg0[%0, 0] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.struct<(i32, i32)>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<2 x ptr>
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @zero_sized_type_extract(%arg0: vector<4xi64>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @global : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr>
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %12 = llvm.getelementptr inbounds %9[%11, %arg0] : (!llvm.vec<4 x ptr>, vector<4xi64>, vector<4xi64>) -> !llvm.vec<4 x ptr>, !llvm.array<0 x i32>
    %13 = llvm.extractelement %12[%10 : i64] : !llvm.vec<4 x ptr>
    llvm.return %13 : !llvm.ptr
  }
  llvm.func @select_cond_with_eq_true_false_elts(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 0, 0, 0] : vector<4xi1> 
    %3 = llvm.select %2, %1, %arg1 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @select_cond_with_eq_true_false_elts2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1, 0, 1] : vector<4xi1> 
    %3 = llvm.select %2, %1, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @select_cond_with_eq_true_false_elts3(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [1, 3, 5, -1] : vector<4xf32> 
    %2 = llvm.shufflevector %arg1, %arg0 [0, 7, 6, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %arg2, %0 [-1, 1, 2, 3] : vector<4xi1> 
    %4 = llvm.select %3, %1, %2 : vector<4xi1>, vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @select_cond_with_undef_true_false_elts(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [-1, 5, 6, 7] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1, 0, 1] : vector<4xi1> 
    %3 = llvm.select %2, %1, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @select_cond_(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>, %arg3: i1) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.insertelement %arg3, %arg2[%0 : i32] : vector<4xi1>
    %2 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    %3 = llvm.select %1, %2, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @ins_of_ext(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<4xf32>
    %6 = llvm.insertelement %5, %1[%0 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg1, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }
  llvm.func @ins_of_ext_twice(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<4xf32>
    %6 = llvm.insertelement %5, %1[%0 : i32] : vector<4xf32>
    %7 = llvm.extractelement %arg0[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %7, %6[%2 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%3 : i32] : vector<4xf32>
    %10 = llvm.insertelement %arg1, %9[%4 : i32] : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }
  llvm.func @ins_of_ext_wrong_demand(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.extractelement %arg0[%0 : i32] : vector<4xf32>
    %5 = llvm.insertelement %4, %1[%0 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%3 : i32] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }
  llvm.func @ins_of_ext_wrong_type(%arg0: vector<5xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<5xf32>
    %6 = llvm.insertelement %5, %1[%0 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg1, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }
  llvm.func @ins_of_ext_undef_elts_propagation(%arg0: vector<4xi4>, %arg1: vector<4xi4>, %arg2: i4) -> vector<4xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.extractelement %arg0[%0 : i32] : vector<4xi4>
    %4 = llvm.insertelement %3, %1[%0 : i32] : vector<4xi4>
    %5 = llvm.insertelement %arg2, %4[%2 : i32] : vector<4xi4>
    %6 = llvm.shufflevector %5, %arg1 [0, 6, 2, 7] : vector<4xi4> 
    llvm.return %6 : vector<4xi4>
  }
  llvm.func @ins_of_ext_undef_elts_propagation2(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i4) -> vector<8xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<8xi4>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.extractelement %arg0[%0 : i32] : vector<8xi4>
    %5 = llvm.insertelement %4, %1[%0 : i32] : vector<8xi4>
    %6 = llvm.extractelement %arg0[%2 : i32] : vector<8xi4>
    %7 = llvm.insertelement %6, %5[%2 : i32] : vector<8xi4>
    %8 = llvm.insertelement %arg2, %7[%3 : i32] : vector<8xi4>
    %9 = llvm.shufflevector %8, %arg1 [0, 1, 2, 11, 10, 9, 8, -1] : vector<8xi4> 
    %10 = llvm.shufflevector %9, %arg0 [0, 1, 2, 3, 4, 5, 6, 15] : vector<8xi4> 
    llvm.return %10 : vector<8xi4>
  }
  llvm.func @common_binop_demand_via_splat_op0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %2 = llvm.mul %1, %arg1  : vector<2xi4>
    %3 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_splat_op1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : vector<2xi4>
    %4 = llvm.sub %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %arg1, %3 [0, 0] : vector<2xi4> 
    %6 = llvm.mul %4, %5  : vector<2xi4>
    %7 = llvm.mul %4, %arg1  : vector<2xi4>
    %8 = llvm.shufflevector %7, %3 [0, 0] : vector<2xi4> 
    llvm.call @use(%8) : (vector<2xi4>) -> ()
    llvm.call @use(%6) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_splat_op0_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(2 : i4) : i4
    %4 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.poison : vector<2xi4>
    %6 = llvm.sub %2, %arg0  : vector<2xi4>
    %7 = llvm.sub %4, %arg1  : vector<2xi4>
    %8 = llvm.shufflevector %6, %5 [0, 0] : vector<2xi4> 
    %9 = llvm.mul %7, %8  : vector<2xi4>
    %10 = llvm.mul %6, %7  : vector<2xi4>
    %11 = llvm.shufflevector %10, %5 [0, 0] : vector<2xi4> 
    llvm.call @use(%11) : (vector<2xi4>) -> ()
    llvm.call @use(%9) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_splat_op1_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(3 : i4) : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.mlir.poison : vector<2xi4>
    %7 = llvm.sub %2, %arg0  : vector<2xi4>
    %8 = llvm.sub %5, %arg1  : vector<2xi4>
    %9 = llvm.shufflevector %8, %6 [0, 0] : vector<2xi4> 
    %10 = llvm.mul %9, %7  : vector<2xi4>
    %11 = llvm.mul %7, %8  : vector<2xi4>
    %12 = llvm.shufflevector %11, %6 [0, 0] : vector<2xi4> 
    llvm.call @use(%12) : (vector<2xi4>) -> ()
    llvm.call @use(%10) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_splat_op0_wrong_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %2 = llvm.sub %arg1, %1  : vector<2xi4>
    %3 = llvm.sub %arg0, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_splat_op0_not_dominated1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.mul %2, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %1, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_splat_op0_not_dominated2(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %2 = llvm.shufflevector %1, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %4 = llvm.mul %3, %arg1  : vector<2xi4>
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.return
  }
  llvm.func @common_binop_demand_via_extelt_op0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }
  llvm.func @common_binop_demand_via_extelt_op1(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.poison : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.fsub %0, %arg0  : vector<2xf32>
    %4 = llvm.shufflevector %arg1, %1 [0, 0] : vector<2xf32> 
    %5 = llvm.fdiv %3, %4  : vector<2xf32>
    %6 = llvm.fdiv %3, %arg1  : vector<2xf32>
    %7 = llvm.extractelement %6[%2 : i32] : vector<2xf32>
    llvm.call @use_fp(%5) : (vector<2xf32>) -> ()
    llvm.return %7 : f32
  }
  llvm.func @common_binop_demand_via_extelt_op0_commute(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<[3.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.poison : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.fsub %0, %arg0  : vector<2xf32>
    %5 = llvm.fsub %1, %arg1  : vector<2xf32>
    %6 = llvm.shufflevector %4, %2 [0, 0] : vector<2xf32> 
    %7 = llvm.fmul %5, %6  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    %8 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    %9 = llvm.extractelement %8[%3 : i32] : vector<2xf32>
    llvm.call @use_fp(%7) : (vector<2xf32>) -> ()
    llvm.return %9 : f32
  }
  llvm.func @common_binop_demand_via_extelt_op1_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(3 : i4) : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.mlir.poison : vector<2xi4>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.sub %2, %arg0  : vector<2xi4>
    %9 = llvm.sub %5, %arg1  : vector<2xi4>
    %10 = llvm.shufflevector %9, %6 [0, 0] : vector<2xi4> 
    %11 = llvm.or %10, %8  : vector<2xi4>
    %12 = llvm.or %8, %9  : vector<2xi4>
    %13 = llvm.extractelement %12[%7 : i32] : vector<2xi4>
    llvm.call @use(%11) : (vector<2xi4>) -> ()
    llvm.return %13 : i4
  }
  llvm.func @common_binop_demand_via_extelt_op0_wrong_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %arg1, %2  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }
  llvm.func @common_binop_demand_via_extelt_op0_not_dominated1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    %5 = llvm.extractelement %2[%1 : i32] : vector<2xi4>
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }
  llvm.func @common_binop_demand_via_extelt_op0_not_dominated2(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<2xi4>
    %2 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %3 = llvm.extractelement %2[%0 : i32] : vector<2xi4>
    %4 = llvm.shufflevector %arg0, %1 [0, 0] : vector<2xi4> 
    %5 = llvm.mul %4, %arg1  : vector<2xi4>
    llvm.call @use(%5) : (vector<2xi4>) -> ()
    llvm.return %3 : i4
  }
  llvm.func @common_binop_demand_via_extelt_op0_mismatch_elt0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }
  llvm.func @common_binop_demand_via_extelt_op0_mismatch_elt1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }
  llvm.func @common_binop_demand_via_splat_mask_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [0, -1] : vector<2xi8> 
    %2 = llvm.add %arg0, %1  : vector<2xi8>
    %3 = llvm.add %arg0, %arg1  : vector<2xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi8> 
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @common_binop_demand_via_splat_mask_poison_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [-1, 0] : vector<2xi8> 
    %2 = llvm.add %arg0, %1  : vector<2xi8>
    %3 = llvm.add %arg0, %arg1  : vector<2xi8>
    %4 = llvm.shufflevector %3, %arg1 [0, 2] : vector<2xi8> 
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @common_binop_demand_via_splat_mask_poison_3(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [-1, 0] : vector<2xi8> 
    %2 = llvm.add %arg0, %1  : vector<2xi8>
    %3 = llvm.add %arg0, %arg1  : vector<2xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi8> 
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
}
