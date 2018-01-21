
/*
 * ...  MSDS 6390 - Data Visualization
 * ...  Homework 1 - 15-jan-2018
 * ...  Re-creation of Modernist Movement painting - Starry Night by van Gogh
 * ...  - Patrick McDevitt
 */
 

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* setup() routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */


void setup()
{
  size(858, 674);
  strokeWeight(1);
  noLoop();  // Run once and stop
}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* draw() routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void draw()
{
  
  background(5, 15, 100);
  draw_background();
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* etoiles - base */
/* - draws the stars
/* ...  - each star defined by center point, radius
/* ...  - coordinates related to bottom left of image, percentage of width & height
/* ...  - call etoile_van_gogh() routine - constrained randomized arcs for each star
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

  float x[] = {0.10, 0.25, 0.26, 0.35, 0.40, 0.60, 0.70, 0.90, 0.05, 0.15, 0.32, 0.36};
  float y[] = {0.95, 0.95, 0.80, 0.95, 0.92, 0.85, 0.75, 0.80, 0.52, 0.50, 0.68, 0.45};
  float rad[] = {0.10, 0.02, 0.05, 0.07, 0.05, 0.09, 0.09, 0.20, 0.02, 0.05, 0.03, 0.15};
  
  int n_etoile = x.length;
  
  for (int i = 0; i < n_etoile; i++)
  {
    x[i] = x[i] * width;
    y[i] = (1- y[i]) * height;
    rad[i] = rad[i] * width;
  }
  
  int rge = 200;
  int vrt = 200;
  int ble = 20;

  for (int i = 0; i < n_etoile; i++)
  {
    etoile_van_gogh(int(x[i]), int(y[i]), int(rad[i]),
      int(random(rge - 0.20 * rge, rge + 0.2 * rge)),
      int(random(vrt - 0.20 * vrt, vrt + 0.2 * vrt)),
      int(random(ble - 0.20 * ble, ble + 0.2 * ble)));
  }
  
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* nuages courbe - superieur   */
/* - draws the upper cloud on left part of image
/* ...  - cloud defined by upper & lower curves
/* ...  - coordinates related to bottom left of image, percentage of width & height
/* ...  - each point tranformed to screen coordinates
/* ...  - interpolated along curve to finer detail (~200 points/curve) using
/* ...    map_points_on_curve()
/* ...  - finer curves used as inputs to entre_2_courbes() which fills space
/* ...    between the upper and lower curve with constrained randomized 
/* ...    beginShape - curveVertex - endShape curves
/* ...  - entre_2_courbes called 3 times to map different color palettes 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

float x_cs[] = {0.000, 0.042, 0.095, 0.145, 0.213, 0.275, 0.338, 0.391, 0.445, 0.508, 0.570, 0.615, 0.647};
float y_cs[] = {0.890, 0.806, 0.754, 0.737, 0.754, 0.789, 0.850, 0.873, 0.867, 0.856, 0.833, 0.793, 0.703};

float x_cs_plt[] = {0.00, 0.37, 0.84, 1.28, 1.87, 2.42, 2.97, 3.44, 3.92, 4.47, 5.02, 5.41, 5.69};
float y_cs_plt[] = {0.00, 0.37, 0.84, 1.28, 1.87, 2.42, 2.97, 3.44, 3.92, 4.47, 5.02, 5.41, 5.69};

  for (int i_cs = 0; i_cs < x_cs.length; i_cs++)
  {
    x_cs_plt[i_cs] = x_cs[i_cs] * width;
    y_cs_plt[i_cs] = (1- y_cs[i_cs]) * height;
  }
 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* nuages courbe - inférieur   */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

float x_ci[] = {0.000, 0.069, 0.123, 0.176, 0.222, 0.275, 0.365, 0.418, 0.453, 0.494, 0.522, 0.550};
float y_ci[] = {0.624, 0.590, 0.579, 0.596, 0.619, 0.657, 0.731, 0.759, 0.754, 0.731, 0.691, 0.690};

float x_ci_plt[] = {0.000, 0.069, 0.123, 0.176, 0.222, 0.275, 0.365, 0.418, 0.453, 0.494, 0.522, 0.550};
float y_ci_plt[] = {0.624, 0.590, 0.579, 0.596, 0.619, 0.657, 0.731, 0.759, 0.754, 0.731, 0.691, 0.650};


  for (int i_ci = 0; i_ci < x_ci.length; i_ci++)
  {
    x_ci_plt[i_ci] = x_ci[i_ci] * width;
    y_ci_plt[i_ci] = (1- y_ci[i_ci]) * height;
  }

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* nuage - gauche - map points to higher fidelity    */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
  
  float [] x_n_i_pts = new float[250];
  float [] y_n_i_pts = new float[250];
    
  float [] x_n_s_pts = new float[250];
  float [] y_n_s_pts = new float[250];
  
  map_points_on_curve (x_ci_plt, y_ci_plt, 10, x_n_i_pts, y_n_i_pts);
  map_points_on_curve (x_cs_plt, y_cs_plt, 10, x_n_s_pts, y_n_s_pts);

    int rge_n = 70;
    int vrt_n = 130;
    int ble_n = 210;

    entre_2_courbes (x_n_i_pts, y_n_i_pts, x_n_s_pts, y_n_s_pts,
                    700, 2.5, 3.5,
                    rge_n, vrt_n, ble_n, 20, 1, 4);

    int rge_n2 = 100;
    int vrt_n2 = 100;
    int ble_n2 = 50;

    entre_2_courbes (x_n_i_pts, y_n_i_pts, x_n_s_pts, y_n_s_pts,
                    20, 2.5, 3.5,
                    rge_n2, vrt_n2, ble_n2, 20, 1, 3);

    int rge_n3 = 150;
    int vrt_n3 = 150;
    int ble_n3 = 100;

    entre_2_courbes (x_n_i_pts, y_n_i_pts, x_n_s_pts, y_n_s_pts,
                    50, 1.0, 3.0,
                    rge_n3, vrt_n3, ble_n3, 20, 1, 3);
                    
    int rge_n4 = 10;
    int vrt_n4 = 20;
    int ble_n4 = 5;

    entre_2_courbes (x_n_i_pts, y_n_i_pts, x_n_s_pts, y_n_s_pts,
                    20, 1.0, 3.0,
                    rge_n4, vrt_n4, ble_n4, 20, 1, 2);


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* horizon - supérieur                                                 */
/* - draws the upper horizon
/* ...  - same method as described above for the upper cloud
/* ...  - upper and lower curves, filled with contrained randomized curveVertex lines
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
float x_hz[] = {-0.20, 0.000, 0.028, 0.060, 0.092, 0.136, 0.252, 0.324, 0.400, 0.453, 0.494, 0.543, 0.606, 0.656, 0.705, 0.776, 0.825, 0.878, 0.938, 0.992, 1.20};
float y_hz[] = { 0.40, 0.411, 0.423, 0.434, 0.411, 0.383, 0.373, 0.383, 0.411, 0.423, 0.434, 0.429, 0.457, 0.473, 0.457, 0.501, 0.559, 0.591, 0.620, 0.637, 0.650};

float x_hzs_plt[] = {-0.20, 0.000, 0.028, 0.060, 0.092, 0.136, 0.252, 0.324, 0.400, 0.453, 0.494, 0.543, 0.606, 0.656, 0.705, 0.776, 0.825, 0.878, 0.938, 0.992, 1.20};
float y_hzs_plt[] = { 0.40, 0.411, 0.423, 0.434, 0.411, 0.383, 0.373, 0.383, 0.411, 0.423, 0.434, 0.429, 0.457, 0.473, 0.457, 0.501, 0.559, 0.591, 0.620, 0.637, 0.650};

  for (int i_hz = 0; i_hz < x_hz.length; i_hz++)
  {
    x_hzs_plt[i_hz] = x_hz[i_hz] * width;
    y_hzs_plt[i_hz] = (1- y_hz[i_hz]) * height;
  }

  stroke(0);
  noFill();
  strokeWeight(3);
  beginShape();
    curveVertex(x_hzs_plt[0], y_hzs_plt[0]);
    for (int j_hz = 0; j_hz < x_hzs_plt.length; j_hz++)
    {
      curveVertex(x_hzs_plt[j_hz], y_hzs_plt[j_hz]);
    }
    curveVertex(x_hzs_plt[x_hzs_plt.length-1], y_hzs_plt[x_hzs_plt.length-1]);
  endShape();

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* horizon - inferieur    */
/* - draws the horizon line between blue hillside and low horizontal cloud
/* ...  - same method as described above for the upper cloud
/* ...  - upper and lower curves, filled with contrained randomized curveVertex lines

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
float x_hzi[] = {-0.20, 0.000, 0.058, 0.125, 0.227, 0.364, 0.409, 0.450, 0.489, 0.534, 0.580, 0.623, 0.670, 0.705, 0.750, 0.809, 0.852, 0.870, 0.875, 0.909, 0.943, 0.989, 1.200};
float y_hzi[] = { 0.29, 0.294, 0.271, 0.286, 0.271, 0.286, 0.314, 0.323, 0.300, 0.323, 0.357, 0.377, 0.386, 0.371, 0.386, 0.400, 0.414, 0.420, 0.443, 0.457, 0.500, 0.500, 0.500};

float x_hzi_plt[] = {-0.20, 0.000, 0.058, 0.125, 0.227, 0.364, 0.409, 0.450, 0.489, 0.534, 0.580, 0.623, 0.670, 0.705, 0.750, 0.809, 0.852, 0.870, 0.875, 0.909, 0.943, 0.989, 1.200};
float y_hzi_plt[] = { 0.29, 0.294, 0.271, 0.286, 0.271, 0.286, 0.314, 0.323, 0.300, 0.323, 0.357, 0.377, 0.386, 0.371, 0.386, 0.400, 0.414, 0.420, 0.443, 0.457, 0.500, 0.500, 0.500};

  for (int i_hzi = 0; i_hzi < x_hzi.length; i_hzi++)
  {
    x_hzi_plt[i_hzi] = x_hzi[i_hzi] * width;
    y_hzi_plt[i_hzi] = (1- y_hzi[i_hzi]) * height;
  }
  
  stroke(0);
  noFill();
  strokeWeight(3);
  beginShape();
    curveVertex(x_hzi_plt[0], y_hzi_plt[0]);
    for (int j_hzi = 0; j_hzi < x_hzi_plt.length; j_hzi++)
    {
      curveVertex(x_hzi_plt[j_hzi], y_hzi_plt[j_hzi]);
    }
    curveVertex(x_hzi_plt[x_hzi_plt.length-1], y_hzi_plt[x_hzi_plt.length-1]);
  endShape();

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* map points to higher fidelity    */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
  
  float [] xi_pts = new float[250];
  float [] yi_pts = new float[250];
    
  float [] xs_pts = new float[250];
  float [] ys_pts = new float[250];
  
  map_points_on_curve (x_hzi_plt, y_hzi_plt, 10, xi_pts, yi_pts);
  map_points_on_curve (x_hzs_plt, y_hzs_plt, 10, xs_pts, ys_pts);

    int rge_hz = 50;
    int vrt_hz = 125;
    int ble_hz = 225;

    entre_2_courbes (xi_pts, yi_pts, xs_pts, ys_pts,
                    700, 2.5, 3.5,
                    rge_hz, vrt_hz, ble_hz, 20, 1, 4);

    int rge_hz2 = 200;
    int vrt_hz2 = 210;
    int ble_hz2 = 160;

    entre_2_courbes (xi_pts, yi_pts, xs_pts, ys_pts,
                    400, 1.0, 2.0,
                    rge_hz2, vrt_hz2, ble_hz2, 20, 1, 3);


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* foreground - base earth colors for village    */
/* - draws the horizontal lines as background for earth and the village
/* ...  - same method as described above 
/* ...  - upper and lower curves, filled with constrained randomized curveVertex lines
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
float x_fg_sr[] = {0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00, 1.20};
float y_fg_sr[] = {0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00};

float x_fg_sr_plt[] = {0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00, 1.20};
float y_fg_sr_plt[] = {0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00};

  for (int i_fg_sr = 0; i_fg_sr < x_fg_sr.length; i_fg_sr++)
  {
    x_fg_sr_plt[i_fg_sr] = x_fg_sr[i_fg_sr] * width;
    y_fg_sr_plt[i_fg_sr] = (1- y_fg_sr[i_fg_sr]) * height;
  }
  
  float [] x_fg_sr_pts = new float[250];
  float [] y_fg_sr_pts = new float[250];

    map_points_on_curve (x_fg_sr_plt, y_fg_sr_plt, 10, x_fg_sr_pts, y_fg_sr_pts);

    int rge_fg_sr = 4;
    int vrt_fg_sr = 8;
    int ble_fg_sr = 4;

    entre_2_courbes (x_fg_sr_pts, y_fg_sr_pts, xi_pts, yi_pts,
                    5000, 1, 6,
                    rge_fg_sr, vrt_fg_sr, ble_fg_sr, 30, 1, 4);


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* horizon - lower bound from village    */
/* - draws the horizontal lines as background for earth and the village
/* ...  - same method as described above 
/* ...  - upper and lower curves, filled with constrained randomized curveVertex lines
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
float x_hz_sr[] = {0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00, 1.20};
float y_hz_sr[] = {0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20};

float x_hz_sr_plt[] = {0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00, 1.20};
float y_hz_sr_plt[] = {0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20};

  for (int i_hz_sr = 0; i_hz_sr < x_hz_sr.length; i_hz_sr++)
  {
    x_hz_sr_plt[i_hz_sr] = x_hz_sr[i_hz_sr] * width;
    y_hz_sr_plt[i_hz_sr] = (1- y_hz_sr[i_hz_sr]) * height;
  }
  
  float [] x_sr_pts = new float[210];
  float [] y_sr_pts = new float[210];

    map_points_on_curve (x_hz_sr_plt, y_hz_sr_plt, 10, x_sr_pts, y_sr_pts);

    int rge_hz_sr = 10;
    int vrt_hz_sr = 10;
    int ble_hz_sr = 100;

    entre_2_courbes (x_sr_pts, y_sr_pts, xi_pts, yi_pts,
                    1000, 2.5, 3.5,
                    rge_hz_sr, vrt_hz_sr, ble_hz_sr, 30, 1, 4);

 //<>//
 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 /* center spiral -- upper cloud
 /* reference : https://forum.processing.org/one/topic/drawing-smooth-spiral.html
 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
  
    final float RES_upper = 1.05; // the line length
    
    float num_circles = 0.50;
    
    int xc0_min = int(0.50 * width);
    int yc0_max = int((1 - 0.63) * height);
    
    int xc0_max = int(0.54 * width);
    int yc0_min = int((1 - 0.67) * height);
    
    int r = 60;
    int g = 130;
    int b = 210;

    for (int ii = 0; ii < 70; ii++)
    {
      
      stroke(r+random(-20, 20), g+random(-20, 20), b+random(-20, 20));

      int xc0_now = int(random(xc0_min, xc0_max));
      int yc0_now = int(random(yc0_min, yc0_max));
      PVector spiralCenter0 = new PVector(xc0_now, yc0_now);

      float startRadius0 = 0.10 * width;
      float endRadius0 = 0.23 * width;
      float currRadius0 = startRadius0;
      
      float startR_min0 = 0.05 * width;
      float startR_max0 = 0.15 * width;
      
      startRadius0 = int(random(startR_min0, startR_max0));
      
      float endR_min0 = 0.01 * width;
      float endR_max0 = 0.02 * width;
      
      endRadius0 = int(random(endR_min0, endR_max0));

      float totalRadian0 = num_circles * PI * 2;
      
      float startRadian0 = 3.0 * PI / 2.0;
      float endRadian0 = startRadian0 + totalRadian0;
      
      float currentRadian0 = startRadian0;

    // This depends on the current radius
      float deltaAngle0;
    // Spiral starts from outside
      float lastX0 = cos(startRadian0) * startRadius0;
      float lastY0 = sin(startRadian0) * startRadius0;
      float nextX0, nextY0;

      while (currentRadian0 < endRadian0)
      {
        deltaAngle0 = PI * RES_upper / currRadius0;
        currentRadian0 += deltaAngle0;
        currRadius0 = map(currentRadian0, startRadian0, endRadian0, startRadius0, endRadius0);
     
        nextX0 = cos(currentRadian0) * currRadius0;
        nextY0 = sin(currentRadian0) * currRadius0;
        line(lastX0 + spiralCenter0.x, lastY0 + spiralCenter0.y,
        nextX0 + spiralCenter0.x, nextY0 + spiralCenter0.y);
        lastX0 = nextX0;
        lastY0 = nextY0;
      }
    } 

 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 /* center spiral lower cloud -- 1
 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
  
    final float RES = 1.05; // the line length
    float numofCircles = 0.90;
    
    int xc_min = int(0.68 * width);
    int yc_max = int((1 - 0.52) * height);
    
    int xc_max = int(0.72 * width);
    int yc_min = int((1 - 0.54) * height);
    
    for (int ii = 0; ii < 50; ii++)
    {
      
      stroke(r+random(-50, 50), g+random(-50, 50), b+random(-50, 50));

      int xc_now = int(random(xc_min, xc_max));
      int yc_now = int(random(yc_min, yc_max));
      PVector spiralCenter = new PVector(xc_now, yc_now);

      float startRadius = 0.09 * width;
      float endRadius = 0.018 * width;
      float currRadius = startRadius;

      float totalRadian = numofCircles * PI * 2;
      float startRadian = -1 * 7.0 * PI / 8.0;
      float endRadian = startRadian + totalRadian;
      float currentRadian = startRadian;

    // This depends on the current radius
      float deltaAngle;
    // Spiral starts from outside
      float lastX = cos(startRadian) * startRadius;
      float lastY = sin(startRadian) * startRadius;
      float nextX, nextY;

      while (currentRadian < endRadian)
      {
        deltaAngle = PI * RES / currRadius;
        currentRadian += deltaAngle;
        currRadius = map(currentRadian, startRadian, endRadian, startRadius, endRadius);
     
        nextX = cos(currentRadian) * currRadius;
        nextY = sin(currentRadian) * currRadius;
        line(lastX + spiralCenter.x, lastY + spiralCenter.y,
        nextX + spiralCenter.x, nextY + spiralCenter.y);
        lastX = nextX;
        lastY = nextY;
      }
    } 
    
 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 /* center spiral lower cloud -- 2
 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
  
    float numofCircles2 = 0.35;
    
    int xc2_min = int(0.53 * width);
    int yc2_max = int((1 - 0.64) * height);
    
    int xc2_max = int(0.575 * width);
    int yc2_min = int((1 - 0.66) * height);
    
    for (int ii = 0; ii < 100; ii++)
    {
      
      stroke(r+random(-50, 50), g+random(-50, 50), b+random(-50, 50));

      int xc2_now = int(random(xc2_min, xc2_max));
      int yc2_now = int(random(yc2_min, yc2_max));
      PVector spiralCenter2 = new PVector(xc2_now, yc2_now);

      float startRadius2 = 0.09 * width;
      float endRadius2 = 0.11 * width;
      float currRadius2 = startRadius2;
      
      float endR_min = 0.08 * width;
      float endR_max = 0.15 * width;
      
      endRadius2 = int(random(endR_min, endR_max));

      float totalRadian2 = numofCircles2 * PI * 2;
      float startRadian2 = 2*PI/8;
      float endRadian2 = startRadian2 + totalRadian2 + random(-PI/8, PI/8);
      float currentRadian2 = startRadian2;

    // This depends on the current radius
      float deltaAngle2;
    // Spiral starts from outside
      float lastX2 = cos(startRadian2) * startRadius2;
      float lastY2 = sin(startRadian2) * startRadius2;
      float nextX2, nextY2;

      while (currentRadian2 < endRadian2)
      {
        deltaAngle2 = PI * RES / currRadius2;
        currentRadian2 += deltaAngle2;
        currRadius2 = map(currentRadian2, startRadian2, endRadian2, startRadius2, endRadius2);
     
        nextX2 = cos(currentRadian2) * currRadius2;
        nextY2 = sin(currentRadian2) * currRadius2;
        line(lastX2 + spiralCenter2.x, lastY2 + spiralCenter2.y,
        nextX2 + spiralCenter2.x, nextY2 + spiralCenter2.y);
        lastX2 = nextX2;
        lastY2 = nextY2;
      }
    } 

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* oliviers - base */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

  int n_olivier = 150;
  float x_olv_min = 0.50;
  float x_olv_max = 0.99;
  float y_olv_min = 0.15;
  float y_olv_max = 0.25;
  float rad_olv_base = 0.05 * width;
  
  int rge_olv = 5;
  int vrt_olv = 25;
  int ble_olv = 50;

  for (int i = 0; i < n_olivier; i++)
  {
    float x_olv = random(x_olv_min, x_olv_max);
    
    y_olv_min = 0.4 - 0.3 * x_olv;
    float rad_olv = x_olv * rad_olv_base;
    x_olv = x_olv * width;
    
    int y_olv = int(random((1- y_olv_max) * height, (1- y_olv_min) * height)); 

    for (int i_olv = 0; i_olv < 5; i_olv++)
    {
      olivier_van_gogh(int(x_olv), y_olv, int(rad_olv),
        int(random(rge_olv - 0.20 * rge_olv, rge_olv + 0.2 * rge_olv)),
        int(random(vrt_olv - 0.20 * vrt_olv, vrt_olv + 0.2 * vrt_olv)),
        int(random(ble_olv - 0.20 * ble_olv, ble_olv + 0.2 * ble_olv)));
    }
  }
  
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* romarin - foreground - lower left */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

  int n_romarin = 50;
  float x_rom_min = 0.00;
  float x_rom_max = 0.25;
  float y_rom_min = 0.00;
  float y_rom_max = 0.15;
  float rad_rom_base = 0.08 * height;
  
  int rge_rom = 5;
  int vrt_rom = 8;
  int ble_rom = 3;

  for (int i = 0; i < n_romarin; i++)
  {
    float x_rom = random(x_rom_min, x_rom_max);
    
    float y_rom = random((1.0 - y_rom_max), (1.0 - y_rom_min)); 
    
    float rad_rom = y_rom * rad_rom_base;
    
    x_rom = x_rom * width;
    y_rom = y_rom * height;
    
    for (int i_rom = 0; i_rom < 5; i_rom++)
    {
      olivier_van_gogh(int(x_rom), int(y_rom), int(rad_rom),
        int(random(rge_rom - 0.20 * rge_rom, rge_rom + 0.2 * rge_rom)),
        int(random(vrt_rom - 0.20 * vrt_rom, vrt_rom + 0.2 * vrt_rom)),
        int(random(ble_rom - 0.20 * ble_rom, ble_rom + 0.2 * ble_rom)));
    }
  }


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* st-remy    */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

  int n_maison = 100;
  float x_sr_min = 0.30;
  float x_sr_max = 0.99;
  float y_sr_min = 0.05;
  float y_sr_max = 0.22;
  float len_sr_base = 0.05 * width;

  int rge_sr = 50;
  int vrt_sr = 50;
  int ble_sr = 25;
  float x_sr[] = {0.00, 0.04,  0.02, -0.02};
  float y_sr[] = {0.00, 0.00, -0.04, -0.04};
  float x_sr_now[] = {0,0,0,0};
  float y_sr_now[] = {0,0,0,0};

  for (int i_sr = 0; i_sr < n_maison; i_sr++)
  {
      float x_sr_1 = random(x_sr_min, x_sr_max);
      
      y_sr_max = 0.4 - 0.3 * x_sr_1;
      float y_sr_1 = random(y_sr_min, y_sr_max);

      for (int j_sr = 0; j_sr < 4; j_sr++)
      {
        x_sr_now[j_sr] = (x_sr_1 *(1 + x_sr[j_sr])) * width;
        y_sr_now[j_sr] = (1 - (y_sr_1 + (x_sr_1 * y_sr[j_sr]))) * height;
      }
    
      stroke(0);
      strokeWeight(int(random(1,2)));
      
      int r_sr = int(random(rge_sr - 0.30 * rge_sr, rge_sr + 0.30 * rge_sr));
      int v_sr = int(random(vrt_sr - 0.30 * vrt_sr, vrt_sr + 0.30 * vrt_sr));
      int b_sr = int(random(ble_sr - 0.30 * ble_sr, ble_sr + 0.30 * ble_sr));

      fill(r_sr, v_sr, b_sr);
    
      quad(x_sr_now[0], y_sr_now[0],
        x_sr_now[1], y_sr_now[1],
        x_sr_now[2], y_sr_now[2],
        x_sr_now[3], y_sr_now[3]);
  }

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* cedre */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

  int n_feuille = 400;
  float x_cdr_min = 0.19;
  float x_cdr_max = 0.50;
  float y_cdr_min = -0.1;
  float y_cdr_max = 0.65;
  float len_cdr_base = 0.05 * width;

  int rge_cdr = 30;
  int vrt_cdr = 25;
  int ble_cdr = 10;
  
  float x_cdr[] = {0,0,0,0};
  float y_cdr[] = {0,0,0,0};
  float x_cdr_now[] = {0,0,0,0};
  float y_cdr_now[] = {0,0,0,0};

  for (int i_cdr = 0; i_cdr < n_feuille; i_cdr++)
  {
      y_cdr[1] = random(y_cdr_min, y_cdr_max);
      
      x_cdr_max = (0.45 * (1 - y_cdr[1]) * (1 - y_cdr[1])) - 0.25 * (1 - y_cdr[1]) + 0.2;
      x_cdr[1] = random(x_cdr_min, x_cdr_max);
      
      x_cdr[2] = x_cdr[1] + random(-0.03, 0.06);
      y_cdr[2] = y_cdr[1] + random(0, 0.3);
      
      x_cdr[0] = x_cdr[1] + random(-0.2, 0.2);
      y_cdr[0] = y_cdr[1] + random(-0.05, 0.05);

      x_cdr[3] = x_cdr[2] + random(-0.2, 0.2);
      y_cdr[3] = y_cdr[2] + random(-0.05, 0.05);
      
      for (int j_cdr = 0; j_cdr < 4; j_cdr++)
      {
        x_cdr_now[j_cdr] = x_cdr[j_cdr] * width;
        y_cdr_now[j_cdr] = (1 - y_cdr[j_cdr]) * height;
      }

      stroke(0);
      strokeWeight(int(random(1,3)));
      int r_cdr = int(random(rge_cdr - 0.30 * rge_cdr, rge_cdr + 0.30 * rge_cdr));
      int v_cdr = int(random(vrt_cdr - 0.30 * vrt_cdr, vrt_cdr + 0.30 * vrt_cdr));
      int b_cdr = int(random(ble_cdr - 0.30 * ble_cdr, ble_cdr + 0.30 * ble_cdr));

      fill(r_cdr, v_cdr, b_cdr);
    
      curve(x_cdr_now[0], y_cdr_now[0],
      x_cdr_now[1], y_cdr_now[1],
      x_cdr_now[2], y_cdr_now[2],
      x_cdr_now[3], y_cdr_now[3]); 
  }

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* st-remy eglise   */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

  float x_egl[] = {0.55, 0.56,  0.57};
  float y_egl[] = {0.18, 0.38,  0.18};
  
  stroke(0);
  strokeWeight(1);
  
  fill(120, 140, 160);
  
  for (int ie = 0; ie < 3; ie++)
  {
     x_egl[ie] = x_egl[ie] * width;
     y_egl[ie] = (1 - y_egl[ie]) * height;
     
//     print(x_egl[ie], y_egl[ie], "\n");
  }

  triangle(x_egl[0], y_egl[0],
    x_egl[1], y_egl[1],
    x_egl[2], y_egl[2]);

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* save image to external file
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    save("starry_night.0.png");

}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* end of draw() routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* van_gogh-esque stars
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void etoile_van_gogh(int x, int y, int rad, int rouge, int vert, int bleu)
{
//  print("...etoile_van_gogh\n");
  
    fill(rouge, vert, bleu);
/*    ellipse(x, y, rad, rad);  */
    
    float debut;
    float fin;
    
    for (int ii = 0; ii < rad; ii++)
    {
      debut = random (0, 2*PI);
      fin = random (debut, debut+PI);
      
 //     print(ii, debut, fin, "\n");
      
      float rad_arc = random(0, rad);
      
      noFill();
      
      float coleur_mult = rad_arc * 0.4 * 255/width;
      int r = int(random(rouge - 0.20 * rouge, rouge + coleur_mult * rouge));
      int v = int(random(vert - 0.20 * vert, vert + coleur_mult * vert));
      int b = int(random(bleu - 0.20 * bleu, bleu + coleur_mult * bleu));
      
      stroke(r, v, b);
      
      strokeWeight(int(random(1,4)));
      
      arc(x, y, rad_arc, rad_arc, debut, fin);
    }
    
}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* olive grove --- 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void olivier_van_gogh(int x, int y, int rad, int rouge, int vert, int bleu)
{
//  print("...etoile_van_gogh\n");
  
    fill(rouge, vert, bleu);
/*    ellipse(x, y, rad, rad);  */
    
    float debut;
    float fin;
    
    for (int ii = 0; ii < rad; ii++)
    {
      debut = random (7*PI/8, 17*PI/8);
      fin = random (debut, 17*PI/8);
      
//      print(ii, debut, fin, "\n");
      
      float rad_arc = random(0, rad);
      
      noFill();
      
      float coleur_mult = rad_arc * 0.4 * 255/width;
      int r = int(random(rouge - 0.20 * rouge, rouge + coleur_mult * rouge));
      int v = int(random(vert - 0.20 * vert, vert + coleur_mult * vert));
      int b = int(random(bleu - 0.20 * bleu, bleu + coleur_mult * bleu));
      
      stroke(r, v, b);
      
      strokeWeight(int(random(1,4)));
      
      arc(x, y, rad_arc, rad_arc, debut, fin);
    }
    
}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* background noise
/*
/* reference : https://processing.org/examples/noise2d.html
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void draw_background()
{
  
  loadPixels();
  float increment = 0.02;
  int r_base = 40;
  int g_base = 100;
  int b_base = 200;

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
      pixels[x+y*width] = color(r_bright, g_bright, b_bright);
    }
  }
  
  updatePixels();
}


/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */
/* ...  map curve boundary to higher fidelity points arrays                                   */
/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */

void map_points_on_curve (
              float[] x_few_pts, float[] y_few_pts, int n_btwn,
              float[] x_many_pts, float[] y_many_pts)
{
  print ("\t\t... map_points_on_curve()\n");
  
  int ipt_cnt = 0;
  
  for (int numi = 0; numi < x_few_pts.length - 1; numi++)
  {      
      for (int it = 0; it < n_btwn; it++)
      {
    
        float tii = float(it) / float(n_btwn);
        
        float xiipt = curvePoint(x_few_pts[numi], x_few_pts[numi], x_few_pts[numi+1], x_few_pts[numi+1], tii);
        float yiipt = curvePoint(y_few_pts[numi], y_few_pts[numi], y_few_pts[numi+1], y_few_pts[numi+1], tii);   
      
        x_many_pts[ipt_cnt] = xiipt;
        y_many_pts[ipt_cnt] = yiipt;

        ipt_cnt++;
      }
  }  
    for (int numj = 0; numj < x_many_pts.length; numj++)
    {
      print (numj, round(x_many_pts[numj]), round(y_many_pts[numj]), "\n");
    }
}


/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */
/* ...  fill between 2 curves with varying streamlines                                        */
/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */

void entre_2_courbes (float[] x_i, float[] y_i, float[] x_s, float[] y_s,
                    int n_stream_lines, float ligne_pct_min, float ligne_pct_max,
                    int rge, int vrt, int ble, int color_variation,
                    int stroke_wgt_min, int stroke_wgt_max)
{

    print ("\t\t... entre_2_courbes()\n");

    float x_srch_min = min(min(x_i), min(x_s));
    float x_srch_max = max(max(x_i), max(x_s));
    
    float x_length_min = ligne_pct_min / 100;
    float x_length_max = ligne_pct_max / 100;
    
    for (int i_stream = 0; i_stream < n_stream_lines; i_stream++)
    {

/* ... point 1  */ 

  float x_rndm_1 = random(x_srch_min, x_srch_max);
  int i_srch = 0;  
  while (i_srch < x_i.length-1 && x_i[i_srch] < x_rndm_1) { i_srch++; }

  int j_srch = 0;
  while (j_srch < x_s.length-1 && x_s[j_srch] < x_rndm_1) { j_srch++; }
  
  float y_min_1 = min(y_s[j_srch], y_i[i_srch]);
  float y_max_1 = max(y_s[j_srch], y_i[i_srch]);
  
  float y_rndm_1 = random(y_min_1, y_max_1);
  
  float y_ratio = (y_rndm_1 - y_min_1) / (y_max_1 - y_min_1);
  
/* ... point 2  */ 

  int sign_2 = signum(y_s[j_srch] - y_i[i_srch]);

  float x_rndm_2 = min(x_rndm_1 + sign_2 * random (x_length_min, x_length_max) * width, width);
  
  int i2_srch = 0;  
  while (i2_srch < x_i.length-1 && x_i[i2_srch] < x_rndm_2) { i2_srch++; }

  int j2_srch = 0;
  while (j2_srch < x_s.length-1 && x_s[j2_srch] < x_rndm_2) { j2_srch++; }
  
  float y_min_2 = min(y_s[j2_srch], y_i[i2_srch]);
  float y_max_2 = max(y_s[j2_srch], y_i[i2_srch]);
  
  float y_rndm_2 = min(y_min_2 + y_ratio * (y_max_2 - y_min_2), y_max_2);

/* ... point 3  */ 

  int sign_3 = signum(y_s[j2_srch] - y_i[i2_srch]);

  float x_rndm_3 = min(x_rndm_2 + sign_3 * random (x_length_min, x_length_max) * width, width);
  int i3_srch = 0;  
  while (i3_srch < x_i.length-1 && x_i[i3_srch] < x_rndm_3) { i3_srch++; }

  int j3_srch = 0;
  while (j3_srch < x_s.length-1 && x_s[j3_srch] < x_rndm_3) { j3_srch++; }

  float y_min_3 = min(y_s[j3_srch], y_i[i3_srch]);
  float y_max_3 = max(y_s[j3_srch], y_i[i3_srch]);
  
  float y_rndm_3 = min(y_min_3 + y_ratio * (y_max_3 - y_min_3), y_max_3);
  
/* ... point 4  */ 

  int sign_4 = signum(y_s[j3_srch] - y_i[i3_srch]);
  
  float x_rndm_4 = min(x_rndm_3 + sign_4 * random (x_length_min, x_length_max) * width, width);
  int i4_srch = 0;  
  while (i4_srch < x_i.length-1 && x_i[i4_srch] < x_rndm_4) { i4_srch++; }

  int j4_srch = 0;
  while (j4_srch < x_s.length-1 && x_s[j4_srch] < x_rndm_4) { j4_srch++; }
  
  float y_min_4 = min(y_s[j4_srch], y_i[i4_srch]);
  float y_max_4 = max(y_s[j4_srch], y_i[i4_srch]);
  
  float y_rndm_4 = min(y_min_4 + y_ratio * (y_max_4 - y_min_4), y_max_4);
 
  print(round(x_rndm_1), round(y_rndm_1),
    round(x_rndm_2), round(y_rndm_2),
    round(x_rndm_3), round(y_rndm_3),
    round(x_rndm_4), round(y_rndm_4), "\n");
    
  noFill();
  strokeWeight(random(stroke_wgt_min, stroke_wgt_max));
  
  stroke(rge + random(-color_variation, color_variation),
         vrt + random(-color_variation, color_variation),
         ble + random(-color_variation, color_variation));
         
  if (y_rndm_4 > 0)
  {
  beginShape();
  curveVertex(x_rndm_1, y_rndm_1); 
  curveVertex(x_rndm_1, y_rndm_1); 
  curveVertex(x_rndm_2, y_rndm_2);
  curveVertex(x_rndm_3, y_rndm_3);
  curveVertex(x_rndm_4, y_rndm_4);
  curveVertex(x_rndm_4, y_rndm_4);
  endShape();
  }
  
    }
}

/* https://processing.org/discourse/beta/num_1194348325.html */

int signum(float f) {
  if (f > 0) return 1;
  if (f < 0) return -1;
  return 0;
} 
