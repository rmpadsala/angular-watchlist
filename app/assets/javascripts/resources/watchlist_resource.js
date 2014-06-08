watchlistApp.factory('WatchedSymbolsResource', ['$resource', function($resource) {
  return $resource("/watched_symbols/:id.json", {id: '@id'});
}]);
