#alias_scope_domain = #llvm.alias_scope_domain<id = distinct[0]<>>
#alias_scope = #llvm.alias_scope<id = distinct[1]<>, domain = #alias_scope_domain>
#alias_scope1 = #llvm.alias_scope<id = distinct[2]<>, domain = #alias_scope_domain>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test01(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test02_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test03(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test04_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test05_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test06(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test07(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test08(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test11(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test12(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test13(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test14(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test15(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test16(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr
    llvm.return
  }
}
