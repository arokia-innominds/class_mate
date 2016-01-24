App.factory('Homes', ['$resource',function($resource){
  return $resource('/homes.json', {},{
    query: { method: 'GET' }
  })
}]);

App.factory('ClassRooms', ['$resource',function($resource){
  return $resource('/class_rooms.json', {},{
    query: { method: 'GET', isArray: true },
  })
}]);

App.factory('ClassRoom', ['$resource', function($resource){
  return $resource('/class_rooms/:id.json', {}, {
    show: { method: 'GET' }
  });
}]);

App.controller("ClassRoomShow", ['$scope', '$http', '$resource', 'ClassRoom', 'ClassRoomAssignments', '$location', '$routeParams', function($scope, $http, $resource, ClassRoom, ClassRoomAssignments, $location, $routeParams) {
  $scope.classroom = ClassRoom.get({id: $routeParams.id});
  $scope.assignment = ClassRoomAssignments.assignments({id: $routeParams.id});
}]);

App.controller("HomeIndex", ['$scope', '$http', '$resource', '$Homes', '$location', function($scope, $http, $resource, Homes, $location) {
  $scope.classroom = Homes.query();
}]);

App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/class_room/:id', {
      templateUrl: '/templates/class_rooms/show.html',
      controller: "ClassRoomShow"
    });
    $routeProvider.when('/', {
      templateUrl: '/templates/class_rooms/index.html',
      controller: "HomeIndex"
    });
  }
]);