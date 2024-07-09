module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g_40() {addr_space = 0 : i32, alignment = 2 : i64} : i8
  llvm.mlir.global external @g_461() {addr_space = 0 : i32, alignment = 2 : i64} : !llvm.array<6 x i8>
  llvm.mlir.global external local_unnamed_addr @g_49() {addr_space = 0 : i32, alignment = 2 : i64} : !llvm.struct<(i8, i8, i8, i8, i8)>
  llvm.func @func_24() -> i40 {
    %0 = llvm.mlir.addressof @g_49 : !llvm.ptr
    %1 = llvm.mlir.constant(-274869518337 : i40) : i40
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @g_461 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.mlir.addressof @g_40 : !llvm.ptr
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(23 : i40) : i40
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(23 : i32) : i32
    %11 = llvm.load %0 {alignment = 2 : i64} : !llvm.ptr -> i40
    %12 = llvm.and %11, %1  : i40
    %13 = llvm.icmp "eq" %5, %6 : !llvm.ptr
    %14 = llvm.zext %13 : i1 to i32
    %15 = llvm.icmp "sgt" %14, %7 : i32
    %16 = llvm.zext %15 : i1 to i40
    %17 = llvm.shl %16, %8  : i40
    %18 = llvm.or %12, %17  : i40
    %19 = llvm.lshr %18, %8  : i40
    %20 = llvm.trunc %19 : i40 to i32
    %21 = llvm.and %9, %20  : i32
    %22 = llvm.shl %21, %10 overflow<nsw, nuw>  : i32
    %23 = llvm.zext %22 : i32 to i40
    %24 = llvm.or %12, %23  : i40
    llvm.return %24 : i40
  }
}
