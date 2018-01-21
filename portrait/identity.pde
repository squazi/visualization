
/* ref : https://processing.org/tutorials/text/  */

// The text strings

String[] message = {
  "SSN : 219-7F-6A29",
  "DOB: 13-Apr-1984",
  "ADDR: 116 Mesnil Ave",
  "CITY: St-Hilaire",
  "CP: 45201",
  "TAX STATUS: Pd",
  "FELONY CONVICT: No",
  "CITIZENSHIP: Yes",
  "ED: MSDS-SMU-2018",
  "REL STATUS: Married",
  "Non-stop cycled: 435 km",
  "Col max: l’Iseran–2770m",
  "Vin: Autard-Juline-2007",
  "LANG : English, French",
  "BP/RHR/BMI:115|75|54|23",
  "GOOGL SRCH:  "};
  
String title = "29 points of recognition";
PFont f;

void identity()
{

float[] rx = {0.428, 0.689, 0.310, 0.489, 0.560, 0.628, 0.793, 0.243, 0.319, 0.386, 0.518, 0.584, 0.712, 0.775, 0.864, 0.281, 0.337, 0.504, 0.604, 0.717, 0.802, 0.552, 0.433, 0.528, 0.589, 0.665, 0.560, 0.423, 0.670};
float[] ry = {0.812, 0.812, 0.746, 0.699, 0.713, 0.699, 0.736, 0.652, 0.657, 0.665, 0.657, 0.652, 0.665, 0.657, 0.642, 0.594, 0.537, 0.571, 0.561, 0.533, 0.589, 0.528, 0.414, 0.437, 0.437, 0.424, 0.386, 0.310, 0.310};

float[] rxs = new float[rx.length];
float[] rys = new float[ry.length];
  
int[] connect = {0, 2, 8, 7, 15, 10, 16, 22, 27, 23, 26, 24, 25, 28, 19, 20};
float x_connect;
float y_connect;

  coordinate_xform(rx, ry, rxs, rys);

/* ...  radii for text circles and great positioning circle        */

float rad_text = 0.025 * min(width, height);
float rad_ident = 0.475 * min(width, height);

float x_ref = 0.552;
float y_ref = 0.528;
float sf = min(width, height);
float x_cntr = x_ref * sf;
float y_cntr = (1- y_ref) * sf;
float xmsg;
float ymsg;

float theta_begin = 5 * PI / 4;
float theta_delta = -2 * PI / 30;
float theta = theta_begin - theta_delta;

/* ...  font settings        */

  f = createFont("Georgia", int(0.015 * min(width, height)), true);
  textFont(f);
  textAlign(CENTER);
  smooth();

  for (int imsg = 0; imsg < message.length; imsg++)
  {
      theta += theta_delta;
      xmsg = x_cntr + rad_ident * cos(theta);
      ymsg = y_cntr + rad_ident * sin(theta);
     
      x_connect = rxs[connect[imsg]];
      y_connect = rys[connect[imsg]];
      
      strokeWeight(0);
      stroke(249, 166, 2);
      line(xmsg, ymsg, x_connect, y_connect);
      
      print("identity xmsg, ymsg : ", x_cntr, y_cntr, rad_ident*cos(theta), xmsg, ymsg, "\n");

    translate(xmsg, ymsg);
  
    fill(130, 130, 120);
    stroke(0);

    ellipse(0, 0, rad_text*3.5, rad_text*3.5);
  
  // keep track of position along the curve
  
    float arclength = 0;
  
    // For every box
    
    float theta_text_begin = random(0, 2*PI);
    
      for (int ichar = 0; ichar < message[imsg].length(); ichar++)
      {
        // Instead of a constant width, we check the width of each character.
        
        char currentChar = message[imsg].charAt(ichar);
        float w = textWidth(currentChar);
    
        // Each box is centered so move half the width
        
        arclength += w/2;
        
        // Starting on the left side of the circle by adding PI
        
        float theta_text = PI/2 + arclength / rad_text + theta_text_begin;    
    
        pushMatrix();
        
        // Polar to cartesian coordinate conversion
        
        translate(rad_text*cos(theta_text), rad_text*sin(theta_text));
        
        // Rotate the box
        
        rotate(theta_text + PI/2); // rotation is offset by 90 degrees
        
        // Display the character
        
        fill(0);
        text(currentChar,0,0);
        popMatrix();
        
        // Move halfway again
        
        arclength += w/2;
        
      }
      translate(-xmsg, -ymsg);
    }
}