module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @single_case() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %3, %0  : i32
    llvm.switch %4 : i32, ^bb1 [
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @multiple_cases() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %3, %0  : i32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    llvm.switch %4 : i32, ^bb1 [
      1: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %6 : i32
  ^bb3:  // pred: ^bb0
    llvm.return %5 : i32
  }
}
