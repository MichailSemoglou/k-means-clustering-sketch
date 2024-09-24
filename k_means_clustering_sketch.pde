PImage img;
PVector[] pixelColors;
PVector[] centers;
int[] labels;
int k = 5;
boolean sorted = false;
Slider kSlider;

void setup() {
  size(540, 540);
  surface.setTitle("K-means Clustering for Visual Abstraction");
  img = loadImage("IMG_5748_1080x1080.png");
  img.resize(width, height);
  img.loadPixels();
  
  pixelColors = new PVector[img.pixels.length];
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    pixelColors[i] = new PVector(red(c), green(c), blue(c));
  }
  
  kSlider = new Slider(20, height - 40, width - 40, 20, 2, 20, k);
  
  initializeClusters();
}

void initializeClusters() {
  centers = new PVector[k];
  labels = new int[pixelColors.length];
  
  for (int i = 0; i < k; i++) {
    int randomIndex = int(random(pixelColors.length));
    centers[i] = pixelColors[randomIndex].copy();
  }
}

void draw() {
  for (int iter = 0; iter < 5; iter++) {
    for (int i = 0; i < pixelColors.length; i++) {
      float minDist = Float.MAX_VALUE;
      for (int j = 0; j < k; j++) {
        float d = PVector.dist(pixelColors[i], centers[j]);
        if (d < minDist) {
          minDist = d;
          labels[i] = j;
        }
      }
    }
    
    PVector[] newCenters = new PVector[k];
    int[] counts = new int[k];
    for (int i = 0; i < k; i++) {
      newCenters[i] = new PVector();
    }
    for (int i = 0; i < pixelColors.length; i++) {
      int label = labels[i];
      newCenters[label].add(pixelColors[i]);
      counts[label]++;
    }
    for (int i = 0; i < k; i++) {
      if (counts[i] > 0) {
        newCenters[i].div(counts[i]);
      } else {
        int randomIndex = int(random(pixelColors.length));
        newCenters[i] = pixelColors[randomIndex].copy();
      }
    }
    centers = newCenters;
  }
  
  loadPixels();
  for (int i = 0; i < pixelColors.length; i++) {
    int label = labels[i];
    pixels[i] = color(centers[label].x, centers[label].y, centers[label].z);
  }
  updatePixels();
  
  if (sorted) {
    sortPixelsWithinClusters();
  }
  
  kSlider.display();
  
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);
  text("Clusters: " + k, 25, height - 60);
}

void mousePressed() {
  kSlider.mousePressed();
}

void mouseDragged() {
  kSlider.mouseDragged();
  int newK = kSlider.getValue();
  if (newK != k) {
    k = newK;
    initializeClusters();
  }
}

void mouseReleased() {
  kSlider.mouseReleased();
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    sorted = !sorted;
  }
}

void sortPixelsWithinClusters() {
  ArrayList<PVector>[] clusterPixels = new ArrayList[k];
  for (int i = 0; i < k; i++) {
    clusterPixels[i] = new ArrayList<PVector>();
  }
  
  for (int i = 0; i < pixelColors.length; i++) {
    int label = labels[i];
    clusterPixels[label].add(pixelColors[i]);
  }
  
  for (int i = 0; i < k; i++) {
    clusterPixels[i].sort((a, b) -> Float.compare(brightness(color(a.x, a.y, a.z)), brightness(color(b.x, b.y, b.z))));
  }
  
  loadPixels();
  int index = 0;
  for (int i = 0; i < k; i++) {
    for (PVector p : clusterPixels[i]) {
      pixels[index++] = color(p.x, p.y, p.z);
    }
  }
  updatePixels();
}
