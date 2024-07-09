module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @barrier()
  llvm.func @use.i8(i8)
  llvm.func @test_xor1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %arg1  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.icmp "sle" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "sgt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.icmp "eq" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor4(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "sge" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor5(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor6(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor7(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_xor8(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "uge" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_slt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_sle_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.icmp "sle" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_sgt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_sge_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "sge" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_ult_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_ule_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_ugt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_uge_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "uge" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_xor1_nofold_multi_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @xor_uge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @xor_uge_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @xor_ule_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[9, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ule" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @xor_sle_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg2  : i8
    %2 = llvm.icmp "ne" %arg1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.xor %1, %arg1  : i8
    %4 = llvm.icmp "sle" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @xor_sge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "sge" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @xor_ugt_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %arg2  : i8
    %3 = llvm.and %arg1, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    %6 = llvm.icmp "ugt" %2, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @xor_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @xor_sgt(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %2, %1  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.icmp "sgt" %4, %arg0 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @xor_sgt_fail_no_known_msb(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %2, %1  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.icmp "sgt" %4, %arg0 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @xor_slt_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "slt" %arg0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @xor_sgt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg2  : vector<2xi8>
    %2 = llvm.or %arg1, %0  : vector<2xi8>
    %3 = llvm.xor %1, %2  : vector<2xi8>
    %4 = llvm.icmp "sgt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @or_slt_intmin_indirect(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb1(%3: i1):  // 2 preds: ^bb2, ^bb3
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.icmp "slt" %4, %arg0 : i8
    llvm.br ^bb1(%5 : i1)
  ^bb3:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.br ^bb1(%1 : i1)
  }
}
