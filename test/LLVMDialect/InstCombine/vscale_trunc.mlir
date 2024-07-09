module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vscale_trunc_i32toi8() -> i8 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }
  llvm.func @vscale_trunc_i32toi8_poison() -> i8 vscale_range(1, 256) {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }
  llvm.func @vscale_trunc_i32toi8_noAttr() -> i8 {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }
}
