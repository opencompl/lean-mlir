module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @X() {addr_space = 0 : i32} : i32
  llvm.func @use(i1)
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %arg0 : i32
    %3 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg0, %arg0 : i32
    %4 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %arg0 : i32
    %3 = llvm.icmp "ne" %0, %1 : !llvm.ptr
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ne" %arg0, %arg0 : i32
    %4 = llvm.icmp "ne" %0, %1 : !llvm.ptr
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %0 : i32
    llvm.return %1 : i1
  }
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }
  llvm.func @test9(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %0 : i1
    llvm.return %1 : i1
  }
  llvm.func @test10(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %0 : i1
    llvm.return %1 : i1
  }
  llvm.func @test11(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ule" %arg0, %0 : i1
    llvm.return %1 : i1
  }
  llvm.func @test12(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "uge" %arg0, %0 : i1
    llvm.return %1 : i1
  }
  llvm.func @test13(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i1
    llvm.return %0 : i1
  }
  llvm.func @test13vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.icmp "uge" %arg0, %arg1 : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test14(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i1
    llvm.return %0 : i1
  }
  llvm.func @test14vec(%arg0: vector<3xi1>, %arg1: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi1>
    llvm.return %0 : vector<3xi1>
  }
  llvm.func @bool_eq0(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg0, %1 : i64
    %5 = llvm.icmp "eq" %4, %2 : i1
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @bool_eq0_logical(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg0, %1 : i64
    %5 = llvm.icmp "eq" %4, %2 : i1
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @xor_of_icmps(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "eq" %arg0, %1 : i64
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_commute(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "eq" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_to_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_to_ne_commute(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_neg_to_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-6 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_to_ne_vector(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi64>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %4 = llvm.xor %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @xor_of_icmps_to_ne_no_common_operand(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_to_ne_extra_use_one(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.call @use(%2) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_to_ne_extra_use_two(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_of_icmps_to_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR2844(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-638208501 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.select %5, %0, %2 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @PR2844_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-638208501 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    %7 = llvm.select %6, %0, %3 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @test16(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test17(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @test18(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.icmp "slt" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @test19(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @test20(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test20vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test21vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test22(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(100663295 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.and %arg1, %2  : i32
    %7 = llvm.icmp "sgt" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @test22_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(100663295 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.and %arg1, %2  : i32
    %8 = llvm.icmp "sgt" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @test23(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test23vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test24(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @test24vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.lshr %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
}
