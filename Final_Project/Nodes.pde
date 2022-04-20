class Node {

    
    float xPos = random(50, 950);
    float yPos = random(50, 950);
    PVector nodePos = new PVector(xPos, yPos);
    float ySpeed;
    float xSpeed; 
    float timer; 
    float currentTime; 
    boolean hit= false;
    
    color col = color(255);
    void Update() {
      ySpeed = random(-0.5, 0.5);
      xSpeed = random(-0.5, 0.5);
      timer = random(2000, 5000);
      currentTime = millis();
   }
   
   
    void Display() {
      
      nodePos.x += xSpeed;
      nodePos.y += ySpeed;
      fill(col);
      ellipse(nodePos.x, nodePos.y, 10, 10);
      
      
      if(nodePos.x > 950 || nodePos.x < 50) {
      
        xSpeed *= -1;
      }
      
      if(nodePos.y > 950 || nodePos.y < 50) {
      
        ySpeed *= -1;
      }
      
      
    }
    
    void Count() {
        
      
      if(millis() > currentTime + timer) {
      
        Update();
      }
      
    }
    
    void Infected(float infectRadius) {
    
      
      float roll = random(0, 100);
      println("roll: " + roll);
      println("chance: " + infectRadius / 2);
      
      if(roll > infectRadius / 2) {
        col = color(255, 0, 0);
      }
      
      
    }
}
