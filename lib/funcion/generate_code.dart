import 'dart:math';

class GenerateCode{
  String generateCode() {
  var random = Random();
  const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const codeLength = 6;
  var codeUnits = List.generate(codeLength, (index) {
    final randomIndex = random.nextInt(charset.length);
    return charset.codeUnitAt(randomIndex);
  });
  return String.fromCharCodes(codeUnits);
  }
}