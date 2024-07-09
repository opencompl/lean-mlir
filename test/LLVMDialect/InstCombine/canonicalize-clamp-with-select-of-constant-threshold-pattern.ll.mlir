module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_select_cond_and_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sge" %arg0, %1 : i32
    %4 = llvm.select %2, %1, %0 : i1, i32
    %5 = llvm.and %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t0_select_cond_and_v0_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sle" %arg0, %0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.select %3, %1, %0 : i1, i32
    %6 = llvm.select %3, %4, %2 : i1, i1
    %7 = llvm.select %6, %arg0, %5 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t1_select_cond_and_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sge" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.and %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t1_select_cond_and_v1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sle" %arg0, %0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %4, %2 : i1, i1
    %7 = llvm.select %6, %arg0, %5 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t2_select_cond_or_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    %5 = llvm.or %2, %3  : i1
    %6 = llvm.select %5, %4, %arg0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t2_select_cond_or_v0_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %3, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %4 : i1, i1
    %7 = llvm.select %6, %5, %arg0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t3_select_cond_or_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %1, %0 : i1, i32
    %5 = llvm.or %2, %3  : i1
    %6 = llvm.select %5, %4, %arg0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t3_select_cond_or_v1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %0 : i1, i32
    %6 = llvm.select %3, %2, %4 : i1, i1
    %7 = llvm.select %6, %5, %arg0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t4_select_cond_xor_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t4_select_cond_xor_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t5_select_cond_xor_v2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.select %3, %1, %0 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @t5_select_cond_xor_v3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.select %2, %1, %0 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }
}
