/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* background noise
/*
/* reference : https://processing.org/examples/noise2d.html
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void draw_background(int r_base, int g_base, int b_base, int b_alpha)
{
  
  loadPixels();
  float increment = 0.02;

  float xoff = 0.0; // Start xoff at 0
  float detail = map(mouseX, 0, width, 0.1, 0.6);
  noiseDetail(8, detail);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++)
  {
    xoff += increment;                     // Increment xoff 
    float yoff = 0.0;                      // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++)
    {
      yoff += increment;                   // Increment yoff
      
      // Calculate noise and scale
      
      float r_bright = noise(xoff, yoff) * r_base * 2;
      float g_bright = noise(xoff, yoff) * g_base * 2;
      float b_bright = noise(xoff, yoff) * b_base * 2;
     
      // Set each pixel onscreen to a value
      pixels[x+y*width] = color(r_bright, g_bright, b_bright, b_alpha);
    }
  }
  
  updatePixels();
}