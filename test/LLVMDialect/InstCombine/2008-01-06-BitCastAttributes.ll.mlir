module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @a() {
    llvm.return
  }
  llvm.func @b(%arg0: !llvm.ptr {llvm.inreg}) -> (i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }
  llvm.func @c(...) {
    llvm.return
  }
  llvm.func @g(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @c : !llvm.ptr
    %5 = llvm.call %0(%1) : !llvm.ptr, (i32) -> i64
    llvm.call %2(%arg0) : !llvm.ptr, (!llvm.ptr) -> ()
    %6 = llvm.call %0(%3) : !llvm.ptr, (!llvm.ptr) -> vector<2xi32>
    llvm.call %4(%1) : !llvm.ptr, (i32) -> ()
    llvm.call %4(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }
}
