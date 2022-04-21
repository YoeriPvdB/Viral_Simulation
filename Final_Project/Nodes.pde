class Node {


  float xPos = random(50, 950);
  float yPos = random(50, 950);
  PVector nodePos = new PVector(xPos, yPos);
  float ySpeed;
  float xSpeed; 
  float timer; 
  int radius = 10;
  float currentTime, sickTime = random(10000, 20000), currentSickTime, damageTime = 1000; 
  boolean hit= false, infected = false, alive = true;

  int immunity = int(random(10, 70));
  int health = int(random(50, 100));
  float infectRate = int(random(60, 90));
  float immuneDuration;
  color col = color(255);

  void Initialise() {
    if (immunity > 60) {
      col = color(0, 0, 255);
    }
  }
  void Update() {
    if (hit) {
      hit = false;
    }
    ySpeed = random(-0.5, 0.5);
    xSpeed = random(-0.5, 0.5);
    timer = random(2000, 5000);
    currentTime = millis();
    
    
  }


  void Display() {

    nodePos.x += xSpeed;
    nodePos.y += ySpeed;

    if(immunity > 70) {
      col = color(0,255, 0);
    }
    fill(col);
    ellipse(nodePos.x, nodePos.y, radius, radius);

    
    if (nodePos.x > 950 || nodePos.x < 50) {

      xSpeed *= -1;
    }

    if (nodePos.y > 950 || nodePos.y < 50) {

      ySpeed *= -1;
    }
    
    if (infected) {

      col = color(255, 0, 0);
      for (Node node : nodes) {

        float dist = dist(nodePos.x, nodePos.y, node.nodePos.x, node.nodePos.y);

        if (dist < radius && node.hit == false && node.infected == false) {
          xSpeed *= -1;
          ySpeed *= -1;
          node.hit = true;
          node.Infected(infectRate);
          //node.col = color(255, 0, 0);
        }
      }
    }
    
    
    
    if(health <= 0) {
    
        alive = false;
    }
  }

  void Count() {


    if (millis() > currentTime + timer) {

      Update();
    }

    if (infected) {

      if(millis() > currentSickTime + damageTime) {
          health-=virusDamage;
          damageTime +=1000;
       }
       
      if (millis() > currentSickTime + sickTime) {

        infected = false;
        immunity = int(random(60, 90));
        damageTime = 1000;
        
      }
    }
  }

  void Infected(float infectChance) {

    println(immunity);
    int roll = int(random(immunity, 100));


    if (roll < infectChance) {
      infected = true;
      currentSickTime = millis();
      
    }
  }
}
