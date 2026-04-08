
define i2 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i2
  ret i2 %2
}
