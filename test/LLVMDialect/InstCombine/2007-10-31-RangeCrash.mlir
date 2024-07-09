module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<[64, 128]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i16) : i16
    %5 = llvm.mlir.constant(-1 : i16) : i16
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.icmp "slt" %0, %1 : i32
    llvm.cond_br %8, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%0, %0 : i32, i32)
  ^bb2:  // pred: ^bb3
    %9 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16
    %10 = llvm.icmp "ult" %9, %4 : i16
    %11 = llvm.icmp "ugt" %9, %5 : i16
    %12 = llvm.or %10, %11  : i1
    %13 = llvm.zext %12 : i1 to i32
    %14 = llvm.xor %13, %6  : i32
    %15 = llvm.add %17, %14  : i32
    %16 = llvm.add %18, %7  : i32
    llvm.br ^bb3(%15, %16 : i32, i32)
  ^bb3(%17: i32, %18: i32):  // 2 preds: ^bb1, ^bb2
    %19 = llvm.icmp "slt" %18, %0 : i32
    llvm.cond_br %19, ^bb2, ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %0 : i32
  ^bb5:  // pred: ^bb0
    llvm.return %2 : i32
  }
}
