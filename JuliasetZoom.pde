
float MAX_ITERATION = 1;

double tx = 10;
double ty = 10;

double zoom = 3f;

float  angle = 0.0;

float zoomFactor = 1;

float moveFactor = 1;

float defaultIterationFactor = 1.003;
float cif = 1.003; //currentInterationfactor

void setup() {
    size(768 ,768, P2D);
    colorMode(HSB);
    frameRate(60);

}

void draw() {

    double cR = -0.8;
    double cI = 0.155;
    loadPixels();

    angle += 0.005;

    MAX_ITERATION *= cif;
    zoomFactor *= 1.0007;
    moveFactor *= random(.95,1.1);

    if(frameCount == 1750 )  cif = 1.001;
    if(frameCount == 1900 )  cif = 1.0009;

    double w = -(pow(log(angle), - zoomFactor ) + 0.001);
    double h = (w * height) / width;

    double xMin = -w/(tx - moveFactor);
    double yMin = -h/(ty - moveFactor);

    double xMax = xMin + w;
    double yMax = yMin + h;

    double dx = (xMax - xMin) / width;
    double dy = (yMax - yMin) / height;

    double y = yMin;
    for (int j = 0; j < height; ++j) {
        double x = xMin;
        for (int i = 0; i < width; ++i) {
            
            int currentIteration = 0;

            double a = x;
            double b = y;

            while (currentIteration < MAX_ITERATION) {

                double aS = a * a;
                double bS = b * b;

                if (aS + bS > 4) {
                    break;
                }

                double twoAB = 2 * a * b;
                a = aS - bS + cR ;
                b = twoAB + cI;

                currentIteration++;
            }
             
             float value1 = map(MAX_ITERATION - currentIteration, 0, MAX_ITERATION/2, 0, 255);
           if(currentIteration >= MAX_ITERATION) {
               
                pixels[i + j*width] = color(value1, 120, value1);
            } else {
               
                 pixels[i + j*width] = color(255 - value1,255- value1, 255-value1);
            } 
            x += dx; 
        }
        y += dy;   
    }
    updatePixels();
}
