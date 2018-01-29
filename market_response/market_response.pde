
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...  MSDS 6390 - Visualization of Information
/* ...
/* ...  Homework 3 - 27-jan-2018
/* ...
/* ...    patrick mcdevitt, sunna quazi, jack rasmus-vorrath
/* ...
/* ...  Dynamic Composition I 
 /* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* define global variables
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

int n_elem = 8;

Table[] eqty = new Table[n_elem];
Table[] valu = new Table[n_elem];

float[] y_prv = new float[n_elem];
float[] y_cur = new float[n_elem];
float[] del_y = new float[n_elem];

float[] x_loc = new float[n_elem];
float[] y_loc = new float[n_elem];
float[] size  = new float[n_elem];
int[] red = new int[n_elem];
int[] grn = new int[n_elem];
int[] blu = new int[n_elem];

/* ... account holdings :
/* ...    100 shares : BA, BABA, CSV, GE, MMM, SPY
/* ...     10 shares : BRK-A
/* ...      0 shares : DJI                                        */

int[] shares = {100, 100, 10, 100, 0, 100, 100, 100};

float account_value;
float acct_valu_o;

int ir = 0;
int ic = 0;

int day_length = 250;
int year_length = 900;

float rtt = 0;
float r = 0;

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* setup() routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void setup()
{
    size(1400, 800);
    background(100, 100, 100);

    frameRate(15);
    
 //   noLoop();
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* files with time based vertical displacement of each equity
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    eqty[0] = loadTable("ba.pts.csv", "header");
    eqty[1] = loadTable("baba.pts.csv", "header");
    eqty[2] = loadTable("brk-a.pts.csv", "header");
    eqty[3] = loadTable("csv.pts.csv", "header");
    eqty[4] = loadTable("dji.pts.csv", "header");
    eqty[5] = loadTable("ge.pts.csv", "header");
    eqty[6] = loadTable("mmm.pts.csv", "header");
    eqty[7] = loadTable("spy.pts.csv", "header");
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* historical stock price table from yahoo.finance for 2017
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    valu[0] = loadTable("BA.csv", "header");
    valu[1] = loadTable("BABA.csv", "header");
    valu[2] = loadTable("BRK-A.csv", "header");
    valu[3] = loadTable("CSV.csv", "header");
    valu[4] = loadTable("DJI.csv", "header");
    valu[5] = loadTable("GE.csv", "header");
    valu[6] = loadTable("MMM.csv", "header");
    valu[7] = loadTable("SPY.csv", "header");

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* size, spacing, color characteristics for each element
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    float elem_width = width / (3 * eqty.length / 2);
    for (int j = 0; j < eqty.length; j++)
    {
        x_loc[j] = j * elem_width + elem_width/2;
        y_loc[j] = height / 2;
        size[j] = 50;
        
        print(x_loc[j], y_loc[j], "\n");
        
        red[j] =  50 + j * 20;
        grn[j] = 250 - j * 20;
        blu[j] = 100 + j * 20;  
    }

}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* main draw routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void draw()
{
    background(100, 100, 100);
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/*     dynamic motion of stock response to market volume
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
    
    stroke(10);
    for (int ieq = 0; ieq < eqty.length; ieq++)
    {
        y_cur[ieq] = eqty[ieq].getFloat(ir, ic);    // current y position
        
        del_y[ieq] = (y_cur[ieq] - y_prv[ieq]) * 1E6;    // change in vertical position
        del_y[ieq] *= 3;
        
        pushMatrix();
        translate(0, del_y[ieq]);
        draw_element(ieq, x_loc[ieq], y_loc[ieq], size[ieq], red[ieq], grn[ieq], blu[ieq]);
        popMatrix();
        
        y_cur[ieq] = y_prv[ieq];        // set previous y position to current for next iteration 
    }
    
    display_date();
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/*     current account value
/* ...    - column 5 in .csv is Adj.Close price
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
 
     account_value = 1; //<>//
     for (int iqq = 0; iqq < valu.length; iqq++)
     {
         account_value += valu[iqq].getFloat(ir, 4) * shares[iqq] * 2;
     }
     if (ir == 0){acct_valu_o = account_value/2E4;}
     
     account_value /= 2E4;

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...    rectangle height is current account value
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

     pushMatrix();
     translate(3*width/4, 7*height/8 - account_value);
     fill(133, 187, 101);    // US dollar bill RGB
     stroke(10, 10, 10);
     strokeWeight(3);
     rect(0, 0, 100, account_value);
     popMatrix();
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...    static rectangle height is initial account value (reference)
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

     fill(65, 80, 50, 50);    // US dollar bill RGB
     rect(3*width/4 - 100, 7*height/8 - acct_valu_o, 300, 10);
     
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...    static vertical tubes
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

     for (int iqx = 0; iqx < eqty.length; iqx++)
     {
         fill(red[iqx], grn[iqx], blu[iqx], 50);
         rect(x_loc[iqx] - 25, height/4, 50, height-height/2);
     }
     
/* ... zero reference lines        */
     
     fill(65, 80, 50, 50);
     rect(x_loc[0]-50, height/2, (x_loc[eqty.length-1]-x_loc[0])+100, 5);

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...    logo & text
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    draw_cube();
    
    add_text();
     
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...    ir = row count in Table data (each day is one row)
/* ...    ic = column count in Table data (~250 trading days in a year)
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    ir++;
    if (ir > day_length) {ic++; ir = 0;}    // when day completed, go to next day
    if (ic > year_length) { ic = 0; }        // when year completed, restart

}


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* draw_element()
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void draw_element(int j, float x, float y, float s, int r, int g, int b)
{
    fill(r, g, b);
    ellipse(x, y, s, s);
}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* display date
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void display_date()
{
    
PFont f;
String s = "";
f = createFont("Ubuntu", int(0.04 * min(width, height)), true);
textFont(f);
textAlign(LEFT);
smooth();
fill(150, 150, 150);

    s = valu[0].getString(ir, 0);
    text(s, 3*width/4-50, height/2-50);
}