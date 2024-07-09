module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @A__vtblZ() {addr_space = 0 : i32} : !llvm.struct<"A__vtbl", (ptr, ptr)> {
    %0 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    llvm.return %4 : !llvm.struct<"A__vtbl", (ptr, ptr)>
  }
  llvm.func @A.foo(!llvm.ptr {llvm.nocapture}) -> i32
  llvm.func @storeA(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %5 = llvm.mlir.addressof @A__vtblZ : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.struct<"A", (ptr)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"A", (ptr)> 
    llvm.store %7, %arg0 {alignment = 8 : i64} : !llvm.struct<"A", (ptr)>, !llvm.ptr
    llvm.return
  }
  llvm.func @storeB(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"B", (ptr, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"B", (ptr, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"B", (ptr, i64)> 
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.struct<"B", (ptr, i64)>, !llvm.ptr
    llvm.return
  }
  llvm.func @storeStructOfA(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %5 = llvm.mlir.addressof @A__vtblZ : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.struct<"A", (ptr)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"A", (ptr)> 
    %8 = llvm.mlir.undef : !llvm.struct<(struct<"A", (ptr)>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(struct<"A", (ptr)>)> 
    llvm.store %9, %arg0 {alignment = 8 : i64} : !llvm.struct<(struct<"A", (ptr)>)>, !llvm.ptr
    llvm.return
  }
  llvm.func @storeArrayOfA(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %5 = llvm.mlir.addressof @A__vtblZ : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.struct<"A", (ptr)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"A", (ptr)> 
    %8 = llvm.mlir.undef : !llvm.array<1 x struct<"A", (ptr)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<1 x struct<"A", (ptr)>> 
    llvm.store %9, %arg0 {alignment = 8 : i64} : !llvm.array<1 x struct<"A", (ptr)>>, !llvm.ptr
    llvm.return
  }
  llvm.func @storeLargeArrayOfA(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : !llvm.array<2000 x struct<"A", (ptr)>>
    %1 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %6 = llvm.mlir.addressof @A__vtblZ : !llvm.ptr
    %7 = llvm.mlir.undef : !llvm.struct<"A", (ptr)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"A", (ptr)> 
    %9 = llvm.insertvalue %8, %0[1] : !llvm.array<2000 x struct<"A", (ptr)>> 
    llvm.store %9, %arg0 {alignment = 8 : i64} : !llvm.array<2000 x struct<"A", (ptr)>>, !llvm.ptr
    llvm.return
  }
  llvm.func @storeStructOfArrayOfA(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %5 = llvm.mlir.addressof @A__vtblZ : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.struct<"A", (ptr)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"A", (ptr)> 
    %8 = llvm.mlir.undef : !llvm.array<1 x struct<"A", (ptr)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<1 x struct<"A", (ptr)>> 
    %10 = llvm.mlir.undef : !llvm.struct<(array<1 x struct<"A", (ptr)>>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(array<1 x struct<"A", (ptr)>>)> 
    llvm.store %11, %arg0 {alignment = 8 : i64} : !llvm.struct<(array<1 x struct<"A", (ptr)>>)>, !llvm.ptr
    llvm.return
  }
  llvm.func @storeArrayOfB(%arg0: !llvm.ptr, %arg1: !llvm.array<2 x struct<"B", (ptr, i64)>>) {
    llvm.store %arg1, %arg0 {alignment = 8 : i64} : !llvm.array<2 x struct<"B", (ptr, i64)>>, !llvm.ptr
    llvm.return
  }
  llvm.func @loadA(%arg0: !llvm.ptr) -> !llvm.struct<"A", (ptr)> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<"A", (ptr)>
    llvm.return %0 : !llvm.struct<"A", (ptr)>
  }
  llvm.func @loadB(%arg0: !llvm.ptr) -> !llvm.struct<"B", (ptr, i64)> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<"B", (ptr, i64)>
    llvm.return %0 : !llvm.struct<"B", (ptr, i64)>
  }
  llvm.func @loadStructOfA(%arg0: !llvm.ptr) -> !llvm.struct<(struct<"A", (ptr)>)> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<(struct<"A", (ptr)>)>
    llvm.return %0 : !llvm.struct<(struct<"A", (ptr)>)>
  }
  llvm.func @loadArrayOfA(%arg0: !llvm.ptr) -> !llvm.array<1 x struct<"A", (ptr)>> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.array<1 x struct<"A", (ptr)>>
    llvm.return %0 : !llvm.array<1 x struct<"A", (ptr)>>
  }
  llvm.func @loadStructOfArrayOfA(%arg0: !llvm.ptr) -> !llvm.struct<(array<1 x struct<"A", (ptr)>>)> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<(array<1 x struct<"A", (ptr)>>)>
    llvm.return %0 : !llvm.struct<(array<1 x struct<"A", (ptr)>>)>
  }
  llvm.func @structOfA(%arg0: !llvm.ptr) -> !llvm.struct<(struct<"A", (ptr)>)> {
    %0 = llvm.mlir.addressof @A.foo : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"A__vtbl", (ptr, ptr)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"A__vtbl", (ptr, ptr)> 
    %5 = llvm.mlir.addressof @A__vtblZ : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.struct<"A", (ptr)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"A", (ptr)> 
    %8 = llvm.mlir.undef : !llvm.struct<(struct<"A", (ptr)>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(struct<"A", (ptr)>)> 
    llvm.store %9, %arg0 {alignment = 8 : i64} : !llvm.struct<(struct<"A", (ptr)>)>, !llvm.ptr
    %10 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<(struct<"A", (ptr)>)>
    llvm.return %10 : !llvm.struct<(struct<"A", (ptr)>)>
  }
  llvm.func @structB(%arg0: !llvm.ptr) -> !llvm.struct<"B", (ptr, i64)> {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.struct<"B", (ptr, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"B", (ptr, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"B", (ptr, i64)> 
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.struct<"B", (ptr, i64)>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<"B", (ptr, i64)>
    llvm.return %5 : !llvm.struct<"B", (ptr, i64)>
  }
  llvm.func @loadArrayOfB(%arg0: !llvm.ptr) -> !llvm.array<2 x struct<"B", (ptr, i64)>> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.array<2 x struct<"B", (ptr, i64)>>
    llvm.return %0 : !llvm.array<2 x struct<"B", (ptr, i64)>>
  }
  llvm.func @loadLargeArrayOfB(%arg0: !llvm.ptr) -> !llvm.array<2000 x struct<"B", (ptr, i64)>> {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.array<2000 x struct<"B", (ptr, i64)>>
    llvm.return %0 : !llvm.array<2000 x struct<"B", (ptr, i64)>>
  }
  llvm.func @packed_alignment(%arg0: !llvm.ptr {llvm.dereferenceable = 9 : i64}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.S", packed (i8, struct<"struct.T", (i32, i32)>)>
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> !llvm.struct<"struct.T", (i32, i32)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<"struct.T", (i32, i32)> 
    llvm.return %4 : i32
  }
  llvm.func @check_alignment(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.struct<"struct.U", (i8, i8, i8, i8, i8, i8, i8, i8, i64)>
    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.struct<"struct.U", (i8, i8, i8, i8, i8, i8, i8, i8, i64)>, !llvm.ptr
    llvm.return
  }
}
