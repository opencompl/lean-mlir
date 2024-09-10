module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @eq_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    %2 = llvm.icmp "eq" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ne_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @eq_ne_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    %2 = llvm.icmp "slt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @use(i1)
  llvm.func @slt_zero_extra_uses(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    %2 = llvm.icmp "slt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }
  llvm.func @sgt_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    %2 = llvm.icmp "sgt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_minus1(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    %2 = llvm.icmp "sgt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_sgt_minus1(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.icmp "slt" %arg0, %0 : i4
    %3 = llvm.icmp "sgt" %arg1, %1 : i4
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_minus1_slt_zero_sgt(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.icmp "sgt" %arg0, %1 : vector<2xi4>
    %5 = llvm.icmp "slt" %arg1, %3 : vector<2xi4>
    %6 = llvm.xor %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @different_type_cmp_ops(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test13(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test14(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.icmp "ne" %arg1, %arg0 : i8
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @xor_icmp_ptr(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "slt" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @xor_icmp_true_signed(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_true_signed_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_true_signed_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_true_signed_commuted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_true_unsigned(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_to_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_to_ne_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_to_icmp_add(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_invalid_range(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_to_ne_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_to_icmp_add_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_icmp_to_icmp_add_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }
}
