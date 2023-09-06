module  {
  llvm.func @test1() {
    llvm.call @tan() : () -> ()
    llvm.return
  }
  llvm.func @tan()
}
