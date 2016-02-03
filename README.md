# conwaysgameoflife

> Conway's Game of Life in Angular

[![GitHub tag](https://img.shields.io/github/tag/kuatsure/conwaysgameoflife.svg?style=flat-square)]()
[![GitHub issues](https://img.shields.io/github/issues/kuatsure/conwaysgameoflife.svg?style=flat-square)](https://waffle.io/kuatsure/conwaysgameoflife)
[![David](https://img.shields.io/david/kuatsure/conwaysgameoflife.svg?style=flat-square)]()
[![Built With Grunt](http://img.shields.io/badge/built%20with-grunt-fcaa31.svg?style=flat-square)](http://gruntjs.com/)

## Requirements

* node
* ruby / bundler

Bundler can be installed via:

```sh
$ gem install bundler
```

## Install

```sh
$ npm install; bower install; bundle install;
```

_Depending on your set up you may need to install `grunt-cli` & `bower` globally as well._

Install those via:

```sh
$ npm install -g grunt-cli bower
```

## Development

Want to run the project locally?

```sh
$ grunt serve
```

## How to Play

### New Game

You can start a new game by pressing `New Game` to clear the board and start a new game. Also the game can be completely random by toggling the box next to the button.

### Next Generation

You can step through the generations via the `Next Generation` button. Toggling the box next to that will start the `AutoRun` interval. You can then stop it whenever using the `Stop AutoRun` button.

### Neat things

You can also travel back in time using the `history` section. Also clicking on a square in the board will toggle that cell to be alive. Animations are provided by CSS transitions & the `$interval` service in angular. Board size and `$interval` ( in milliseconds ) can be set as well - to apply it to the game just hit `New Game`.
