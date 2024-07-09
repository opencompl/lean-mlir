module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @g_92() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.array<2 x ptr> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<2 x ptr> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.array<2 x ptr> 
    llvm.return %3 : !llvm.array<2 x ptr>
  }
  llvm.mlir.global external constant @g_177() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.array<2 x ptr> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.array<2 x ptr> 
    %5 = llvm.mlir.addressof @g_92 : !llvm.ptr
    %6 = llvm.getelementptr %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %6 : !llvm.ptr
  }
  llvm.mlir.global external @d(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global external @a(dense<0> : tensor<1xi32>) {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.array<1 x i32>
  llvm.func @PR6486() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.array<2 x ptr> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.array<2 x ptr> 
    %5 = llvm.mlir.addressof @g_92 : !llvm.ptr
    %6 = llvm.getelementptr %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.mlir.addressof @g_177 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %10 = llvm.icmp "ne" %1, %9 : !llvm.ptr
    %11 = llvm.zext %10 : i1 to i32
    %12 = llvm.icmp "sle" %8, %11 : i32
    llvm.return %12 : i1
  }
  llvm.func @PR16462_1() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @d : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(65535 : i32) : i32
    %6 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %7 = llvm.select %6, %0, %4 : i1, i32
    %8 = llvm.trunc %7 : i32 to i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.icmp "sgt" %9, %5 : i32
    llvm.return %10 : i1
  }
  llvm.func @PR16462_2() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @d : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(42 : i16) : i16
    %6 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %7 = llvm.select %6, %0, %4 : i1, i32
    %8 = llvm.trunc %7 : i32 to i16
    %9 = llvm.icmp "sgt" %8, %5 : i16
    llvm.return %9 : i1
  }
}
