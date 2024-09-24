class Slider {
  float x, y, w, h;
  int min, max, value;
  boolean dragging = false;

  Slider(float x, float y, float w, float h, int min, int max, int defaultValue) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.min = min;
    this.max = max;
    this.value = defaultValue;
  }

  void display() {
    noStroke();
    fill(0);
    rect(x, y, w, h);
    float sliderPosition = map(value, min, max, x, x + w);
    fill(#f1f1f1);
    rect(sliderPosition - 5, y - 5, 10, h + 10);
  }

  void mousePressed() {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y - 5 && mouseY <= y + h + 5) {
      dragging = true;
    }
  }

  void mouseDragged() {
    if (dragging) {
      float newValue = map(mouseX, x, x + w, min, max);
      value = constrain(round(newValue), min, max);
    }
  }

  void mouseReleased() {
    dragging = false;
  }

  int getValue() {
    return value;
  }
}
