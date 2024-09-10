module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external @stdout() {addr_space = 0 : i32} : !llvm.ptr
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : !llvm.ptr
  llvm.mlir.global private unnamed_addr constant @".str"("an error: %d\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str1"("an error\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @test1(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("an error: %d\00") : !llvm.array<13 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %6, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %7 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %8 = llvm.call @fprintf(%7, %4, %arg0) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %9 : i32
  }
  llvm.func @fprintf(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture, llvm.readonly}, ...) -> i32 attributes {passthrough = ["nounwind"]}
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("an error\00") : !llvm.array<9 x i8>
    %4 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %10 = llvm.call @fwrite(%4, %5, %6, %9) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.br ^bb2(%7 : i32)
  ^bb2(%11: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %11 : i32
  }
  llvm.func @fwrite(!llvm.ptr {llvm.nocapture}, i64, i64, !llvm.ptr {llvm.nocapture}) -> i64 attributes {passthrough = ["nounwind"]}
  llvm.func @test3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stdout : !llvm.ptr
    %3 = llvm.mlir.constant("an error\00") : !llvm.array<9 x i8>
    %4 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %10 = llvm.call @fwrite(%4, %5, %6, %9) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.br ^bb2(%7 : i32)
  ^bb2(%11: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %11 : i32
  }
}
