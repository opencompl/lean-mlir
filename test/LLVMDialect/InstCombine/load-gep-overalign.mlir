module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @foo(dense<[8961, 26437, -21623, -4147]> : vector<4xi16>) {addr_space = 0 : i32, alignment = 8 : i64} : vector<4xi16>
  llvm.func @report(i64, i8)
  llvm.func @test_vector_load_i8() {
    %0 = llvm.mlir.constant(dense<[8961, 26437, -21623, -4147]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.addressof @foo : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.mlir.constant(7 : i64) : i64
    %10 = llvm.getelementptr %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%2, %11) : (i64, i8) -> ()
    %12 = llvm.getelementptr %1[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %13 = llvm.load %12 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%3, %13) : (i64, i8) -> ()
    %14 = llvm.getelementptr %1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %15 = llvm.load %14 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%4, %15) : (i64, i8) -> ()
    %16 = llvm.getelementptr %1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%5, %17) : (i64, i8) -> ()
    %18 = llvm.getelementptr %1[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %19 = llvm.load %18 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%6, %19) : (i64, i8) -> ()
    %20 = llvm.getelementptr %1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %21 = llvm.load %20 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%7, %21) : (i64, i8) -> ()
    %22 = llvm.getelementptr %1[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %23 = llvm.load %22 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%8, %23) : (i64, i8) -> ()
    %24 = llvm.getelementptr %1[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %25 = llvm.load %24 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @report(%9, %25) : (i64, i8) -> ()
    llvm.return
  }
}
