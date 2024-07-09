module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s10("0123456789\00") {addr_space = 0 : i32}
  llvm.func @strrchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @fold_strrchr_sp10_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @call_strrchr_sp9_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(9 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @call_strrchr_sp2_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @call_strrchr_sp1_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
}
