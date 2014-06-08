// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require angular
//= require angular-route
//= require angular-resource
//= require underscore
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_self
//= require_tree .

var watchlistApp = angular.module('watchlistapp', ['ngRoute', 'ngResource']);
var pusher = new Pusher('8b52ba02200b254bc513');
var channel = pusher.subscribe('quotes_channel');

watchlistApp.config(['$httpProvider', '$routeProvider', function($httpProvider, $routeProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name=csrf-token]').content

  $routeProvider
    .when('/', {
      // Q: Is this the right way to handle multiple views in single template
      templateUrl: '/assets/home.html',
      // templateUrl: '/assets/users.html',
      controller: 'UsersCtrl'
    })
    .when('/user/:user_id/watched_symbols', {
      templateUrl: '/assets/home.html',
      // templateUrl: '/assets/watch_list.html',
      controller: 'WatchlistCtrl'
    })
    .otherwise({
      redierctTo: '/'
    })
}]);

// Q: How to manage multiple controllers for single template, for instance I want to display watchlistctrl and
// usersctrl on root route
// Q: By using routes template do we loose ability to use rails helpers (for example link_to) in views?
// Q: I am little bit confused on overall concept of routes. I can technically create single page application by
// just providing one view on server and mimic the same behavior by using resources....so what is the advantage
// of using routes??
// Q: How to create unique events
