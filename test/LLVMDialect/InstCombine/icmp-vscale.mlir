module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ugt_vscale64_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(1024 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    llvm.return %4 : i1
  }
  llvm.func @ugt_vscale64_x_31() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(1024 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    llvm.return %4 : i1
  }
  llvm.func @ugt_vscale16_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(5 : i16) : i16
    %1 = llvm.mlir.constant(1024 : i16) : i16
    %2 = "llvm.intr.vscale"() : () -> i16
    %3 = llvm.shl %2, %0  : i16
    %4 = llvm.icmp "ugt" %3, %1 : i16
    llvm.return %4 : i1
  }
  llvm.func @ult_vscale16() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(1024 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ult" %0, %1 : i16
    llvm.return %2 : i1
  }
  llvm.func @ule_vscale64() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    llvm.return %2 : i1
  }
  llvm.func @ueq_vscale64_range4_4() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }
  llvm.func @ne_vscale64_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(39488 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    llvm.return %4 : i1
  }
  llvm.func @vscale_ule_max() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ule" %1, %0 : i16
    llvm.return %2 : i1
  }
  llvm.func @vscale_ult_max() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ult" %1, %0 : i16
    llvm.return %2 : i1
  }
  llvm.func @vscale_uge_min() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "uge" %1, %0 : i16
    llvm.return %2 : i1
  }
  llvm.func @vscale_ugt_min() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ugt" %1, %0 : i16
    llvm.return %2 : i1
  }
  llvm.func @vscale_uge_no_max() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @vscale_ugt_no_max() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @vscale_uge_max_overflow() -> i1 vscale_range(4, 256) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @vscale_ugt_max_overflow() -> i1 vscale_range(4, 256) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @vscale_eq_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @vscale_ult_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @vscale_ugt_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }
}
