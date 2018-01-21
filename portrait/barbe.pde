



/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* draw() beard
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void barbe()
{
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* horizon - supérieur                                                 */
/* - draws the upper horizon
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

float x_hz[] = {0.453, 0.472, 0.487, 0.510, 0.534, 0.543, 0.563, 0.582, 0.592, 0.616, 0.639, 0.653, 0.672};
float y_hz[] = {0.361, 0.342, 0.328, 0.314, 0.323, 0.357, 0.361, 0.357, 0.323, 0.314, 0.328, 0.342, 0.361};

float[] x_hzs_plt = new float[x_hz.length];
float[] y_hzs_plt = new float[y_hz.length];

  coordinate_xform(x_hz, y_hz, x_hzs_plt, y_hzs_plt);
    
  stroke(100);
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

float x_hzi[] = {0.418, 0.439, 0.463, 0.480, 0.499, 0.531, 0.569, 0.606, 0.639, 0.658, 0.675, 0.699, 0.719};
float y_hzi[] = {0.318, 0.283, 0.253, 0.213, 0.193, 0.175, 0.170, 0.175, 0.193, 0.213, 0.253, 0.283, 0.318};

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
  
  int interpts = 30;
  
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
    stroke(50 + random(-20,20),
           50 + random(-20,20),
           40 + random(-20,20),
           50);
    strokeWeight(random(1,3));

    line (xi_pts[jj], yi_pts[jj], xs_pts[jj], ys_pts[jj]);
    print (jj, xi_pts[jj], yi_pts[jj], "\n");
  }

}
