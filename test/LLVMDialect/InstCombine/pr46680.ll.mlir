module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external local_unnamed_addr @a(0 : i64) {addr_space = 0 : i32, alignment = 8 : i64, dso_local} : i64
  llvm.mlir.global external local_unnamed_addr @d(0 : i64) {addr_space = 0 : i32, alignment = 8 : i64, dso_local} : i64
  llvm.mlir.global external local_unnamed_addr @c() {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : i8
  llvm.func local_unnamed_addr @test(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @c : !llvm.ptr
    %4 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> i64
    %7 = llvm.icmp "ne" %6, %0 : i64
    llvm.cond_br %5, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %8 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %9 = llvm.trunc %8 : i16 to i8
    llvm.store %9, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    "llvm.intr.assume"(%7) : (i1) -> ()
    %10 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %11 = llvm.trunc %10 : i16 to i8
    llvm.store %11, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    %12 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %13 = llvm.trunc %12 : i16 to i8
    llvm.store %13, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    %14 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %15 = llvm.trunc %14 : i16 to i8
    llvm.store %15, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %16 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %17 = llvm.trunc %16 : i16 to i8
    llvm.store %17, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    %18 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %19 = llvm.trunc %18 : i16 to i8
    llvm.store %19, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    %20 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %21 = llvm.trunc %20 : i16 to i8
    llvm.store %21, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    %22 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %23 = llvm.trunc %22 : i16 to i8
    llvm.store %23, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb4
  }
}
