module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test5vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test6(%arg0: i1) -> i1 {
    %0 = llvm.intr.ctpop(%arg0)  : (i1) -> i1
    llvm.return %0 : i1
  }
  llvm.func @mask_one_bit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @mask_one_bit_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2048> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @_parity_of_not(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @_parity_of_not_odd_type(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i7
    %3 = llvm.intr.ctpop(%2)  : (i7) -> i7
    %4 = llvm.and %3, %1  : i7
    llvm.return %4 : i7
  }
  llvm.func @_parity_of_not_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @_parity_of_not_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.xor %arg0, %6  : vector<2xi32>
    %9 = llvm.intr.ctpop(%8)  : (vector<2xi32>) -> vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @_parity_of_not_poison2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.xor %arg0, %0  : vector<2xi32>
    %9 = llvm.intr.ctpop(%8)  : (vector<2xi32>) -> vector<2xi32>
    %10 = llvm.and %9, %7  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @ctpop_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    %6 = llvm.add %3, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @ctpop_add_no_common_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @ctpop_add_no_common_bits_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.add %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @ctpop_add_no_common_bits_vec_use(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %4, %arg2 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %5 = llvm.add %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @ctpop_add_no_common_bits_vec_use2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %2, %arg2 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.lshr %arg1, %0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.add %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @ctpop_rotate_left(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.ctpop(%0)  : (i8) -> i8
    llvm.return %1 : i8
  }
  llvm.func @ctpop_rotate_right(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.ctpop(%0)  : (i8) -> i8
    llvm.return %1 : i8
  }
  llvm.func @sub_ctpop(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_ctpop_wrong_cst(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_ctpop_unknown(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @sub_ctpop_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.sub %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @sub_ctpop_vec_extra_use(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.sub %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_ctpop(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @zext_ctpop_vec(%arg0: vector<2xi7>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi7> to vector<2xi32>
    %1 = llvm.intr.ctpop(%0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @zext_ctpop_extra_use(%arg0: i16, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @parity_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @parity_xor_trunc(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i64) -> i64
    %2 = llvm.intr.ctpop(%arg1)  : (i64) -> i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @parity_xor_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.ctpop(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @parity_xor_wrong_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @parity_xor_extra_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.xor %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @parity_xor_extra_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.xor %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @select_ctpop_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }
}
