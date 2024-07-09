module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5("12345") {addr_space = 0 : i32}
  llvm.func @strchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @fold_strchr_s_c_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.call @strchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @fold_strchr_s_c_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.call @strchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    %1 = llvm.icmp "ne" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @fold_strchr_s_nul_eqz(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @fold_strchr_s_nul_nez(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = llvm.icmp "ne" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @fold_strchr_a_c_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
}
