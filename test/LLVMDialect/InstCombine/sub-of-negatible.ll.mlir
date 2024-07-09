module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external hidden @g() {addr_space = 0 : i32, dso_local} : !llvm.array<1 x array<1 x f64>>
  llvm.func @use4(i4)
  llvm.func @use8(i8)
  llvm.func @use_v2i4(vector<2xi4>)
  llvm.func @use32gen1(i32) -> i1
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %arg1  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @t4(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @select_of_constants_multi_use(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @PR52261(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.sub %2, %3 overflow<nsw>  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n4(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n5(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.select %arg1, %0, %arg2 : i1, i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t6(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @t7(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @n8(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @t9(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @n10(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @neg_of_sub_from_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @neg_of_sub_from_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_from_constant_of_sub_from_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_from_constant_of_sub_from_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_from_variable_of_sub_from_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_from_variable_of_sub_from_constant_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t12(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %1, %2  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @n13(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg2  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n14(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %1, %2  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @neg_of_add_with_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @neg_of_add_with_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_from_constant_of_add_with_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_from_constant_of_add_with_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_from_variable_of_add_with_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_from_variable_of_add_with_constant_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t15(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %1, %arg2  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n16(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %1, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @t16(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %1, %arg1  : i8
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i8)
  ^bb3(%3: i8):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @n17(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %1, %arg1  : i8
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i8)
  ^bb3(%3: i8):  // 2 preds: ^bb1, ^bb2
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @n19(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.sub %0, %arg1  : i8
    llvm.br ^bb3(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i8)
  ^bb3(%2: i8):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @phi_with_duplicate_incoming_basic_blocks(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(84 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    llvm.cond_br %arg2, ^bb1(%arg1 : i32), ^bb2(%1 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.switch %4 : i32, ^bb3 [
      0: ^bb2(%3 : i32),
      42: ^bb2(%3 : i32)
    ]
  ^bb2(%5: i32):  // 3 preds: ^bb0, ^bb1, ^bb1
    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.call @use32gen1(%6) : (i32) -> i1
    llvm.cond_br %7, ^bb1(%6 : i32), ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }
  llvm.func @t20(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(-42 : i16) : i16
    %1 = llvm.shl %0, %arg1  : i16
    %2 = llvm.trunc %1 : i16 to i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n21(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(-42 : i16) : i16
    %1 = llvm.shl %0, %arg1  : i16
    %2 = llvm.trunc %1 : i16 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_xor(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.sub %1, %2  : i4
    llvm.return %3 : i4
  }
  llvm.func @negate_xor_vec(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.mlir.constant(dense<[5, -6]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i4) : i4
    %4 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.sub %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @negate_xor_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_shl_xor(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.shl %2, %arg1  : i4
    %4 = llvm.sub %1, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @negate_shl_not_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %arg1  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_mul_not_uses_vec(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    llvm.call @use_v2i4(%4) : (vector<2xi4>) -> ()
    %5 = llvm.mul %4, %arg1  : vector<2xi4>
    %6 = llvm.sub %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @negate_sdiv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_sdiv_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_sdiv_extrause2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sdiv %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_ashr(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_lshr(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_ashr_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_lshr_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_ashr_wrongshift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_lshr_wrongshift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_sext(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_zext(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_sext_extrause(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_zext_extrause(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_sext_wrongwidth(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.sext %arg1 : i2 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_zext_wrongwidth(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.zext %arg1 : i2 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_shufflevector_oneinput_reverse(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [1, 0] : vector<2xi4> 
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @negate_shufflevector_oneinput_second_lane_is_undef(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [0, 2] : vector<2xi4> 
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @negate_shufflevector_twoinputs(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(-1 : i4) : i4
    %4 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.shl %2, %arg0  : vector<2xi4>
    %6 = llvm.xor %arg1, %4  : vector<2xi4>
    %7 = llvm.shufflevector %5, %6 [0, 3] : vector<2xi4> 
    %8 = llvm.sub %arg2, %7  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }
  llvm.func @negate_shufflevector_oneinput_extrause(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [1, 0] : vector<2xi4> 
    llvm.call @use_v2i4(%5) : (vector<2xi4>) -> ()
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @negation_of_zeroext_of_nonnegative(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sge" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @negation_of_zeroext_of_positive(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @negation_of_signext_of_negative(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @negation_of_signext_of_nonpositive(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sle" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @negation_of_signext_of_nonnegative__wrong_cast(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sge" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @negation_of_zeroext_of_negative_wrongcast(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @negation_of_increment_via_or_with_no_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg1, %0  : i8
    %2 = llvm.or %1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negation_of_increment_via_or_with_no_common_bits_set_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg1, %0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negation_of_increment_via_or_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.or %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negation_of_increment_via_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @add_via_or_with_no_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @add_via_or_with_common_bit_maybe_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @add_via_or_with_no_common_bits_set_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.call @use8(%5) : (i8) -> ()
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @negate_extractelement(%arg0: vector<2xi4>, %arg1: i32, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    llvm.call @use_v2i4(%2) : (vector<2xi4>) -> ()
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi4>
    %4 = llvm.sub %arg2, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @negate_extractelement_extrause(%arg0: vector<2xi4>, %arg1: i32, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    llvm.call @use_v2i4(%2) : (vector<2xi4>) -> ()
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi4>
    llvm.call @use4(%3) : (i4) -> ()
    %4 = llvm.sub %arg2, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @negate_insertelement(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.sub %0, %arg1  : i4
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi4>
    %5 = llvm.sub %arg3, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @negate_insertelement_extrause(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.sub %0, %arg1  : i4
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi4>
    llvm.call @use_v2i4(%4) : (vector<2xi4>) -> ()
    %5 = llvm.sub %arg3, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @negate_insertelement_nonnegatible_base(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.sub %0, %arg1  : i4
    %2 = llvm.insertelement %1, %arg0[%arg2 : i32] : vector<2xi4>
    %3 = llvm.sub %arg3, %2  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }
  llvm.func @negate_insertelement_nonnegatible_insert(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.insertelement %arg1, %2[%arg2 : i32] : vector<2xi4>
    %4 = llvm.sub %arg3, %3  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @negate_left_shift_by_constant_prefer_keeping_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_left_shift_by_constant_prefer_keeping_shl_extrause(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_left_shift_by_constant(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %arg3, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_left_shift_by_constant_extrause(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %arg3, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_add_with_single_negatible_operand(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_add_with_single_negatible_operand_depth2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(21 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.mul %2, %arg1  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_add_with_single_negatible_operand_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @negate_add_with_single_negatible_operand_non_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @negate_abs(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    %4 = llvm.sub %arg1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_nabs(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %1 : i1, i8
    %4 = llvm.sub %arg1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_select_of_op_vs_negated_op(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.select %arg2, %1, %arg0 : i1, i8
    %3 = llvm.sub %arg1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @dont_negate_ordinary_select(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i8 {
    %0 = llvm.select %arg3, %arg0, %arg1 : i1, i8
    %1 = llvm.sub %arg2, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @negate_select_of_negation_poison(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.sub %6, %arg1  : vector<2xi32>
    %9 = llvm.select %arg0, %8, %arg1 : vector<2xi1>, vector<2xi32>
    %10 = llvm.sub %7, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @negate_freeze(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.sub %arg0, %arg1  : i4
    %1 = llvm.freeze %0 : i4
    %2 = llvm.sub %arg2, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @negate_freeze_extrause(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.sub %arg0, %arg1  : i4
    %1 = llvm.freeze %0 : i4
    llvm.call @use4(%1) : (i4) -> ()
    %2 = llvm.sub %arg2, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @noncanonical_mul_with_constant_as_first_operand() {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.mul %1, %4 overflow<nsw>  : i16
    %6 = llvm.sext %5 : i16 to i32
    %7 = llvm.sub %2, %6 overflow<nsw>  : i32
    llvm.br ^bb1(%7 : i32)
  }
  llvm.func @PR56601(%arg0: vector<1xi64>, %arg1: vector<1xi64>) -> vector<1xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<1xi64>) : vector<1xi64>
    %1 = llvm.mlir.constant(dense<12> : vector<1xi64>) : vector<1xi64>
    %2 = llvm.mlir.constant(-4 : i64) : i64
    %3 = llvm.mlir.addressof @g : !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.add %4, %2  : i64
    %6 = llvm.mlir.undef : vector<1xi64>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<1xi64>
    %9 = llvm.mlir.constant(-3 : i64) : i64
    %10 = llvm.add %4, %9  : i64
    %11 = llvm.mlir.undef : vector<1xi64>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<1xi64>
    %14 = llvm.mul %arg0, %0 overflow<nsw>  : vector<1xi64>
    %15 = llvm.mul %arg1, %1 overflow<nsw>  : vector<1xi64>
    %16 = llvm.add %14, %8  : vector<1xi64>
    %17 = llvm.add %15, %13  : vector<1xi64>
    %18 = llvm.sub %16, %17  : vector<1xi64>
    llvm.return %18 : vector<1xi64>
  }
}
