module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vscale_SExt_i8toi32() -> i32 vscale_range(1, 64) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @vscale_SExt_i8toi32_poison() -> i32 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @vscale_ZExt_i8toi32() -> i32 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @vscale_ZExt_i8toi32_poison() -> i32 vscale_range(1, 256) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @vscale_ZExt_i8toi32_unknown() -> i32 {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @vscale_SExt_i8toi32_unbounded() -> i32 vscale_range(1, 0) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range(1, 0) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }
}
