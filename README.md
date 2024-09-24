# K-means Clustering for Visual Abstraction

This Processing sketch demonstrates K-means clustering for visual abstraction of images. It allows users to interactively adjust the number of clusters and toggle pixel sorting within clusters.

## Features

- K-means clustering for image abstraction
- Interactive slider to adjust the number of clusters (k)
- Option to sort pixels within clusters based on brightness
- Real-time visualization of clustering results

## Requirements

- [Processing 3](https://processing.org/download/) or later

## Setup

1. Clone this repository or download the sketch files.
2. Open the `k_means_clustering_sketch.pde` file in Processing.
3. Place your input image (named `IMG_5748_1080x1080.png`) in the `data/` folder.
4. Run the sketch.

## Usage

- Use the slider at the bottom of the window to adjust the number of clusters (k).
- Press 'S' or 's' to toggle pixel sorting within clusters.

## Files

- `k_means_clustering_sketch.pde`: Main sketch file containing the K-means clustering implementation and visualization code.
- `Slider.pde`: Class file for the interactive slider used to adjust the number of clusters.
- `data/IMG_5748_1080x1080.png`: Sample input image (replace with your own image).

## License

This project is open-source and available under the [MIT License](https://opensource.org/licenses/MIT).
