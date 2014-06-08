watchlistApp.controller('UsersCtrl', ['$scope', 'UsersResource', 'SharedResource',
  function($scope, UsersResource, SharedResource) {
    $scope.shared = SharedResource;
    $scope.shared.users = UsersResource.query(function(users) {
    });

    $scope.createNewUser = function(e) {
      e.preventDefault();
      UsersResource.save($scope.newUser, function(newUser) {
        $scope.shared.users.push(newUser);

        if ($scope.shared.users.length == 1) {
          $scope.shared.activeUserId = newUser.id;
        }
        $scope.newUser = "";
      },
      function(failure) {
        console.log("failed");
      })
    }
}]);
