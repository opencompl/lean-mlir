
define i16 @main(i24 %0) {
  %2 = trunc nuw nsw i24 %0 to i16
  ret i16 %2
}
