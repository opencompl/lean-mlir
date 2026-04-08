
define i24 @main(i53 %0) {
  %2 = trunc nuw i53 %0 to i24
  ret i24 %2
}
