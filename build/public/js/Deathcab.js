(function() {
  var bindChoiceHandler, clearPrompt, fsm, setupScenery;

  fsm = StateMachine.create({
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
        return console.log("You choose " + mode);
      }
    }
  });

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
        fsm.start(choice);
        $(event.target).off();
        clearPrompt();
        $('#intro').css('opacity', 0);
        $('#hints').addClass('visible');
        return $('#scenery').removeClass('dimmed');
      }
    });
    return $('#prompt').on('click', function(event) {
      return $('#prompt').focus();
    });
  };

  clearPrompt = function() {
    return $('#prompt input').val("");
  };

  setupScenery = function() {
    var ASPECT, FAR, HEIGHT, NEAR, VIEW_ANGLE, WIDTH, camera, lineMaterial, renderer, scene, scenery, sphere;
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
    lineMaterial = new THREE.MeshBasicMaterial({
      color: 0xFFFFFF,
      wireframe: true
    });
    sphere = new THREE.Mesh(new THREE.SphereGeometry(50, 16, 16), lineMaterial);
    scene.add(sphere);
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR);
    camera.position.z = 300;
    scene.add(camera);
    scenery.append(renderer.domElement);
    return renderer.render(scene, camera);
  };

}).call(this);
