

main(){
  print(0xFF112200);
  print(0xFF112233 % 256);
  print(((0xFF112233 - 0xFF112233 % 256) % (256 * 256)).toRadixString(16));
  print(0xFF112200 - 0xFF000000);
  print(0xFF112200 - 0xFF000000);
  print(0xFF112200 - 0xFF000000);
}
