class Node {


  float xPos = random(50, width - 50);
  float yPos = random(50, height - 200);
  PVector nodePos = new PVector(xPos, yPos);
  float ySpeed;
  float xSpeed; 
  float timer; 
  float eventDist;
  float cooldown;
  int radius = 10;
  float currentTime, sickTime = random(15000, 20000), currentSickTime, damageTime = 1000, collisionTime; 
  boolean hit= false, infected = false, alive = true, collision = false;
  boolean coachella = false;
  int immunity = int(random(10, 40));
  boolean immune = false;
  int maxhealth = int(random(50, 100)), health;
  float infectRate = int(random(30, 50));
  int infectBonus;
  int damage;
  float immuneDuration;
  color col = color(255);

  void Initialise() {
    if (immunity > 60) {
      col = color(0, 0, 255);
    }
    health = maxhealth;
  }
  void Update() {
    
    ySpeed = random(-0.5, 0.5);
    xSpeed = random(-0.5, 0.5);
    timer = random(2000, 5000);
    currentTime = millis();
    
    if(immunity > 40) {
        immunity -= 5;
       
    } 
    
    if(infected == false) {
        health+= 5;
        
        if(health > maxhealth) {
            health = maxhealth;
        }
    }
    
    
  }


  void Display() {
    
    if(coachella == false) {
      
        nodePos.x += xSpeed;
    nodePos.y += ySpeed;
    } else {
    
        nodePos.x = lerp(nodePos.x, eventPos.x - eventDist, 0.003);
        nodePos.y = lerp(nodePos.y, eventPos.y - eventDist, 0.003);
    }

    

    if(infected == false) {
      
      if(immunity > 65) {
         col = color(0,255, 0);
      } else {
        col = color(255);
        immune = false;
      }
    }
    noStroke();
    fill(col);
    ellipse(nodePos.x, nodePos.y, radius, radius);

    
    if (nodePos.x > width-50 || nodePos.x < 50) {

      xSpeed *= -1;
    }

    if (nodePos.y > height-200 || nodePos.y < 50) {

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
          node.cooldown = millis();
          
          node.Infected(infectRate + infectBonus);
          //node.col = color(255, 0, 0);
          node.damage = damage;
        }
      }
    }
    
    
        
    
    if(health <= 0) {
        
      infected = false;
        alive = false;
        //deadCount++;
        //nodeCount--;
        //infectedCount--;
    }
  }

  void Count() {


    if (millis() > currentTime + timer) {

      Update();
    }

    if (infected) {

      if(millis() > currentSickTime + damageTime) {
          health-=damage;
          damageTime +=1000;
       }
       
      if (millis() > currentSickTime + sickTime) {

        immune = true;
        infected = false;
        immunity = int(random(60, 90));
        //infectedCount--;
        
        damageTime = 1000;
        
      }
    }
    
    if(hit) {
    
        if(millis() > cooldown + 500) {
        
            hit = false;
        }
    }
    
    if(coachella) {
    
        if(millis() > eventTimer + 10000) {
        
            coachella = false;
            eventInProgress = false;
        }
    }
    
    
  }

  void Infected(float infectChance) {

    
    int roll = int(random(immunity, 100));


    if (roll < infectChance + infectBonus) {
      //infectedCount++;
      immune = false;
      infected = true;
      currentSickTime = millis();
      
      
    }
  }
}
