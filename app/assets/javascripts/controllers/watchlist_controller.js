
watchlistApp.controller('WatchlistCtrl', ['$scope', 'SharedResource',
  'WatchedSymbolsResource', '$routeParams',
  function($scope, SharedResource, WatchedSymbolsResource, $routeParams) {
    $scope.shared = SharedResource;
    $scope.shared.activeUserId = $routeParams.user_id;

    $scope.watchedItems = WatchedSymbolsResource.query(function(results) {
      for (i=0; i< results.length; ++i) {
        //  subscribe to product
        createPuserEvent(results[i].symbol, results[i].user_id);
      }
    });

    $scope.visible = function() {
      return $scope.shared.users.length > 0;
    }

    createPuserEvent = function(symbol, user_id) {
      var event = user_id + "_" + symbol;
      if (_.contains($scope.shared.subjects, event) == false) {
        $scope.shared.subjects.push(event);
        console.log('creating subject ' + event);
        channel.bind(event, pusherEventHandler);
      }
    }

    pusherEventHandler = function(data) {
      //Q : Why do I need to say $scope.item in order to force update on view??
      $scope.item = _.findWhere($scope.watchedItems, {
        user_id: data.user_id,
        symbol: data.symbol
      });

      console.log("Received Event " + JSON.stringify(data));
      if ($scope.item) {
        //find scoped item and update....
        $scope.item.last_price = data.last_price;
        $scope.item.change = data.change;
        $scope.item.updated_at = data.updated_at;
        console.log("Updated item " + JSON.stringify($scope.item));
        $scope.$apply();
      }
    }

    $scope.addNewTicker = function(e) {
      e.preventDefault();
      $scope.newTicker.user_id = $scope.shared.activeUserId;

      WatchedSymbolsResource.save($scope.newTicker,
        function(newTicker) {
          $scope.watchedItems.unshift(newTicker);
          createPuserEvent(newTicker.symbol, newTicker.user_id);
          $scope.newTicker = "";
        },
        function (failure) {
          console.log("Request failed, status: " + failure.status + ", text: " +
            failure.statusText);
          alert('Please enter valid symbol.');
        });
    }

    $scope.removeWatchedItem = function(e, index, item) {
      e.preventDefault();
      WatchedSymbolsResource.remove({id: item.id},
        function(success) {
          if (success.$resolved) {
            $scope.watchedItems.splice(index, 1);
          }
        },
        function(failure) {
          console.log("Request failed, status: " + failure.status + ", text: " +
            failure.statusText);
          alert("Please try again later.");
        });
    }

    // $scope.$watch('watchedItems', function(current, prev) {
    //   if (current.length != prev.length) {
    //     // first element is always new element
    //     //createPuserEvent(current[0].symbol, current[0].user_id);
    //   }
    // }, true);
}]);
