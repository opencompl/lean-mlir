module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @example(%arg0: !llvm.ptr {llvm.dereferenceable = 24 : i64}) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    %4 = llvm.icmp "ne" %3, %0 : !llvm.ptr
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @example2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    %4 = llvm.icmp "ne" %3, %0 : !llvm.ptr
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : !llvm.ptr
  }
}
