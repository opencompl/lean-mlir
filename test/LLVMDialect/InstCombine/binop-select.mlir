module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @use_f32(f32)
  llvm.func @use_v2f16(vector<2xf16>)
  llvm.func @use_v2i8(vector<2xi8>)
  llvm.func @test1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg2 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test2(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg1 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test3(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test4(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test5(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg0, %arg1, %0 : i1, i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_sub_deduce_true(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_sub_deduce_true_no_const_fold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_sub_deduce_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.intr.sadd.sat(%arg0, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_sub_dont_deduce_with_undef_cond_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @test_sub_dont_deduce_with_poison_cond_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @test_sub_deduce_with_undef_val_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi8>
    %10 = llvm.intr.sadd.sat(%arg0, %9)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @test6(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test7(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %arg1, %1 : i1, i32
    %3 = llvm.sdiv %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test8(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.sdiv %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test9(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @test10(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.udiv %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test11(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test12(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg2 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @extra_use(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @extra_use2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %arg1, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sdiv %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_sel_op0(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_sel_op0_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @mul_sel_op0(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @mul_sel_op0_use(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.mul %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @sub_sel_op1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.sub %0, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_sel_op1_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sub %0, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @fadd_sel_op0(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fadd_sel_op0_use(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.call @use_f32(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fmul_sel_op1(%arg0: i1, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %3 = llvm.mlir.constant(dense<0xFFFF> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.fadd %arg1, %0  : vector<2xf16>
    %5 = llvm.select %arg0, %2, %3 : i1, vector<2xf16>
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf16>
    llvm.return %6 : vector<2xf16>
  }
  llvm.func @fmul_sel_op1_use(%arg0: i1, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %3 = llvm.mlir.constant(dense<0xFFFF> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.fadd %arg1, %0  : vector<2xf16>
    %5 = llvm.select %arg0, %2, %3 : i1, vector<2xf16>
    llvm.call @use_v2f16(%5) : (vector<2xf16>) -> ()
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf16>
    llvm.return %6 : vector<2xf16>
  }
  llvm.func @ashr_sel_op1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.ashr %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_sel_op1_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.ashr %2, %3  : i32
    llvm.return %4 : i32
  }
}
