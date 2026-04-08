
define i24 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i24
  ret i24 %2
}
