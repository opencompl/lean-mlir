module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g1() {addr_space = 0 : i32} : i16
  llvm.mlir.global external @g2() {addr_space = 0 : i32} : i16
  llvm.func @patatino() -> f32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @g2 : !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %5 = llvm.uitofp %4 : i1 to f32
    %6 = llvm.uitofp %4 : i1 to f32
    %7 = llvm.fmul %5, %6  : f32
    %8 = llvm.call @fabsf(%7) : (f32) -> f32
    llvm.return %8 : f32
  }
  llvm.func @fabsf(f32) -> f32
}
