module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external thread_local @tlsvar_a4(4 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global external thread_local @tlsvar_a32(5 : i32) {addr_space = 0 : i32, alignment = 32 : i64} : i32
  llvm.mlir.global external thread_local @tlsvar_a1(6 : i8) {addr_space = 0 : i32, alignment = 1 : i64} : i8
  llvm.func @func_increase_alignment() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.addressof @tlsvar_a4 : !llvm.ptr
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %2, %3 {alignment = 2 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @func_add_alignment() -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @tlsvar_a32 : !llvm.ptr
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    llvm.return %7 : i1
  }
  llvm.func @func_dont_reduce_alignment() -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.addressof @tlsvar_a1 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    llvm.return %7 : i1
  }
}
