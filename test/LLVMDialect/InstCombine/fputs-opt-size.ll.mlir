module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("mylog.txt\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.1"("a\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.2"("Hello world this is a test\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func local_unnamed_addr @main() -> i32 attributes {passthrough = ["nounwind", "optsize"]} {
    %0 = llvm.mlir.constant("mylog.txt\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %4 = llvm.mlir.constant("Hello world this is a test\00") : !llvm.array<27 x i8>
    %5 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.call @fopen(%1, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %8 = llvm.call @fputs(%5, %7) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }
  llvm.func local_unnamed_addr @fopen(!llvm.ptr {llvm.nocapture, llvm.readonly}, !llvm.ptr {llvm.nocapture, llvm.readonly}) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind", "optsize"]}
  llvm.func local_unnamed_addr @fputs(!llvm.ptr {llvm.nocapture, llvm.readonly}, !llvm.ptr {llvm.nocapture}) -> i32 attributes {passthrough = ["nounwind", "optsize"]}
  llvm.func local_unnamed_addr @main_pgso() -> i32 attributes {function_entry_count = 0 : i64} {
    %0 = llvm.mlir.constant("mylog.txt\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %4 = llvm.mlir.constant("Hello world this is a test\00") : !llvm.array<27 x i8>
    %5 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.call @fopen(%1, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %8 = llvm.call @fputs(%5, %7) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }
}
