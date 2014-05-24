
# Deathcab

Deathcab is a text-based taxi driver simulation game which combines elements from Monkey Island, Desert Bus for Hope, Cart Life, Papers, Please!, Ted Marten's Fireplace and Breaking Bad.



## Installation

Deathcab is written in __CoffeeScript__ and uses __Gulp__ as a build system, but foremost you should install _NodeJS_ via the installer for your platform.
This will hopefully also install Node's package manager __NPM__.

First, install Gulp globally

```
$ sudo npm install -g gulp
```

Then clone this repository (if you haven't already) and navigate into the __Deathcab__ directory.

```
$ cd [PATH_TO_DEATHCAB]
```

Install all the dependencies required by the build system into the directory by running

```
$ npm install
```

That should do it. You will also need a web browser but I think that's a given.



## Development

In order to build and run __Deathcab__ _cd_ into the repository root and run

```
$ gulp
```

This will build the project and serve it at [localhost:8080](http://localhost:8080) until you stop the process (CTRL+C).

In order to continuously watch for changes and rebuild the source run (in a new window)

```
$ gulp develop
```



## To Do

There is quite a lot to do still..

- Define overall architecture
- Write a _more intricate_ city generator
- Write passenger transportation and chat system
- Write some test dialog for default passenger types
- See if radio functionality is a go
- Add blur / DOF post-processing effect
- Change to first-person perspective
- Produce assets (taxi interior, HUD, Skybox, buildings)
- Argue over GAME OVER scenario
- ...

