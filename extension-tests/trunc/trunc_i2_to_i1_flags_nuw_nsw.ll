
define i1 @main(i2 %0) {
  %2 = trunc nuw nsw i2 %0 to i1
  ret i1 %2
}
