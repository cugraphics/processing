// Processing Workshop - Intro to Procedural Graphics
// Prayash Thapa
// October 18, 2016

// Initialize our empty particle system
ArrayList<Particle> particles = new ArrayList();

// ************************************************************************************

void setup() {
  // Define a window size or go full screen!
  // size(800, 600);
  fullScreen();

  // Create new particles and add them to the system
  for (int i = 0; i < 200; i++) particles.add(new Particle());
}

// ************************************************************************************

void draw() {
  // Use an opaque rectangle to add a smooth fading effect
  fill(#ff005a, 80);
  rect(0, 0, width, height);

  // Render all particles!
  for (Particle p : particles) p.render();
}

// ************************************************************************************

// Particle blueprint
class Particle {

  // Parameters used to draw and animate the particles
  PVector position, velocity;
  float radius = 5;
  float mult = 1.5;
  float opacity;

  // Constructor - code that runs on initialization of the objects
  Particle() {
    position = new PVector(random(radius, width - radius), random(radius, height - radius));
    velocity = new PVector(mult * cos(random(TWO_PI)), mult * sin(random(TWO_PI)));
    opacity = random(5, 50);
  }

  // Logic update (physics & boundary checking)
  void update() {
    position.add(velocity);
    if (position.x < radius || position.x >= width - radius) velocity.x *= -1;
    if (position.y < radius || position.y >= height - radius) velocity.y *= -1;
  }

  // Actual render/drawing of the particles
  void render() {
    update();
    fill(#e4e4e4, opacity * 4); noStroke();
    ellipse(position.x, position.y, radius, radius);

    // Iterate through ALL other particles in the system
    for (int i = 1; i < particles.size(); i++) {
      Particle p2 = particles.get(i);

      // Calculate distance from current node to every other
      float dist = PVector.dist(position, p2.position);

      // Only draw connection if certain distance between nodes
      if (dist > 20 && dist < 100) {
        // Calculate average opacity between the two nodes and draw the connection out!
        float t = (opacity + p2.opacity) / 1.5;
        stroke(#e4e4e4, t); strokeWeight(1);
        line(position.x, position.y, p2.position.x, p2.position.y);
      }
    }
  }
}

// ************************************************************************************

// A simple reset using mouse click!
void mousePressed() {
  particles.clear();
  setup();
}
