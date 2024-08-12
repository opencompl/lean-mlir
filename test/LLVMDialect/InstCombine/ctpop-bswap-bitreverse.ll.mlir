module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ctpop_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @ctpop_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.intr.ctpop(%0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @ctpop_bswap(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @ctpop_bswap_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.intr.ctpop(%0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
}
