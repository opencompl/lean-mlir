module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<[40, 64, 64, 32]> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("file\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.1"("w\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.2"("str\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func internal @fputs_test_custom_dl() attributes {dso_local} {
    %0 = llvm.mlir.constant("file\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant("w\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %4 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %6 = llvm.call @fopen(%1, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %7 = llvm.call @fputs(%5, %6) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @fopen(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @fputs(!llvm.ptr {llvm.nocapture, llvm.readonly}, !llvm.ptr {llvm.nocapture}) -> i32
}
