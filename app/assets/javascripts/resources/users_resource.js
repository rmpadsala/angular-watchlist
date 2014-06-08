watchlistApp.factory('UsersResource', ['$resource', function($resource) {
  // return $resource("/users/:user_id/:watched_symbols/:id.json", {id: '@id'});
  return $resource("/users/:id.json", {id: '@id'});
}]);
