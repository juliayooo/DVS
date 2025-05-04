void setup() {
  pinMode(2, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  int switchState = digitalRead(2);
  if (switchState == LOW) {
    Serial.println("1");  // Forward
  } else {
    Serial.println("-1"); // Backward
  }
  delay(100);
}