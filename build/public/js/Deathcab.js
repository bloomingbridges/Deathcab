(function() {
  var Taxi, Vehicle, bindChoiceHandler, clearPrompt, fsm, setupScenery,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  fsm = StateMachine.create;

  Vehicle = (function() {
    Vehicle.prototype.forwards = [1, 0];

    Vehicle.prototype.topSpeeds = [0, 10, 30, 50, 100];

    Vehicle.prototype.waypoints = [];

    Vehicle.prototype.gear = 0;

    function Vehicle() {
      var geometry, material;
      geometry = new THREE.SphereGeometry(50, 16, 16);
      material = new THREE.MeshBasicMaterial({
        color: 0xFFFFFF,
        wireframe: true
      });
      this.mesh = new THREE.Mesh(geometry, material);
    }

    Vehicle.prototype.update = function(dT) {
      this.mesh.position.x += forwards[0] * this.getSpeed * dT;
      return this.mesh.position.y += forwards[1] * this.getSpeed * dT;
    };

    Vehicle.prototype.getSpeed = function() {
      return this.topSpeeds[this.gear];
    };

    Vehicle.prototype.setGear = function(newGear) {
      var gear;
      if (!(newGear > 4)) {
        return gear = newGear;
      }
    };

    return Vehicle;

  })();

  Taxi = (function(_super) {
    __extends(Taxi, _super);

    Taxi.prototype.passenger = {
      name: "Howard"
    };

    function Taxi() {
      var geometry, material;
      geometry = new THREE.SphereGeometry(50, 16, 16);
      material = new THREE.MeshBasicMaterial({
        color: 0xFFB300
      });
      this.mesh = new THREE.Mesh(geometry, material);
      this.fsm = StateMachine.create({
        initial: 'parking',
        events: [
          {
            name: 'start',
            from: 'parking',
            to: 'driving'
          }, {
            name: 'stop',
            from: 'driving',
            to: 'parking'
          }
        ],
        callbacks: {
          onstart: function(event, from, to, mode) {
            return console.log("ENTERING " + mode);
          }
        }
      });
    }

    return Taxi;

  })(Vehicle);

  $(function() {
    console.log("Welcome to d e a t h c a b");
    setupScenery();
    bindChoiceHandler();
    return $('#prompt').focus();
  });

  bindChoiceHandler = function() {
    $('#prompt').on('keyup', function(event) {
      var choice, mode;
      choice = $(event.target).val();
      if (choice === "life" || choice === "death") {
        mode = choice;
        $(event.target).off();
        clearPrompt();
        $('#intro').css('opacity', 0);
        $('#hints').addClass('visible');
        return $('#scenery').removeClass('dimmed');
      }
    });
    $('#prompt_container').on('click', function(event) {
      return $('#prompt').focus();
    });
    $('#prompt').on('focus', function(event) {
      return $('#prompt_container').addClass('active');
    });
    $('#prompt').on('blur', function(event) {
      return $('#prompt_container').removeClass('active');
    });
    return $('#prompt_container').trigger('click');
  };

  clearPrompt = function() {
    return $('#prompt input').val("");
  };

  setupScenery = function() {
    var ASPECT, FAR, HEIGHT, NEAR, VIEW_ANGLE, WIDTH, camera, renderer, scene, scenery, taxi;
    scenery = $('#scenery');
    WIDTH = scenery.width();
    HEIGHT = scenery.height();
    VIEW_ANGLE = 45;
    ASPECT = WIDTH / HEIGHT;
    NEAR = 0.1;
    FAR = 10000;
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(WIDTH, HEIGHT);
    renderer.setClearColor(0x000000, 1);
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR);
    camera.position.z = 300;
    scene.add(camera);
    taxi = new Taxi();
    scene.add(taxi.mesh);
    scenery.append(renderer.domElement);
    return renderer.render(scene, camera);
  };

}).call(this);
