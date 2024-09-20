int nc = 100;

float[] cx = new float[nc];
float[] vx = new float[nc];

float[] cy = new float[nc];
float[] vy = new float[nc];


void setup()
 {
    size(800, 800, P3D);
    surface.setResizable(true);
    for (int i = 0; i < nc; ++i) 
    {
        
  
    cx[i] = width/2;
    cy[i] = height/2;
    vx[i] = (random(1,15));
    vy[i] = (random(1,13));
    }


}

void draw() {
    background(color(100,0,120));
   
    fill(255, 200, 230, 100);
    for (int i = 0; i < nc; ++i) 
    {
    
    circle(cx[i], cy[i], 40);
    cx[i] = cx[i] + vx[i];
    cy[i] = cy[i] + vy[i];

    if(cx[i] > width||cx[i] < 0 ) vx[i] = vx[i] * -1;
    if(cy[i] > height||cy[i] < 0 ) vy[i] = vy[i] * -1;
    }
    
    
}