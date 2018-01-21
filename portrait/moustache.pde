

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* draw() mustache routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void moustache()
{
 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* horizon - supérieur                                                 */
/* - draws the upper horizon
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
//float x_hz[] = {0.376, 0.400, 0.416, 0.420, 0.439, 0.474, 0.500, 0.528, 0.568, 0.600, 0.631, 0.663, 0.698, 0.716, 0.720, 0.734, 0.760};
//float y_hz[] = {0.536, 0.564, 0.587, 0.633, 0.677, 0.717, 0.730, 0.744, 0.714, 0.744, 0.730, 0.717, 0.677, 0.633, 0.587, 0.564, 0.536};

float x_hz[] = {0.389, 0.413, 0.427, 0.436, 0.455, 0.475, 0.502, 0.531, 0.560, 0.589, 0.618, 0.646, 0.665, 0.684, 0.694, 0.707, 0.731};
float y_hz[] = {0.348, 0.376, 0.410, 0.442, 0.466, 0.481, 0.490, 0.500, 0.481, 0.500, 0.490, 0.481, 0.466, 0.442, 0.410, 0.376, 0.348};

float[] x_hzs_plt = new float[x_hz.length];
float[] y_hzs_plt = new float[y_hz.length];

  coordinate_xform(x_hz, y_hz, x_hzs_plt, y_hzs_plt);

  stroke(0);
  noFill();
  strokeWeight(1);
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
/* - draws the lower horizon line 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
//float x_hzi[] = {0.381, 0.407, 0.430, 0.443, 0.457, 0.483, 0.515, 0.545, 0.568, 0.591, 0.622, 0.653, 0.680, 0.693, 0.707, 0.730, 0.756};
//float y_hzi[] = {0.519, 0.530, 0.547, 0.576, 0.610, 0.637, 0.654, 0.660, 0.671, 0.660, 0.654, 0.637, 0.610, 0.576, 0.547, 0.530, 0.519};

float x_hzi[] = {0.394, 0.417, 0.436, 0.451, 0.470, 0.489, 0.512, 0.536, 0.560, 0.584, 0.608, 0.631, 0.651, 0.670, 0.684, 0.704, 0.727};
float y_hzi[] = {0.339, 0.343, 0.358, 0.386, 0.410, 0.424, 0.434, 0.439, 0.442, 0.439, 0.434, 0.424, 0.410, 0.386, 0.358, 0.343, 0.339};

float[] x_hzi_plt = new float[x_hzi.length];
float[] y_hzi_plt = new float[y_hzi.length];

  coordinate_xform(x_hzi, y_hzi, x_hzi_plt, y_hzi_plt);
  
  stroke(0);
  noFill();
  strokeWeight(1);
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
  
  int interpts = 80;
  
  int vector_size_i = interpts * (x_hzi_plt.length-1);
  
  float [] xi_pts = new float[vector_size_i];
  float [] yi_pts = new float[vector_size_i];
    
  int vector_size_s = interpts * (x_hzs_plt.length-1);
  
  float [] xs_pts = new float[vector_size_s];
  float [] ys_pts = new float[vector_size_s];
  
  map_points_on_curve (x_hzi_plt, y_hzi_plt, interpts, xi_pts, yi_pts);
  map_points_on_curve (x_hzs_plt, y_hzs_plt, interpts, xs_pts, ys_pts);
  
  for (int jj = 0; jj < xi_pts.length; jj++)
  {
    print (jj, xi_pts[jj], yi_pts[jj], "\n");
    
    stroke(50 + random(-20,20),
           30 + random(-20,20),
           30 + random(-20,20),
           50);
    strokeWeight(random(1,3));

    line (xi_pts[jj], yi_pts[jj], xs_pts[jj], ys_pts[jj]);
  }
}
